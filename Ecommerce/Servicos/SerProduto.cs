using Models;
using Newtonsoft.Json;
using Repositorios;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;

namespace Servicos
{
    public class SerProduto
    {
        public List<Produto> Obter(string top)
        {
            var list = new RepProduto().Obter(top);
            return list;
        }
        public List<Produto> Obter(string nome, string top)
        {
            var list = new RepProduto().Obter(nome, top);
            return list;
        }
        public List<Produto> ObterProdutosShop(string[] categorias, string top)
        {
            var list = new RepProduto().ObterProdutosShop(categorias, top, false);
            return list;
        }
        public List<Produto> ObterPorCategoria(int[] codsCategoria, string top)
        {
            var list = new RepProduto().ObterPorCategoria(codsCategoria, top);
            return list;
        }
        public Produto Obter(int codProduto, bool incluirCategoria = false)
        {
            var item = new RepProduto().Obter(codProduto, incluirCategoria);
            return item;
        }
        public Produto Obter(string nome, bool incluirCategoria = false, bool incluirObservacoes = false, bool incluirAvaliacoes = false)
        {
            var item = new RepProduto().ObterPorNome(nome, incluirCategoria: incluirCategoria, incluirObservacoes: incluirObservacoes, incluirAvaliacoes: incluirAvaliacoes);
            return item;
        }
        public Produto Cadastrar(Produto p)
        {
            if (Validar(p))
                return new RepProduto().Cadastrar(p);
            else
                return null;
        }
        public Produto Editar(Produto p)
        {
            if (Validar(p) && p.CodProduto > 0)
                return new RepProduto().Editar(p);
            else
                return null;
        }
        public bool Desabilitar(int codProduto)
        {
            return new RepProduto().Desabilitar(codProduto);
        }
        public bool Remover(int codProduto)
        {
            return new RepProduto().Remover(codProduto);
        }
        public bool CadastrarProdutoCategoria(int codProduto, int codCategoria)
        {
            return new RepProduto().CadastrarProdutoCategoria(codProduto, codCategoria);
        }
        public bool RemoverProdutoCategoria(int codProduto, int codCategoria)
        {
            return new RepProduto().RemoverProdutoCategoria(codProduto, codCategoria);
        }
        public JsonObject CalcularFrete(int codProduto, string cep)
        {
            if(codProduto <= 0 || cep.Length < 8)
                return new JsonObject { sucesso = false, mensagem = Util.MsgErroComum };
            
            var produto = new RepProduto().Obter(codProduto);
            using (var client = new HttpClient())
            {
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjZlMjhlMTU5Yjc0MWQ3MDhjZjYwMDFkOTBkZGY1M2U2YjhlNTI0M2NiMGQ2NGRkYzc3YjA0NTBkYWNjMDNjOWRkYzg4Y2MxY2I4ZWUxOGYxIn0.eyJhdWQiOiIxIiwianRpIjoiNmUyOGUxNTliNzQxZDcwOGNmNjAwMWQ5MGRkZjUzZTZiOGU1MjQzY2IwZDY0ZGRjNzdiMDQ1MGRhY2MwM2M5ZGRjODhjYzFjYjhlZTE4ZjEiLCJpYXQiOjE2MjIxNzU2MDYsIm5iZiI6MTYyMjE3NTYwNiwiZXhwIjoxNjUzNzExNjA2LCJzdWIiOiJhZDI2NzBjOS0wZTgwLTRiMzItYTY0OC00ZTI4YzdkZGQyY2QiLCJzY29wZXMiOlsiY2FydC1yZWFkIiwiY2FydC13cml0ZSIsImNvbXBhbmllcy1yZWFkIiwiY29tcGFuaWVzLXdyaXRlIiwiY291cG9ucy1yZWFkIiwiY291cG9ucy13cml0ZSIsIm5vdGlmaWNhdGlvbnMtcmVhZCIsIm9yZGVycy1yZWFkIiwicHJvZHVjdHMtcmVhZCIsInByb2R1Y3RzLWRlc3Ryb3kiLCJwcm9kdWN0cy13cml0ZSIsInB1cmNoYXNlcy1yZWFkIiwic2hpcHBpbmctY2FsY3VsYXRlIiwic2hpcHBpbmctY2FuY2VsIiwic2hpcHBpbmctY2hlY2tvdXQiLCJzaGlwcGluZy1jb21wYW5pZXMiLCJzaGlwcGluZy1nZW5lcmF0ZSIsInNoaXBwaW5nLXByZXZpZXciLCJzaGlwcGluZy1wcmludCIsInNoaXBwaW5nLXNoYXJlIiwic2hpcHBpbmctdHJhY2tpbmciLCJlY29tbWVyY2Utc2hpcHBpbmciLCJ0cmFuc2FjdGlvbnMtcmVhZCIsInVzZXJzLXJlYWQiLCJ1c2Vycy13cml0ZSIsIndlYmhvb2tzLXJlYWQiLCJ3ZWJob29rcy13cml0ZSJdfQ.jzGrkX9VyrupprD4K8B3jpadnYSsWknAH2_LyKgg25unm2qGk2Ar2I87P208aKNKxGVdsk7YHe4DWhjsKVUGtTMqVk18MQNBbcSDgVW73QJh16l6n0RzDkmBkCO_nuMTGk8ndXOqQp0jK9msWFwuFVFe5HIYFJVheviScmVBpxclBoeFgRqG8TrFJZUF2rUVjsrDkDryWFRpetp8y4L2YJPbQkqiS7PA4KuuSigE3uLvUX3AD4SYislCgFu2KIF0zEQnaLz-bWR-wTWeor1CHSzlUKNmmk0_u3yfJc4hgmV6wT9Mu4_dgDvC4xCAOXNlDJrDTYcSfY7CKKMjCfVyxdkXmx-bZLYymZq4FWJ7Lw9PgDoHiczcOVwxd4Zn9n25orNL0xa2n8rq0TK5fl0W_2d3f2BRnef9Qnw2sOkcBS0veeSVrKt-Rm2ncSGmiyTa2UeopnOo1WpZNtLB4I0xK0FfH067_knP24MfX-VIh_VeqTvUl0IL1Rw4xqn5Y0LUtjlL5iUy7f0k1pwUja3buP6_SFnYOUL0De5gDnKd0YAer7WVNc5XFSq6vFMagCo-UkzAMmR88_z1yD3tCVG5bwyE6RzRA2gFYusKrho9SYp0jOcYN8yLmh2XZ0Gx2Vf-q-dv-_ULqoFgYRwYCTtmm_G0ys-Krkfsz-f6LTDiAkg");
                var serializedBody = new StringContent(JsonConvert.SerializeObject(new
                {
                    from = new { postal_code = ConfigurationManager.AppSettings["CorreiosCEPOrigem"].ToString() },
                    to = new { postal_code = cep },
                    services = "1,2",
                    products = new[]
                    {
                        new
                        {
                            id = "x",
                            width = produto.Largura,
                            height = produto.Altura,
                            length = produto.Comprimento,
                            weight = produto.Peso,
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
                if (fretes.PAC == null)
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
                return new JsonObject { obj = new { Frete = fretes }, sucesso = true };
            }
        }
        private bool Validar(Produto p)
        {
            if (p.Nome == null)
                return false;
            else if (p.Nome.Length > 200)
                return false;

            if (p.CodTipoEmbalagem == '0')
                return false;

            return true;
        }
    }
}
