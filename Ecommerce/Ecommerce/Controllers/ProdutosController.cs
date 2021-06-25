using Microsoft.Ajax.Utilities;
using Models;
using Servicos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Ecommerce.Controllers
{
    public class ProdutosController : Controller
    {
        public ActionResult Categoria(string categoria)
        {
            ViewBag.Categoria = categoria;
            return View();
        }
        public ActionResult ObterProdutosPorCategoria(string categoria, bool maisCaros = false, bool maisBaratos = false)
        {
            var s = new SerProduto().ObterProdutosShop(new[] { categoria }, string.Empty).Where(x => x.OcultarProduto == false).ToList();
            if (maisCaros)
                s = s.OrderByDescending(x => x.Valor).ToList();
            else if (maisBaratos)
                s = s.OrderBy(x => x.Valor).ToList();
            else
                s = s.OrderByDescending(x => x.Relevancia).ToList();
            var categorias = s.SelectMany(x => x.Categorias).Where(x => x.CategoriaPrincipal == false).DistinctBy(x => x.Nome).OrderBy(x => x.Nome).ToList();
            ViewBag.CategoriasMenu = categorias;
            ViewBag.CategoriasMenuB = ViewBag.CategoriasMenu;
            ViewBag.Description = string.Empty;
            ViewBag.Keywords = string.Empty;
            if (categorias != null)
            {
                if(categorias.Count() > 0)
                {
                    var catsString = string.Join(",", categorias.Select(x => x.Descricao).ToArray()).Replace("ç", "c").Replace("ã", "a");
                    ViewBag.Description = "Todos os produtos relacionados " + catsString.Replace(","," ") + " em prata";
                    ViewBag.Keywords = "aio pratas," + catsString + ",prata";
                }
            }
            return PartialView("_Categoria", s);
        }
        public JsonResult BuscarProduto(string texto)
        {
            var result = new SerProduto().Obter(texto, "TOP 10").Where(x => x.OcultarProduto == false).ToList();

            return Json(new JsonObject { sucesso = true, obj = result }, JsonRequestBehavior.AllowGet);
        }
    }
}