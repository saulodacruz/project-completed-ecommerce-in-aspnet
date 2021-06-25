using Models;
using Repositorios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Servicos
{
    public class SerProdutoObservacoes
    {
        public List<ProdutoObservacoes> ObterPorProduto(int codProduto)
        {
            var list = new RepProdutoObservacoes().ObterPorProduto(codProduto);
            return list;
        }
        public ProdutoObservacoes Obter(int codProdutoObservacoes)
        {
            var list = new RepProdutoObservacoes().Obter(codProdutoObservacoes);
            return list;
        }
        public ProdutoObservacoes Cadastrar(ProdutoObservacoes p)
        {
            if (Validar(p))
                return new RepProdutoObservacoes().Cadastrar(p);
            return null;
        }
        public ProdutoObservacoes Editar(ProdutoObservacoes p)
        {
            if (Validar(p) && p.CodProdutoObservacoes > 0)
                return new RepProdutoObservacoes().Cadastrar(p);
            return null;
        }
        public bool Remover(int codProdutoObservacoes)
        {
            return new RepProdutoObservacoes().Remover(codProdutoObservacoes);
        }
        private bool Validar(ProdutoObservacoes p)
        {
            if (p.CodProduto <= 0)
                return false;

            if (p.Tipo == null)
                return false;
            else if (p.Tipo.Trim().Length == 0 || p.Tipo.Length > 50)
                return false;

            if (p.Nome == null)
                return false;
            else if (p.Nome.Trim().Length == 0 || p.Nome.Length > 50)
                return false;

            return true;
        }
    }
}
