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
    public class ClienteController : Controller
    {
        public ActionResult Clientes()
        {
            var usuarios = new SerUsuario().Obter();
            return View(usuarios);
        }
        public ActionResult Cliente(int codUsuario)
        {
            var usuario = new SerUsuario().ObterComPedidos(codUsuario);
            return View(usuario);
        }
        [HttpPost]
        public ActionResult Cliente(Usuario u)
        {
            ViewBag.Erro = string.Empty;
            var result = new SerUsuario().Editar(u);
            if (!result.sucesso)
            {
                ViewBag.Erro = result.mensagem;
                return View(u);
            }
            return RedirectToAction("Cliente", new { codUsuario = u.CodUsuario });
        }
        public ActionResult Remover(int codUsuario)
        {
            new SerUsuario().Remover(codUsuario);
            return RedirectToAction("Clientes");
        }
    }
}