using Models;
using Repositorios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Servicos
{
    public class SerLogStatusPedido
    {
        public List<LogStatusPedido> Obter(long codPedido)
        {
            var list = new RepLogStatusPedido().Obter(codPedido);
            return list;
        }
        public LogStatusPedido Cadastrar(LogStatusPedido l)
        {
            return new RepLogStatusPedido().Cadastrar(l);
        }
        public bool Remover(long codLogStatusPedido)
        {
            return new RepLogStatusPedido().Remover(codLogStatusPedido);
        }
        public List<StatusPedido> ObterListaStatus()
        {
            return new RepLogStatusPedido().ObterListaStatus();
        }
    }
}
