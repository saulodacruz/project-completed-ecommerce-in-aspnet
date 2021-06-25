using Models;
using Servicos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Ecommerce.Controllers
{
    public class InfluenciadoresController : Controller
    {
        public ActionResult Index()
        {
            return View(new List<Pedido>());
        }

        [HttpPost]
        public ActionResult Index(string codigo)
        {
            var pedidos = new SerPedido().ObterPorCupom(codigo);
            return View(pedidos);
        }
    }
}