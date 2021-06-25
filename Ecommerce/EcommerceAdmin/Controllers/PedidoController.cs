using Ecommerce.Models;
using Models;
using Servicos;
using Servicos.Wirecard;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EcommerceAdmin.Controllers
{
    [Authorize]
    public class PedidoController : Controller
    {
        public ActionResult Pedidos(int? codStatusPedido)
        {
            ViewBag.StatusPedido = new SerLogStatusPedido().ObterListaStatus();
            
            var pedidos = codStatusPedido > 0 ? new SerPedido().ObterPorStatus((int)codStatusPedido) : new SerPedido().Obter();
            return View(pedidos);
        }
        public ActionResult Pedido(long codPedido)
        {
            var s = new SerPedido();
            var w = new ConnectWirecard();
            var pedido = s.Obter(codPedido);
            ViewBag.Estorno = null;
            if (pedido.LogStatusPedido.Where(x => x.CodStatusPedido == (int)Util.StatusPedido.PedidoCancelado).Any())
                ViewBag.Estorno = s.ObterEstorno(pedido.CodPedido);
            ViewBag.Status = new SerLogStatusPedido().ObterListaStatus().OrderBy(x => x.CodStatusPedido).ToList();
            var pedidoWirecard = w.ObterPedido(pedido.IdWirecard);
            var viewModel = new ViewModelPedido
            {
                Pedido = pedido,
                PedidoWirecard = pedidoWirecard
            };
            return View(viewModel);
        }
        public ActionResult Atualizar()
        {
            new SerAtualizacaoStatusPedidos().Executar();
            return RedirectToAction("Pedidos");
        }
        [HttpPost]
        public JsonResult Salvar(LogStatusPedido l, Pedido p)
        {
            LogStatusPedido result = new LogStatusPedido();
            if (l != null)
            {
                l.Data = Util.DateTimeNowBR();
                new SerLogStatusPedido().Cadastrar(l);
            }
            if(p != null)
                new SerPedido().Salvar(p);

            return Json(new JsonObject { sucesso = true });
        }
        public JsonResult RemoverStatus(long codLogStatusPedido)
        {
            var result = new SerLogStatusPedido().Remover(codLogStatusPedido);
            if (result)
                return Json(new JsonObject { sucesso = true }, JsonRequestBehavior.AllowGet);
            else
                return Json(new JsonObject { sucesso = false, mensagem = Util.MsgErroComum }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult EnviarEmail(long codPedido)
        {
            if(new SerPedido().EnviarEmail(codPedido))
                return Json(new JsonObject { sucesso = true }, JsonRequestBehavior.AllowGet);
            else
                return Json(new JsonObject { sucesso = false, mensagem = Util.MsgErroComum }, JsonRequestBehavior.AllowGet);
        }
    }
}