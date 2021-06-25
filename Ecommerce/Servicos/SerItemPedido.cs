using Models;
using Repositorios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Servicos
{
    public class SerItemPedido
    {
        public List<ItemPedido> ObterPorPedido(long codPedido)
        {
            var list = new RepItemPedido().ObterPorPedido(codPedido);
            return list;
        }
        public bool Cadastrar(ItemPedido ic)
        {
            return new RepItemPedido().Cadastrar(ic);
        }
        public bool Remover(int codProduto, long codPedido)
        {
            return new RepItemPedido().Remover(codProduto, codPedido);
        }
    }
}
