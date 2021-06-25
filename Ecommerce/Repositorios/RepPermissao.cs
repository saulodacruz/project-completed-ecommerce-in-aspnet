using Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositorios
{
    public class RepPermissao
    {
        private readonly string connectionString = RepUtil.Producao ? ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString : ConfigurationManager.ConnectionStrings["ConnectionStringDev"].ConnectionString;

        public List<Permissao> ObterPorUsuario(int codUsuario)
        {
            var permissoes = new List<Permissao>();
            using (var dados = RepUtil.ExecuteReader($@"
                DECLARE @email varchar(50) = null
                IF(@email IS NULL)    
                BEGIN    
	            SELECT p.* FROM UsuarioPermissao up      
	            inner join Permissao p      
	            on up.CodPermissao = p.CodPermissao      
	            WHERE up.CodUsuario = @codUsuario      
                END    
                ELSE     
                BEGIN    
	            SELECT p.* FROM UsuarioPermissao up      
	            inner join Permissao p      
	            on up.CodPermissao = p.CodPermissao      
	            WHERE up.CodUsuario = (SELECT TOP 1 CodUsuario from Usuario where Email = @email)    
                END", 
                new[] { new SqlParameter("@codUsuario", codUsuario) }))
            {
                while (dados.Read())
                    permissoes.Add(PopularObjetoSemUsuarios(dados));
            }
            return permissoes;
        }
        public List<Permissao> ObterPorUsuario(string usuario)
        {
            var permissoes = new List<Permissao>();
            if (IsCPF(usuario))
            {
                using (var dados = RepUtil.ExecuteReader($@"
	                SELECT p.* FROM UsuarioPermissao up      
                    JOIN Permissao p ON up.CodPermissao = p.CodPermissao
                    WHERE up.CodUsuario = (SELECT TOP 1 CodUsuario FROM Usuario u JOIN Pessoa pe ON pe.CodPessoa = u.CodPessoa WHERE CPF = @cpf)",
                    new[] { new SqlParameter("@cpf", usuario)}))
                {
                    while (dados.Read())
                        permissoes.Add(PopularObjetoSemUsuarios(dados));
                }
            }
            else
            {
                using (var dados = RepUtil.ExecuteReader($@"
	                SELECT p.* FROM UsuarioPermissao up      
                    JOIN Permissao p ON up.CodPermissao = p.CodPermissao
                    WHERE up.CodUsuario = (SELECT TOP 1 CodUsuario FROM Usuario u JOIN Pessoa pe ON pe.CodPessoa = u.CodPessoa WHERE Email = @email)",
                    new[] { new SqlParameter("@email", usuario) }))
                {
                    while (dados.Read())
                        permissoes.Add(PopularObjetoSemUsuarios(dados));
                }
            }

            return permissoes;
        }
        public List<Permissao> ObterComUsuarios()
        {
            var permissoes = new List<Permissao>();
            using (var dados = RepUtil.ExecuteReader("SELECT * FROM Permissao"))
            {
                while (dados.Read())
                    permissoes.Add(PopularObjeto(dados));
            }
            return permissoes;
        }
        public List<Permissao> ObterSemUsuarios()
        {
            var permissoes = new List<Permissao>();
            using (var dados = RepUtil.ExecuteReader("SELECT * FROM Permissao"))
            {
                while (dados.Read())
                    permissoes.Add(PopularObjetoSemUsuarios(dados));
            }
            return permissoes;
        }
        public List<Usuario> ObterUsuarioPorPermissao(int codPermissao)
        {
            var usuarios = new List<Usuario>();
            using (var dados = RepUtil.ExecuteReader($@"SELECT u.* FROM UsuarioPermissao up  
                                                 INNER JOIN Usuario u  
                                                 ON up.CodUsuario = u.CodUsuario  
                                                 WHERE up.CodPermissao = @codPermissao",
                                                 new[] { new SqlParameter("@codPermissao", codPermissao) }))
            {
                while (dados.Read())
                {
                    usuarios.Add(new Usuario()
                    {
                        CodUsuario = Convert.ToInt32(dados["CodUsuario"]),
                        Email = dados["Email"].ToString()
                    });
                }
            }
            return usuarios;
        }
        public bool InserirPermissaoUsuario(List<Permissao> permissoes, int codUsuario)
        {
            if (codUsuario == 0)
                return false;
            RemoverUsuarioPermissaoPorUsuario(codUsuario);
            foreach (var permissao in permissoes)
            {
                RepUtil.ExecutaSQL(@"
                        DELETE FROM UsuarioPermissao WHERE CodPermissao = @codPermissao AND CodUsuario = @codUsuario
                        INSERT INTO UsuarioPermissao VALUES(@codUsuario, @codPermissao)",
                        new[] {
                            new SqlParameter("@codPermissao", permissao.CodPermissao),
                            new SqlParameter("@codUsuario", codUsuario),
                        });
            }
            return true;
        }
        public bool RemoverUsuarioPermissaoPorUsuario(int codUsuario)
        {
            return RepUtil.ExecutaSQL(@"DELETE FROM UsuarioPermissao  
	                                    WHERE CodUsuario = @codUsuario",
                                        new[] { new SqlParameter("@codUsuario", codUsuario) }) > 0;
        }
        private Permissao PopularObjetoSemUsuarios(SqlDataReader dados)
        {
            return new Permissao
            {
                CodPermissao = Convert.ToInt32(dados["CodPermissao"]),
                Nome = dados["Nome"].ToString(),
            };
        }
        private Permissao PopularObjeto(SqlDataReader dados)
        {
            return new Permissao
            {
                CodPermissao = Convert.ToInt32(dados["CodPermissao"]),
                Nome = dados["Nome"].ToString(),
                Usuarios = ObterUsuarioPorPermissao(Convert.ToInt32(dados["CodPermissao"]))
            };
        }
        public bool CadastrarUsuarioPermissao(int codUsuario, int[] codPermissoes)
        {
            try
            {
                int countSuccess = 0;
                RepUtil.ExecutaSQL("DELETE FROM UsuarioPermissao WHERE CodUsuario = @codUsuario", new[] { new SqlParameter("@codUsuario", codUsuario) });
                if (codPermissoes != null)
                {
                    foreach (int codPermissao in codPermissoes.ToList().Distinct().ToArray())
                    {
                        RepUtil.ExecutaSQL($@"
                            DELETE FROM UsuarioPermissao WHERE CodPermissao = @codPermissao AND CodUsuario = @codUsuario
                            INSERT INTO UsuarioPermissao VALUES(@codUsuario, @codPermissao)",
                            new[] {
                                new SqlParameter("@codPermissao", codPermissao),
                                new SqlParameter("@codUsuario", codUsuario)
                            });
                            countSuccess++;
                    }
                }
                return countSuccess == codPermissoes.Length;
            }
            catch
            {
                return false;
            }
        }
        public bool CadastrarUsuarioPermissao(int codUsuario, int codPermissao)
        {
            try
            {
                return RepUtil.ExecutaSQL($@"INSERT INTO UsuarioPermissao (CodUsuario, CodPermissao) 
                                             VALUES(@codUsuario,@codPermissao)",
                                             new[] {
                                                 new SqlParameter("@codUsuario", codUsuario),
                                                 new SqlParameter("@codPermissao", codPermissao)
                                             }) > 0;
            }
            catch
            {
                return false;
            }
        }
        private bool IsCPF(string cpf)
        {
            int[] multiplicador1 = new int[9] { 10, 9, 8, 7, 6, 5, 4, 3, 2 };
            int[] multiplicador2 = new int[10] { 11, 10, 9, 8, 7, 6, 5, 4, 3, 2 };
            string tempCpf;
            string digito;
            int soma;
            int resto;
            cpf = cpf.Trim();
            cpf = cpf.Replace(".", "").Replace("-", "");
            if (cpf.Length != 11)
                return false;
            tempCpf = cpf.Substring(0, 9);
            soma = 0;

            for (int i = 0; i < 9; i++)
                soma += int.Parse(tempCpf[i].ToString()) * multiplicador1[i];
            resto = soma % 11;
            if (resto < 2)
                resto = 0;
            else
                resto = 11 - resto;
            digito = resto.ToString();
            tempCpf = tempCpf + digito;
            soma = 0;
            for (int i = 0; i < 10; i++)
                soma += int.Parse(tempCpf[i].ToString()) * multiplicador2[i];
            resto = soma % 11;
            if (resto < 2)
                resto = 0;
            else
                resto = 11 - resto;
            digito = digito + resto.ToString();
            return cpf.EndsWith(digito);
        }
    }
}
