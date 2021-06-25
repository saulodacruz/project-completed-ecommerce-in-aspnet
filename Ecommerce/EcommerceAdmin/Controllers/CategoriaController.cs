using Models;
using Servicos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EcommerceAdmin.Controllers
{
    [Authorize]
    public class CategoriaController : Controller
    {
        readonly string erroCampos = "Cadastro não realizado. Revise os campos.";
        public ActionResult Categorias()
        {
            var categorias = new SerCategoria().Obter();
            return View(categorias);
        }
        public ActionResult Categoria(int? codCategoria)
        {
            if (codCategoria > 0)
            {
                var categoria = new SerCategoria().Obter((int)codCategoria);
                return View(categoria);
            }
            return View(new Categoria());
        }
        [HttpPost]
        public ActionResult Categoria(Categoria c)
        {
            Categoria categoria = new Categoria();
            if (c == null)
            {
                ViewBag.Erro = erroCampos;
                return View(categoria);
            }

            if (c.CodCategoria > 0)
                categoria = new SerCategoria().Editar(c);
            else
                categoria = new SerCategoria().Cadastrar(c);

            if (categoria == null)
            {
                ViewBag.Erro = erroCampos;
                return View(c);
            }
            else if (categoria.CodCategoria <= 0)
            {
                ViewBag.Erro = erroCampos;
                return View(c);
            }
            else
                return RedirectToAction("Categoria", new { codCategoria = categoria.CodCategoria });
        }
        public ActionResult Remover(int codCategoria)
        {
            new SerCategoria().Remover(codCategoria);
            return RedirectToAction("Categorias");
        }
        public ActionResult AdicionarProdutoCategoria(int codProduto, int codCategoria, bool categoriaPrincipal)
        {
            new SerCategoria().AdicionarProdutoCategoria(codProduto, codCategoria, categoriaPrincipal);
            return Redirect(Request.UrlReferrer.ToString());
        }
        public ActionResult RemoverProdutoCategoria(int codProduto, int codCategoria)
        {
            new SerCategoria().RemoverProdutoCategoria(codProduto, codCategoria);
            return Redirect(Request.UrlReferrer.ToString());
        }
    }
}