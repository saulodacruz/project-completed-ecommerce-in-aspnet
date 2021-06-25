using Models;
using Repositorios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Servicos
{
    public class SerAvaliacao
    {
        public Avaliacao Obter(int codAvaliacao)
        {
            var item = new RepAvaliacao().Obter(codAvaliacao);
            return item;
        }
        public List<Avaliacao> ObterPorProduto(int codProduto)
        {
            var list = new RepAvaliacao().ObterPorProduto(codProduto);
            return list;
        }
        public JsonObject Cadastrar(Avaliacao c)
        {
            if (Validar(c, out string msg))
            {
                var result = new RepAvaliacao().Cadastrar(c);
                if (result != null)
                {
                    return new JsonObject
                    {
                        sucesso = true,
                        obj = result
                    };
                }
                else
                {
                    return new JsonObject
                    {
                        sucesso = false,
                        mensagem = Util.MsgErroComum
                    };
                }
            }
            else
            {
                if (string.IsNullOrWhiteSpace(msg))
                {
                    return new JsonObject
                    {
                        sucesso = false,
                        mensagem = Util.MsgErroComum
                    };
                }
                else
                {
                    return new JsonObject
                    {
                        sucesso = false,
                        mensagem = msg
                    };
                }
            }
        }
        public JsonObject Editar(Avaliacao c)
        {
            if (Validar(c, out string msg) && c.CodAvaliacao > 0)
            {
                var result = new RepAvaliacao().Editar(c);
                if (result != null)
                {
                    return new JsonObject
                    {
                        sucesso = true,
                        obj = result
                    };
                }
                else
                {
                    return new JsonObject
                    {
                        sucesso = false,
                        mensagem = Util.MsgErroComum
                    };
                }
            }
            else
            {
                if (string.IsNullOrWhiteSpace(msg))
                {
                    return new JsonObject {
                        sucesso = false,
                        mensagem = Util.MsgErroComum
                    };
                }
                else
                {
                    return new JsonObject
                    {
                        sucesso = false,
                        mensagem = msg
                    };
                }                    
            }
        }
        public bool Remover(int codAvaliacao)
        {
            return new RepAvaliacao().Remover(codAvaliacao);
        }
        private bool Validar(Avaliacao a, out string msg)
        {
            msg = string.Empty;
            if (a.CodUsuario <= 0)
                return false;

            if (a.CodProduto <= 0)
                return false;

            if (a.Estrelas <= 0 || a.Estrelas > 5)
                return false;

            if (new RepAvaliacao().ObterPorProduto(a.CodProduto).Where(x => x.CodUsuario == a.CodUsuario).Any())
            {
                msg = "Você já avaliou este produto.";
                return false;
            }

            bool jaComprou = false;
            var pedidos = new RepPedido().ObterPorUsuario(a.CodUsuario);
            pedidos.ForEach(x =>
            {
                if (!jaComprou)
                {
                    if (x.ItensPedido.Where(z => z.CodProduto == a.CodProduto).Any())
                    {
                        jaComprou = true;
                        return;
                    }
                }
            });
            if (!jaComprou)
            {
                msg = "Você não pode avaliar um produto que você não comprou.";
                return false;
            }
            return true;
        }
    }
}
