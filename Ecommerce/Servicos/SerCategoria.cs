using Models;
using Repositorios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Servicos
{
    public class SerCategoria
    {
        public List<Categoria> Obter()
        {
            var list = new RepCategoria().Obter();
            return list;
        }
        public List<Categoria> ObterPorProduto(int codProduto)
        {
            var list = new RepCategoria().ObterPorProduto(codProduto);
            return list;
        }
        public List<Categoria> Obter(string texto, string top = "")
        {
            var list = new RepCategoria().Obter(texto, top);
            return list;
        }
        public Categoria Obter(int codCategoria)
        {
            var item = new RepCategoria().Obter(codCategoria);
            return item;
        }
        public Categoria Cadastrar(Categoria c)
        {
            if(Validar(c))
                return new RepCategoria().Cadastrar(c);
            return null;
        }
        public Categoria Editar(Categoria c)
        {
            if (Validar(c) && c.CodCategoria > 0)
                return new RepCategoria().Editar(c);
            return null;
        }
        public bool Desabilitar(int codCategoria)
        {
            return new RepCategoria().Desabilitar(codCategoria);
        }
        public bool Remover(int codCategoria)
        {
            return new RepCategoria().Remover(codCategoria);
        }
        public bool AdicionarProdutoCategoria(int codProduto, int codCategoria, bool categoriaPrincipal)
        {
            return new RepCategoria().AdicionarProdutoCategoria(codProduto, codCategoria, categoriaPrincipal);
        }
        public bool RemoverProdutoCategoria(int codProduto, int codCategoria)
        {
            return new RepCategoria().RemoverProdutoCategoria(codProduto, codCategoria);
        }
        private bool Validar(Categoria c)
        {
            if (c.Nome == null)
                return false;
            else if (c.Nome.Length == 0 || c.Nome.Length > 200)
                return false;

            return true;
        }
    }
}
