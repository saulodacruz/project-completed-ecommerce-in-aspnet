using Models;
using Newtonsoft.Json;
using Repositorios;
using Servicos;
using Servicos.Wirecard;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Diagnostics;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace Ecommerce.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Produto(string nomeProduto)
        {
            if (!string.IsNullOrWhiteSpace(nomeProduto))
            {
                nomeProduto = nomeProduto.Replace('-', ' ');
                var s = new SerProduto();
                var produto = s.Obter(nomeProduto, incluirCategoria: false, incluirObservacoes: true, incluirAvaliacoes: false);
                return View(produto);
            }
            return View(new Produto());
        }
        public JsonResult ObterAvaliacoes(int codProduto)
        {
            var result = new SerAvaliacao().ObterPorProduto(codProduto);
            return Json(new JsonObject { sucesso = true, obj = result }, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public JsonResult SalvarAvaliacao(Avaliacao a)
        {
            a.CodUsuario = Util.GetCodUsuario(Request);
            return Json(new SerAvaliacao().Cadastrar(a));
        }
        public ActionResult ObterProdutosPorCat(int[] codsCategoria, string nome)
        {
            ViewBag.GuidPage = Guid.NewGuid().ToString();
            ViewBag.Nome = nome;
            var produtos = new SerProduto().ObterPorCategoria(codsCategoria, "TOP 100").Where(x => x.OcultarProduto == false).OrderByDescending(x => x.Relevancia).ToList();
            return PartialView("_Produtos", produtos);
        }
        public JsonResult BuscarCategoria(string texto)
        {
            var result = new SerCategoria().Obter(texto, "TOP 10");
            return Json(new JsonObject { sucesso = true, obj = result }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult CalcularFrete(int codProduto, string cep)
        {
            var result = new SerProduto().CalcularFrete(codProduto, cep);
            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
}