using Ecommerce.Seguranca;
using Models;
using Servicos;
using Servicos.Wirecard;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace Ecommerce.Controllers
{
    [Authorize]
    [Permissoes(Roles = "Cliente")]
    public class PagamentoController : Controller
    {
        public ActionResult Pagamento(long codPedido)
        {
            int codUsuario = Util.GetCodUsuario(Request);
            if (codUsuario == 0)
            {
                FormsAuthentication.SignOut();
                return RedirectToAction("Login", "Usuario");
            }
            var pedido = new SerPedido().Obter(codPedido);

            if (pedido.CodUsuario != codUsuario)
                throw new Exception("Este pedido não percente a este usuário.");
            if (pedido.LogStatusPedido.OrderByDescending(x => x.Data).First().CodStatusPedido != (int)Util.StatusPedido.AguardandoFormaPagamento)
                throw new Exception("Pedido inválido para pagamento.");
            
            pedido.CodPedidoCripto = SerCriptografia.Encrypt(pedido.CodPedido.ToString());
            pedido.IdWirecardCripto = SerCriptografia.Encrypt(pedido.IdWirecard);

            return View(pedido);
        }
        [HttpPost]
        public JsonResult Finalizar(Pagamento p)
        {
            p.CodPedido = Convert.ToInt32(SerCriptografia.Decrypt(p.CodPedidoCripto));
            p.IdWirecardPedido = SerCriptografia.Decrypt(p.IdWirecardPedidoCripto);
            var result = new SerPagamento().Finalizar(p, Util.GetCodUsuario(Request));
            return Json(result);
        }
        public JsonResult ObterBoleto(string id)
        {
            try
            {
                var pagamento = new ConnectWirecard().ObterPagamento(id);
                if (Convert.ToDateTime(pagamento.FundingInstrument.Boleto.ExpirationDate).Date >= Util.DateTimeNowBR())
                    return Json(new JsonObject { sucesso = true, obj = pagamento._Links.Payboleto.PrintHref }, JsonRequestBehavior.AllowGet);
                else
                    return Json(new JsonObject { sucesso = false, mensagem = "O boleto está vencido. Para realizar a compra, faça um novo pedido." }, JsonRequestBehavior.AllowGet);
            }
            catch
            {
                return Json(new JsonObject { sucesso = false, mensagem = Util.MsgErroComum }, JsonRequestBehavior.AllowGet);
            }            
        }
        [AllowAnonymous]
        public ActionResult Contrato()
        {
            return View();
        }
    }
}