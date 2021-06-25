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
    public class CupomController : Controller
    {
        readonly string erroCampos = "Cadastro não realizado. Revise os campos.";
        public ActionResult Cupons()
        {
            var cupons = new SerCupom().Obter();
            return View(cupons);
        }
        public ActionResult Cupom(int? codCupom)
        {
            if (codCupom > 0)
            {
                var cupom = new SerCupom().Obter((int)codCupom);
                return View(cupom);
            }
            return View(new Cupom());
        }
        [HttpPost]
        public ActionResult Cupom(Cupom c)
        {
            Cupom cupom = new Cupom();
            if (c == null)
            {
                ViewBag.Erro = erroCampos;
                return View(cupom);
            }

            if (c.CodCupom > 0)
                cupom = new SerCupom().Editar(c);
            else
                cupom = new SerCupom().Cadastrar(c);

            if (cupom == null)
            {
                ViewBag.Erro = erroCampos;
                return View(c);
            }
            else if (cupom.CodCupom <= 0)
            {
                ViewBag.Erro = erroCampos;
                return View(c);
            }
            else
                return RedirectToAction("Cupom", new { codCupom = cupom.CodCupom });
        }
        public ActionResult Remover(int codCupom)
        {
            new SerCupom().Remover(codCupom);
            return RedirectToAction("Cupons");
        }
    }
}