using Models;
using Repositorios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Servicos
{
    public class SerImagemProduto
    {
        public List<ImagemProduto> Obter()
        {
            var list = new RepImagemProduto().Obter();
            return list;
        }
        public List<ImagemProduto> ObterPorProduto(int codProduto)
        {
            var list = new RepImagemProduto().ObterPorProduto(codProduto);
            return list;
        }
        public ImagemProduto Obter(int codImagemProduto)
        {
            var list = new RepImagemProduto().Obter(codImagemProduto);
            return list;
        }
        public ImagemProduto Cadastrar(ImagemProduto i)
        {
            if (Validar(i))
                return new RepImagemProduto().Cadastrar(i);
            return null;
        }
        public ImagemProduto Editar(ImagemProduto i)
        {
            if (Validar(i) && i.CodImagemProduto > 0)
                return new RepImagemProduto().Cadastrar(i);
            return null;
        }
        public bool Remover(int codImagemProduto)
        {
            return new RepImagemProduto().Remover(codImagemProduto);
        }
        private bool Validar(ImagemProduto i)
        {
            if (i.CodProduto <= 0)
                return false;

            if (i.Url == null)
                return false;
            else if (i.Url.Trim().Length == 0 || i.Url.Length > 300)
                return false;

            if (i.Ordem <= 0)
                return false;

            return true;
        }
    }
}
