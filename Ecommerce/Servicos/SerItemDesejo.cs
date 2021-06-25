using Models;
using Repositorios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Servicos
{
    public class SerItemDesejo
    {
        public List<ItemDesejo> Obter(int codUsuario)
        {
            var list = new RepItemDesejo().Obter(codUsuario, true);
            return list;
        }
        public bool Cadastrar(ItemDesejo ic)
        {
            return new RepItemDesejo().Cadastrar(ic);
        }
        public bool Remover(int codProduto, int codUsuario)
        {
            return new RepItemDesejo().Remover(codProduto, codUsuario);
        }
        public JsonObject JsonObter(int codUsuario)
        {
            var list = new RepItemDesejo().Obter(codUsuario, true);
            var itens = new List<JsonItemDesejo>();
            list.ForEach(x =>
            {
                itens.Add(new JsonItemDesejo
                {
                    cod = x.CodProduto,
                    nome = x.Produto.Nome,
                    url = $"/Produto/{x.Produto.Nome.Replace(" ", "-")}",
                    urlImg = x.Produto.UrlImgA,
                    valor = x.Produto.Valor
                });
            });
            return new JsonObject { obj = itens, sucesso = true};
        }
        public JsonObject AtualizarItens(List<JsonItemDesejo> itens, int codUsuario)
        {
            itens = itens ?? new List<JsonItemDesejo>();
            try
            {
                var r = new RepItemDesejo();
                var itensDB = r.Obter(codUsuario, true).ToList();
                itensDB.ForEach(y =>
                {
                    itens.Add(new JsonItemDesejo
                    {
                        cod = y.CodProduto,
                        nome = y.Produto.Nome,
                        url = $"/Produto/{y.Produto.Nome.Replace(" ", "-")}",
                        urlImg = y.Produto.UrlImgA,
                        valor = y.Produto.Valor
                    });
                });

                var listaFinal = new List<JsonItemDesejo>();
                var listDistinct = itens.GroupBy(x => new { x.cod })
                                    .Select(x => x.First())
                                    .ToList();
                listDistinct.ForEach(item =>
                {
                    var itemFinal = new JsonItemDesejo {
                        cod = item.cod,
                        nome = item.nome,
                        url = item.url,
                        urlImg = item.urlImg,
                        valor = item.valor
                    };
                    listaFinal.Add(itemFinal);
                });                

                var itensTratados = new List<ItemDesejo>();
                listaFinal.ForEach(x =>
                {
                    itensTratados.Add(new ItemDesejo
                    {
                        CodUsuario = codUsuario,
                        CodProduto = x.cod
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
        public JsonObject RemoverItem(int codProduto, int codUsuario)
        {
            try
            {
                bool result = new RepItemDesejo().RemoverItemDesejo(codProduto, codUsuario);
                return new JsonObject { sucesso = true };
            }
            catch
            {
                return new JsonObject { mensagem = Util.MsgErroComum, sucesso = false };
            }
        }
        public JsonObject AdicionarItem(int codUsuario, int codProduto)
        {
            try
            {
                bool result = new RepItemDesejo().AdicionarItemDesejo(codUsuario, codProduto);
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
