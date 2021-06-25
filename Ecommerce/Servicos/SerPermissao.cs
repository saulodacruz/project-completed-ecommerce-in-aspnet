using Models;
using Repositorios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Servicos
{
    public class SerPermissao
    {
        public List<Permissao> ObterPorUsuario(int codUsuario)
        {
            var list = new RepPermissao().ObterPorUsuario(codUsuario);
            return list;
        }
        public List<Permissao> ObterPorUsuario(string email)
        {
            var list = new RepPermissao().ObterPorUsuario(email);
            return list;
        }
        public List<Permissao> ObterComUsuarios()
        {
            var list = new RepPermissao().ObterComUsuarios();
            return list;
        }
        public List<Permissao> ObterSemUsuarios()
        {
            var list = new RepPermissao().ObterSemUsuarios();
            return list;
        }
        public List<Usuario> ObterUsuarioPorPermissao(int codPermissao)
        {
            var list = new RepPermissao().ObterUsuarioPorPermissao(codPermissao);
            return list;
        }
        public bool InserirPermissaoUsuario(List<Permissao> permissoes, int codUsuario)
        {
            return new RepPermissao().InserirPermissaoUsuario(permissoes, codUsuario);
        }
        public bool RemoverUsuarioPermissaoPorUsuario(int codUsuario)
        {
            return new RepPermissao().RemoverUsuarioPermissaoPorUsuario(codUsuario);
        }
        public bool CadastrarUsuarioPermissao(int codUsuario, int[] codPermissoes)
        {
            return new RepPermissao().CadastrarUsuarioPermissao(codUsuario, codPermissoes);
        }
        public bool CadastrarUsuarioPermissao(int codUsuario, int codPermissao)
        {
            return new RepPermissao().CadastrarUsuarioPermissao(codUsuario, codPermissao);
        }
    }
}
