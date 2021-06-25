using Models;
using Repositorios;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MoreLinq;
using System.Web.Script.Serialization;
using System.Net.Http;
using System.Net.Http.Headers;
using Newtonsoft.Json;

namespace Servicos
{
    public class SerItemCarrinho
    {
        public List<ItemCarrinho> Obter(int codUsuario)
        {
            var list = new RepItemCarrinho().Obter(codUsuario, true);
            return list;
        }
        public bool Cadastrar(ItemCarrinho ic)
        {
            return new RepItemCarrinho().Cadastrar(ic);
        }
        public bool Remover(int codProduto, int codUsuario)
        {
            return new RepItemCarrinho().Remover(codProduto, codUsuario);
        }
        public JsonObject JsonObter(int codUsuario)
        {
            var list = new RepItemCarrinho().Obter(codUsuario, true);
            var itens = new List<JsonItemCarrinho>();
            list.ForEach(x =>
            {
                itens.Add(new JsonItemCarrinho
                {
                    cod = x.CodProduto,
                    obs = x.Observacao,
                    qtd = x.Quantidade,
                    nome = x.Produto.Nome,
                    url = $"/Produto/{x.Produto.Nome.Replace(" ", "-")}",
                    urlImg = x.Produto.UrlImgASmall,
                    valor = x.Produto.Valor
                });
            });
            return new JsonObject { obj = itens, sucesso = true};
        }
        public JsonObject JsonObterCarrinhoFrete(int codUsuario)
        {
            var carrinho = new RepItemCarrinho().Obter(codUsuario, true);
            var itens = new List<JsonItemCarrinho>();
            carrinho.ForEach(x =>
            {
                itens.Add(new JsonItemCarrinho
                {
                    cod = x.CodProduto,
                    obs = x.Observacao,
                    qtd = x.Quantidade,
                    nome = x.Produto.Nome,
                    url = $"/Produto/{x.Produto.Nome.Replace(" ", "-")}",
                    urlImg = x.Produto.UrlImgASmall,
                    valor = x.Produto.Valor
                });
            });

            //Frete
            if (carrinho.Count() <= 0)
                return new JsonObject { obj = new { Carrinho = itens }, sucesso = true };

            var usuario = new SerUsuario().Obter(codUsuario);
            decimal pesoProdutos = 0;
            decimal valorTotal = 0;
            carrinho.ForEach(x =>
            {
                valorTotal += x.Produto.Valor * x.Quantidade;
                pesoProdutos += x.Quantidade * x.Produto.Peso;
            });
            if(valorTotal >= 160)
            {
                carrinho.ForEach(x =>
                {
                    x.Produto.FreteGratis = true;
                });
            };
            var maiorEmbalagem = carrinho.OrderBy(x => x.Produto.CodTipoEmbalagem).LastOrDefault().Produto.TipoEmbalagem;

            using (var client = new HttpClient())
            {
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjZlMjhlMTU5Yjc0MWQ3MDhjZjYwMDFkOTBkZGY1M2U2YjhlNTI0M2NiMGQ2NGRkYzc3YjA0NTBkYWNjMDNjOWRkYzg4Y2MxY2I4ZWUxOGYxIn0.eyJhdWQiOiIxIiwianRpIjoiNmUyOGUxNTliNzQxZDcwOGNmNjAwMWQ5MGRkZjUzZTZiOGU1MjQzY2IwZDY0ZGRjNzdiMDQ1MGRhY2MwM2M5ZGRjODhjYzFjYjhlZTE4ZjEiLCJpYXQiOjE2MjIxNzU2MDYsIm5iZiI6MTYyMjE3NTYwNiwiZXhwIjoxNjUzNzExNjA2LCJzdWIiOiJhZDI2NzBjOS0wZTgwLTRiMzItYTY0OC00ZTI4YzdkZGQyY2QiLCJzY29wZXMiOlsiY2FydC1yZWFkIiwiY2FydC13cml0ZSIsImNvbXBhbmllcy1yZWFkIiwiY29tcGFuaWVzLXdyaXRlIiwiY291cG9ucy1yZWFkIiwiY291cG9ucy13cml0ZSIsIm5vdGlmaWNhdGlvbnMtcmVhZCIsIm9yZGVycy1yZWFkIiwicHJvZHVjdHMtcmVhZCIsInByb2R1Y3RzLWRlc3Ryb3kiLCJwcm9kdWN0cy13cml0ZSIsInB1cmNoYXNlcy1yZWFkIiwic2hpcHBpbmctY2FsY3VsYXRlIiwic2hpcHBpbmctY2FuY2VsIiwic2hpcHBpbmctY2hlY2tvdXQiLCJzaGlwcGluZy1jb21wYW5pZXMiLCJzaGlwcGluZy1nZW5lcmF0ZSIsInNoaXBwaW5nLXByZXZpZXciLCJzaGlwcGluZy1wcmludCIsInNoaXBwaW5nLXNoYXJlIiwic2hpcHBpbmctdHJhY2tpbmciLCJlY29tbWVyY2Utc2hpcHBpbmciLCJ0cmFuc2FjdGlvbnMtcmVhZCIsInVzZXJzLXJlYWQiLCJ1c2Vycy13cml0ZSIsIndlYmhvb2tzLXJlYWQiLCJ3ZWJob29rcy13cml0ZSJdfQ.jzGrkX9VyrupprD4K8B3jpadnYSsWknAH2_LyKgg25unm2qGk2Ar2I87P208aKNKxGVdsk7YHe4DWhjsKVUGtTMqVk18MQNBbcSDgVW73QJh16l6n0RzDkmBkCO_nuMTGk8ndXOqQp0jK9msWFwuFVFe5HIYFJVheviScmVBpxclBoeFgRqG8TrFJZUF2rUVjsrDkDryWFRpetp8y4L2YJPbQkqiS7PA4KuuSigE3uLvUX3AD4SYislCgFu2KIF0zEQnaLz-bWR-wTWeor1CHSzlUKNmmk0_u3yfJc4hgmV6wT9Mu4_dgDvC4xCAOXNlDJrDTYcSfY7CKKMjCfVyxdkXmx-bZLYymZq4FWJ7Lw9PgDoHiczcOVwxd4Zn9n25orNL0xa2n8rq0TK5fl0W_2d3f2BRnef9Qnw2sOkcBS0veeSVrKt-Rm2ncSGmiyTa2UeopnOo1WpZNtLB4I0xK0FfH067_knP24MfX-VIh_VeqTvUl0IL1Rw4xqn5Y0LUtjlL5iUy7f0k1pwUja3buP6_SFnYOUL0De5gDnKd0YAer7WVNc5XFSq6vFMagCo-UkzAMmR88_z1yD3tCVG5bwyE6RzRA2gFYusKrho9SYp0jOcYN8yLmh2XZ0Gx2Vf-q-dv-_ULqoFgYRwYCTtmm_G0ys-Krkfsz-f6LTDiAkg");
                var serializedBody = new StringContent(JsonConvert.SerializeObject(new {
                    from = new { postal_code = ConfigurationManager.AppSettings["CorreiosCEPOrigem"].ToString() },
                    to = new { postal_code = usuario.CEP },
                    services = "1,2",
                    products = new[]
                    {
                        new
                        {
                            id = "x",
                            width = maiorEmbalagem.Largura,
                            height = maiorEmbalagem.Altura,
                            length = maiorEmbalagem.Comprimento,
                            weight = pesoProdutos + maiorEmbalagem.Peso,
                            quantity = 1
                        }
                     }
                }), Encoding.UTF8, "application/json");
                var request = Task.Run(() => client.PostAsync("https://melhorenvio.com.br/api/v2/me/shipment/calculate", serializedBody)).Result;
                var result = Task.Run(() => request.Content.ReadAsStringAsync()).Result;
                var freteObj = new JavaScriptSerializer().Deserialize<List<Fretes.Frete>>(result);
                var pac = freteObj.Where(x => x.name == "PAC").First();
                var sedex = freteObj.Where(x => x.name == "SEDEX").First();
                var fretes = new Fretes
                {
                    PAC = string.IsNullOrWhiteSpace(pac.error) ? pac : null,
                    SEDEX = string.IsNullOrWhiteSpace(sedex.error) ? sedex : null
                };
                if(fretes.PAC == null)
                {
                    fretes.PACValor = string.Empty;
                    fretes.PACPrazo = string.Empty;
                }
                else
                {
                    fretes.PACValor = SerCriptografia.Encrypt(fretes.PAC.price);
                    fretes.PACPrazo = SerCriptografia.Encrypt(fretes.PAC.delivery_time);
                }
                if (fretes.SEDEX == null)
                {
                    fretes.SEDEXValor = string.Empty;
                    fretes.SEDEXPrazo = string.Empty;
                }
                else
                {
                    fretes.SEDEXValor = SerCriptografia.Encrypt(fretes.SEDEX.price);
                    fretes.SEDEXPrazo = SerCriptografia.Encrypt(fretes.SEDEX.delivery_time);
                }
                return new JsonObject { obj = new { Carrinho = itens, Frete = fretes, FreteGratis = carrinho.Where(x => x.Produto.FreteGratis == false).Any() ? false : true }, sucesso = true };
            }
        }
        public JsonObject AtualizarCarrinho(List<JsonItemCarrinho> itens, int codUsuario)
        {
            itens = itens ?? new List<JsonItemCarrinho>();
            try
            {
                var r = new RepItemCarrinho();
                var itensDB = r.Obter(codUsuario, true).ToList();
                itensDB.ForEach(y =>
                {
                    itens.Add(new JsonItemCarrinho
                    {
                        cod = y.CodProduto,
                        obs = y.Observacao,
                        qtd = y.Quantidade,
                        nome = y.Produto.Nome,
                        url = $"/Produto/{y.Produto.Nome.Replace(" ", "-")}",
                        urlImg = y.Produto.UrlImgASmall,
                        valor = y.Produto.Valor
                    });
                });

                var listaFinal = new List<JsonItemCarrinho>();
                var listDistinct = itens.GroupBy(x => new { x.cod, x.obs })
                                    .Select(x => x.First())
                                    .ToList();
                listDistinct.ForEach(item =>
                {
                    var qtdTotal = itens.Where(x => x.cod == item.cod && x.obs == item.obs).Sum(x => x.qtd);
                    var itemFinal = new JsonItemCarrinho {
                        cod = item.cod,
                        nome = item.nome,
                        obs = item.obs,
                        qtd = qtdTotal,
                        url = item.url,
                        urlImg = item.urlImg,
                        valor = item.valor
                    };
                    listaFinal.Add(itemFinal);
                });                

                var itensTratados = new List<ItemCarrinho>();
                listaFinal.ForEach(x =>
                {
                    itensTratados.Add(new ItemCarrinho
                    {
                        CodUsuario = codUsuario,
                        CodProduto = x.cod,
                        Observacao = x.obs,
                        Quantidade = x.qtd
                    });
                });
                bool result = r.AtualizarCarrinho(itensTratados, codUsuario);
                if (result)
                    return new JsonObject { sucesso = true, obj = listaFinal };
                else
                    return new JsonObject { mensagem = Util.MsgErroComum, sucesso = false };
            }
            catch
            {
                return new JsonObject { mensagem = Util.MsgErroComum, sucesso = false };
            }
        }
        public JsonObject RemoverItem(int codProduto, string observacao, int codUsuario, int qtd)
        {
            try
            {
                bool result = new RepItemCarrinho().RemoverItemCarrinho(codProduto, observacao, codUsuario, qtd);
                return new JsonObject { sucesso = true };
            }
            catch
            {
                return new JsonObject { mensagem = Util.MsgErroComum, sucesso = false };
            }
        }
        public JsonObject AdicionarItem(int codUsuario, JsonItemCarrinho item, bool update)
        {
            try
            {
                bool result = new RepItemCarrinho().AdicionarItemCarrinho(codUsuario, item, update);
                if (result)
                    return new JsonObject { sucesso = true };
                else
                    return new JsonObject { mensagem = Util.MsgErroComum, sucesso = false };
            }
            catch
            {
                return new JsonObject { mensagem = Util.MsgErroComum, sucesso = false };
            }
        }
    }
}
