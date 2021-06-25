using Models;
using Repositorios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Servicos
{
    public class SerTipoEmbalagem
    {
        public List<TipoEmbalagem> Obter()
        {
            var list = new RepTipoEmbalagem().Obter();
            return list;
        }
        public TipoEmbalagem Obter(char codTipoEmbalagem)
        {
            var item = new RepTipoEmbalagem().Obter(codTipoEmbalagem);
            return item;
        }
        public TipoEmbalagem Cadastrar(TipoEmbalagem c)
        {
            if (Validar(c))
                return new RepTipoEmbalagem().Cadastrar(c);
            return null;
        }
        public TipoEmbalagem Editar(TipoEmbalagem c)
        {
            if (Validar(c) && c.CodTipoEmbalagem > 0)
                return new RepTipoEmbalagem().Editar(c);
            return null;
        }
        public bool Remover(char codTipoEmbalagem)
        {
            return new RepTipoEmbalagem().Remover(codTipoEmbalagem);
        }
        private bool Validar(TipoEmbalagem c)
        {
            if (c.Altura < 0)
                return false;
            if (c.Largura < 0)
                return false;
            if (c.Comprimento < 0)
                return false;
            if (c.Diametro < 0)
                return false;
            if (c.Peso < 0)
                return false;
            return true;
        }
    }
}
