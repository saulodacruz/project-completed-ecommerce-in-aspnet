using Models;
using Repositorios;
using Servicos.Wirecard;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;
using Wirecard.Models;

namespace Servicos
{
    public class SerAtualizacaoStatusPedidos
    {
        public void Executar()
        {
            AtualizarStatusPagamento();
            AtualizarStatusTransporte();
        }
        private void AtualizarStatusPagamento()
        {
            var rp = new RepPedido();
            var cw = new ConnectWirecard();
            List<Pedido> pedidosLocal = rp.ObterTodosPedidosNaoConcluidoPagto();
            var pedidosWire = new List<OrderResponse>();

            pedidosLocal.ForEach(x =>
            {
                pedidosWire.Add(cw.ObterPedido(x.IdWirecard));
            });

            var r = new RepLogStatusPedido();
            pedidosLocal.ForEach(pLocal =>
            {
                var pWire = pedidosWire.Where(x => x.Id == pLocal.IdWirecard).First();
                if (pWire.Payments != null)
                {
                    if (pWire.Payments.Count > 0)
                    {
                        var pagamento = pWire.Payments.OrderBy(x => x.CreatedAt).Last();
                        pagamento.Events.ForEach(x =>
                        {
                            switch (x.Type)
                            {
                                case "PAYMENT.WAITING":
                                    x.CreatedAt = x.CreatedAt.AddSeconds(1);
                                    break;
                                case "PAYMENT.IN_ANALYSIS":
                                    x.CreatedAt = x.CreatedAt.AddSeconds(2);
                                    break;
                                case "PAYMENT.PRE_AUTHORIZED":
                                    x.CreatedAt = x.CreatedAt.AddSeconds(3);
                                    break;
                                case "PAYMENT.AUTHORIZED":
                                    if (pagamento.FundingInstrument.Method == "CREDIT_CARD")
                                        x.CreatedAt = x.CreatedAt.AddHours(4).AddSeconds(4);
                                    else
                                        x.CreatedAt = x.CreatedAt.AddSeconds(4);
                                    break;
                                case "PAYMENT.CANCELLED":
                                    if (pagamento.FundingInstrument.Method == "CREDIT_CARD")
                                        x.CreatedAt = x.CreatedAt.AddHours(4).AddSeconds(5);
                                    else
                                        x.CreatedAt = x.CreatedAt.AddSeconds(5);
                                    break;
                                case "PAYMENT.REFUNDED":
                                    x.CreatedAt = x.CreatedAt.AddSeconds(6);
                                    break;
                                case "PAYMENT.REVERSED":
                                    x.CreatedAt = x.CreatedAt.AddSeconds(7);
                                    break;
                            }
                        });
                        pagamento.Events.ForEach(status =>
                        {
                            var statusLocal = new SerPagamento().ConvertStatusOfWirecardPayment(status.Type);
                            var s = pLocal.LogStatusPedido
                                    .Where(x => x.StatusPedido.CodStatusPedido == statusLocal)
                                    .FirstOrDefault();

                            if (s == null && status.Type != "PAYMENT.CREATED")
                            {
                                r.Cadastrar(new LogStatusPedido
                                {
                                    CodPedido = pLocal.CodPedido,
                                    CodStatusPedido = statusLocal,
                                    Data = status.CreatedAt
                                });
                            }
                        });
                    }
                }
            });
        }
        private void AtualizarStatusTransporte()
        {
            var rp = new RepPedido();
            var r = new RepLogStatusPedido();
            List<Pedido> pedidosLocal = rp.ObterTodosPedidosPagosNaoEntregues();
            using (var client = new HttpClient())
            {
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjZlMjhlMTU5Yjc0MWQ3MDhjZjYwMDFkOTBkZGY1M2U2YjhlNTI0M2NiMGQ2NGRkYzc3YjA0NTBkYWNjMDNjOWRkYzg4Y2MxY2I4ZWUxOGYxIn0.eyJhdWQiOiIxIiwianRpIjoiNmUyOGUxNTliNzQxZDcwOGNmNjAwMWQ5MGRkZjUzZTZiOGU1MjQzY2IwZDY0ZGRjNzdiMDQ1MGRhY2MwM2M5ZGRjODhjYzFjYjhlZTE4ZjEiLCJpYXQiOjE2MjIxNzU2MDYsIm5iZiI6MTYyMjE3NTYwNiwiZXhwIjoxNjUzNzExNjA2LCJzdWIiOiJhZDI2NzBjOS0wZTgwLTRiMzItYTY0OC00ZTI4YzdkZGQyY2QiLCJzY29wZXMiOlsiY2FydC1yZWFkIiwiY2FydC13cml0ZSIsImNvbXBhbmllcy1yZWFkIiwiY29tcGFuaWVzLXdyaXRlIiwiY291cG9ucy1yZWFkIiwiY291cG9ucy13cml0ZSIsIm5vdGlmaWNhdGlvbnMtcmVhZCIsIm9yZGVycy1yZWFkIiwicHJvZHVjdHMtcmVhZCIsInByb2R1Y3RzLWRlc3Ryb3kiLCJwcm9kdWN0cy13cml0ZSIsInB1cmNoYXNlcy1yZWFkIiwic2hpcHBpbmctY2FsY3VsYXRlIiwic2hpcHBpbmctY2FuY2VsIiwic2hpcHBpbmctY2hlY2tvdXQiLCJzaGlwcGluZy1jb21wYW5pZXMiLCJzaGlwcGluZy1nZW5lcmF0ZSIsInNoaXBwaW5nLXByZXZpZXciLCJzaGlwcGluZy1wcmludCIsInNoaXBwaW5nLXNoYXJlIiwic2hpcHBpbmctdHJhY2tpbmciLCJlY29tbWVyY2Utc2hpcHBpbmciLCJ0cmFuc2FjdGlvbnMtcmVhZCIsInVzZXJzLXJlYWQiLCJ1c2Vycy13cml0ZSIsIndlYmhvb2tzLXJlYWQiLCJ3ZWJob29rcy13cml0ZSJdfQ.jzGrkX9VyrupprD4K8B3jpadnYSsWknAH2_LyKgg25unm2qGk2Ar2I87P208aKNKxGVdsk7YHe4DWhjsKVUGtTMqVk18MQNBbcSDgVW73QJh16l6n0RzDkmBkCO_nuMTGk8ndXOqQp0jK9msWFwuFVFe5HIYFJVheviScmVBpxclBoeFgRqG8TrFJZUF2rUVjsrDkDryWFRpetp8y4L2YJPbQkqiS7PA4KuuSigE3uLvUX3AD4SYislCgFu2KIF0zEQnaLz-bWR-wTWeor1CHSzlUKNmmk0_u3yfJc4hgmV6wT9Mu4_dgDvC4xCAOXNlDJrDTYcSfY7CKKMjCfVyxdkXmx-bZLYymZq4FWJ7Lw9PgDoHiczcOVwxd4Zn9n25orNL0xa2n8rq0TK5fl0W_2d3f2BRnef9Qnw2sOkcBS0veeSVrKt-Rm2ncSGmiyTa2UeopnOo1WpZNtLB4I0xK0FfH067_knP24MfX-VIh_VeqTvUl0IL1Rw4xqn5Y0LUtjlL5iUy7f0k1pwUja3buP6_SFnYOUL0De5gDnKd0YAer7WVNc5XFSq6vFMagCo-UkzAMmR88_z1yD3tCVG5bwyE6RzRA2gFYusKrho9SYp0jOcYN8yLmh2XZ0Gx2Vf-q-dv-_ULqoFgYRwYCTtmm_G0ys-Krkfsz-f6LTDiAkg");
                pedidosLocal.ForEach(pedido =>
                {
                    var request = Task.Run(() => client.GetAsync($"https://melhorenvio.com.br/api/v2/me/orders/search?q={pedido.CodigoRastreio}")).Result;
                    var rastreio = new JavaScriptSerializer().Deserialize<List<Rastreio>>(Task.Run(() => request.Content.ReadAsStringAsync()).Result).First();
                    var statusLocal = new SerPedido().ConvertStatusOfMEnvio(rastreio.status);
                    if (pedido.LogStatusPedido.Where(x => x.CodStatusPedido == statusLocal).FirstOrDefault() == null)
                    {
                        r.Cadastrar(new LogStatusPedido
                        {
                            CodPedido = pedido.CodPedido,
                            CodStatusPedido = statusLocal,
                            Data = Util.DateTimeNowBR()
                        });
                    }
                });
            }
        }
        private class Rastreio
        {
            public string status { get; set; }
        }
    }
}
