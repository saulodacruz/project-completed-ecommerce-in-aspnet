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
    public class RepUsuario
    {
        public Usuario Cadastrar(Usuario u)
        {
            try
            {
                using (var dados = RepUtil.ExecuteReader($@"DECLARE @codEndereco INT, @codEnderecoCobranca INT, @codPessoa INT, @codUsuario INT;

                                                        INSERT INTO dbo.Endereco (Logradouro,CEP,Bairro,UF,Cidade,Numero,Complemento) 
                                                        VALUES (@logradouro,@cep,@bairro,@uf,@cidade,@numero,@complemento) 
                                                        SET @codEndereco = SCOPE_IDENTITY();

                                                        INSERT INTO dbo.Endereco (Logradouro,CEP,Bairro,UF,Cidade,Numero,Complemento) 
                                                        VALUES (@logradouro,@cep,@bairro,@uf,@cidade,@numero,@complemento) 
                                                        SET @codEnderecoCobranca = SCOPE_IDENTITY();

                                                        INSERT INTO dbo.Pessoa (Nome,CPF,DataNascimento,Telefone,CodEndereco,Sobrenome,CodEnderecoCobranca)
                                                        VALUES (@nome,@cpf,@dataNascimento,@telefone,@codEndereco,@sobrenome,@codEnderecoCobranca)
                                                        SET @codPessoa = SCOPE_IDENTITY();

                                                        INSERT INTO dbo.Usuario (Email,Senha,CodPessoa,DataExclusao,DataCadastro)
                                                        VALUES (@email,@senha,@codPessoa,NULL,@dataCadastro)
                                                        SELECT SCOPE_IDENTITY() CodUsuario", 
                                                        new[] {
                                                            new SqlParameter("@logradouro", u.Logradouro),
                                                            new SqlParameter("@cep", u.CEP),
                                                            new SqlParameter("@bairro", u.Bairro),
                                                            new SqlParameter("@uf", u.UF),
                                                            new SqlParameter("@cidade", u.Cidade),
                                                            new SqlParameter("@numero", u.Numero),
                                                            new SqlParameter("@complemento", u.Complemento ?? string.Empty),

                                                            new SqlParameter("@nome", u.Nome),
                                                            new SqlParameter("@cpf", u.CPF),
                                                            new SqlParameter("@dataNascimento", u.DataNascimento),
                                                            new SqlParameter("@telefone", u.Telefone),
                                                            new SqlParameter("@sobrenome", u.Sobrenome),

                                                            new SqlParameter("@email", u.Email),
                                                            new SqlParameter("@senha", u.Senha),
                                                            new SqlParameter("@dataCadastro", RepUtil.DateTimeNowBR()),
                                                            
                                                        }))
                {
                    while (dados.Read())
                        u = Obter(Convert.ToInt32(dados["CodUsuario"]));

                    return u;
                }
            }
            catch
            {
                return null;
            }
        }
        public Usuario Editar(Usuario u)
        {
            try
            {
                return RepUtil.ExecutaSQL($@"UPDATE Pessoa 
                                            SET Nome = @nome,
                                            CPF = @cpf,
                                            DataNascimento = @dataNascimento,
                                            Telefone = @telefone,
                                            Sobrenome = @sobrenome
                                            WHERE CodPessoa = @codPessoa

                                            UPDATE Endereco 
                                            SET Logradouro = @logradouro,
                                            CEP = @cep,
                                            Bairro = @bairro,
                                            UF = @uf,
                                            Cidade = @cidade,
                                            Numero = @numero,
                                            Complemento = @complemento
                                            WHERE CodEndereco = @codEndereco

                                            UPDATE Endereco 
                                            SET Logradouro = @endCobLogradouro,
                                            CEP = @endCobCep,
                                            Bairro = @endCobBairro,
                                            UF = @endCobUf,
                                            Cidade = @endCobCidade,
                                            Numero = @endCobNumero,
                                            Complemento = @endCobComplemento
                                            WHERE CodEndereco = @codEnderecoCobranca",
                                            new[] {
                                                new SqlParameter("@nome", u.Nome),
                                                new SqlParameter("@cpf", u.CPF),
                                                new SqlParameter("@dataNascimento", u.DataNascimento),
                                                new SqlParameter("@telefone", u.Telefone),
                                                new SqlParameter("@sobrenome", u.Sobrenome),
                                                new SqlParameter("@codPessoa", u.CodPessoa),
                                                new SqlParameter("@logradouro", u.Logradouro),
                                                new SqlParameter("@cep", u.CEP),
                                                new SqlParameter("@bairro", u.Bairro),
                                                new SqlParameter("@uf", u.UF),
                                                new SqlParameter("@cidade", u.Cidade),
                                                new SqlParameter("@numero", u.Numero),
                                                new SqlParameter("@complemento", u.Complemento ?? string.Empty),
                                                new SqlParameter("@codEndereco", u.CodEndereco),
                                                new SqlParameter("@endCobLogradouro", u.EnderecoCobranca.Logradouro),
                                                new SqlParameter("@endCobCep", u.EnderecoCobranca.CEP),
                                                new SqlParameter("@endCobBairro", u.EnderecoCobranca.Bairro),
                                                new SqlParameter("@endCobUf", u.EnderecoCobranca.UF),
                                                new SqlParameter("@endCobCidade", u.EnderecoCobranca.Cidade),
                                                new SqlParameter("@endCobNumero", u.EnderecoCobranca.Numero),
                                                new SqlParameter("@endCobComplemento", u.EnderecoCobranca.Complemento ?? string.Empty),
                                                new SqlParameter("@codEnderecoCobranca", u.CodEnderecoCobranca)
                                            }) > 0 ? u : null;
            }
            catch
            {
                return null;
            }
        }
        public bool CadastrarCodigoEmail(string email, string codigo)
        {
            return RepUtil.ExecutaSQL($@"DELETE FROM EmailCodigo WHERE Email = @email
                                         INSERT INTO EmailCodigo(Email, Codigo) VALUES(@email, @codigo)",
                                        new[] {
                                            new SqlParameter("@codigo", codigo),
                                            new SqlParameter("@email", email)
                                        }) > 0;
        }
        public bool VerificarCodigoEmail(string codigo, string email)
        {
            using (var dados = RepUtil.ExecuteReader($@"IF EXISTS(SELECT 1 FROM EmailCodigo WHERE Email = @email AND Codigo = @codigo)
                                                        BEGIN
                                                            DELETE FROM EmailCodigo WHERE Email = @email
	                                                        SELECT 1 resultado 
                                                        END
                                                        ELSE
                                                        BEGIN
	                                                        SELECT 0 resultado 
                                                        END",
                                                            new[] {
                                                                new SqlParameter("@codigo", codigo),
                                                                new SqlParameter("@email", email)
                                                            }))
            {
                while (dados.Read())
                    return Convert.ToBoolean(dados["resultado"]);
                return false;
            }
        }
        public bool InserirIdWirecard(int codUsuario, string idWirecard)
        {
            return RepUtil.ExecutaSQL(@"UPDATE Usuario
                                     SET IdWirecard = @idWirecard
                                     WHERE CodUsuario = @codUsuario",
                                     new[] {
                                         new SqlParameter("@idWirecard", idWirecard),
                                         new SqlParameter("@codUsuario", codUsuario)
                                     }) > 0;
                
        }
        public string ObterSenhaPorUsuario(string email)
        {
            string senha = null;
            try
            {
                using (var dados = RepUtil.ExecuteReader($"SELECT Senha FROM Usuario WHERE Email = @email",
                                                            new[] { new SqlParameter("@email", email) }))
                {
                    while (dados.Read())
                        senha = dados["Senha"].ToString();
                }
            }
            catch
            {
                senha = null;
            }
            return senha;
        }
        public Usuario Obter(int codUsuario)
        {
            var item = Obter(@"SELECT *, 
                                endCob.CodEndereco as EndCobCodEndereco,
                                endCob.Logradouro as EndCobLogradouro,
                                endCob.CEP as EndCobCEP,
                                endCob.Bairro as EndCobBairro,
                                endCob.UF as EndCobUF,
                                endCob.Cidade as EndCobCidade,
                                endCob.Numero as EndCobNumero,
                                endCob.Complemento as EndCobComplemento
                                FROM Usuario u 
                                INNER JOIN pessoa p ON u.CodPessoa = p.CodPessoa 
                                INNER JOIN endereco e ON p.CodEndereco = e.CodEndereco 
                                INNER JOIN endereco endCob ON p.CodEnderecoCobranca = endCob.CodEndereco 
                                WHERE CodUsuario = @codUsuario and DataExclusao is null",
                                new[] { new SqlParameter("@codUsuario", codUsuario) });
            return item;
        }
        public Usuario ObterPorEmail(string email)
        {
            var item = Obter(@"select *, 
                                endCob.CodEndereco as EndCobCodEndereco,
                                endCob.Logradouro as EndCobLogradouro,
                                endCob.CEP as EndCobCEP,
                                endCob.Bairro as EndCobBairro,
                                endCob.UF as EndCobUF,
                                endCob.Cidade as EndCobCidade,
                                endCob.Numero as EndCobNumero,
                                endCob.Complemento as EndCobComplemento
                                from usuario u 
                                inner join pessoa p 
                                on u.CodPessoa = p.CodPessoa 
                                inner join endereco e 
                                on p.CodEndereco = e.CodEndereco 
                                inner join endereco endCob 
                                on p.CodEnderecoCobranca = endCob.CodEndereco 
                                where u.Email = @email and u.DataExclusao is null",
                                new[] { new SqlParameter("@email", email) });
            return item;
        }
        public Usuario ObterPorCPF(string cpf)
        {
            var item = Obter($@"select *, 
                                endCob.CodEndereco as EndCobCodEndereco,
                                endCob.Logradouro as EndCobLogradouro,
                                endCob.CEP as EndCobCEP,
                                endCob.Bairro as EndCobBairro,
                                endCob.UF as EndCobUF,
                                endCob.Cidade as EndCobCidade,
                                endCob.Numero as EndCobNumero,
                                endCob.Complemento as EndCobComplemento
                                from usuario u 
                                inner join pessoa p 
                                on u.CodPessoa = p.CodPessoa 
                                inner join endereco e 
                                on p.CodEndereco = e.CodEndereco 
                                inner join endereco endCob 
                                on p.CodEnderecoCobranca = endCob.CodEndereco 
                                where p.CPF = @cpf and u.DataExclusao is null",
                                new[] { new SqlParameter("@cpf", cpf) });
            return item;
        }
        public bool SalvarNovaSenha(int codUsuario, string novaSenha)
        {
            try
            {
                return RepUtil.ExecutaSQL("UPDATE Usuario SET Senha = @novaSenha WHERE CodUsuario = @codUsuario",
                                            new[] {
                                                new SqlParameter("@codUsuario", codUsuario),
                                                new SqlParameter("@novaSenha", novaSenha)
                                            }) > 0;
            }
            catch
            {
                return false;
            }
        }
        public List<Usuario> Obter()
        {
            var list = Listar($@"select *, 
                                endCob.CodEndereco as EndCobCodEndereco,
                                endCob.Logradouro as EndCobLogradouro,
                                endCob.CEP as EndCobCEP,
                                endCob.Bairro as EndCobBairro,
                                endCob.UF as EndCobUF,
                                endCob.Cidade as EndCobCidade,
                                endCob.Numero as EndCobNumero,
                                endCob.Complemento as EndCobComplemento
                                from usuario u 
                                inner join pessoa p 
                                on u.CodPessoa = p.CodPessoa 
                                inner join endereco e 
                                on p.CodEndereco = e.CodEndereco 
                                inner join endereco endCob 
                                on p.CodEnderecoCobranca = endCob.CodEndereco 
                                where DataExclusao is null");
            return list;
        }
        public bool Desabilitar(int codUsuario)
        {
            try
            {
                return RepUtil.ExecutaSQL($"update Usuario set DataExclusao = @dataExclusao where CodUsuario = @codUsuario",
                                            new[] {
                                                new SqlParameter("@codUsuario", codUsuario),
                                                new SqlParameter("@dataExclusao", RepUtil.DateTimeNowBR())
                                            }) > 0;
            }
            catch 
            {
                return false;
            }
        }
        public void MethodTemporary(string email, string senha)
        {
            RepUtil.ExecutaSQL("UPDATE Usuario SET Senha = @senha WHERE Email = @email",
                                new[] {
                                    new SqlParameter("@senha", senha),
                                    new SqlParameter("@email", email)
                                });
        }
        public bool Remover(int codUsuario)
        {
            try
            {
                return RepUtil.ExecutaSQL($@"DECLARE @codPessoa INT, @codEndereco INT
                                             SET @codPessoa = (SELECT CodPessoa FROM Usuario WHERE CodUsuario = @codUsuario)
                                             SET @codEndereco = (SELECT CodEndereco FROM Pessoa WHERE CodPessoa = @codPessoa)
                                      
                                             DELETE FROM Estorno WHERE CodPedido IN (SELECT CodPedido FROM Pedido WHERE CodUsuario = @codUsuario)
                                             DELETE FROM Avaliacao WHERE CodUsuario = @codUsuario
                                             DELETE FROM ItemCarrinho WHERE CodUsuario = @codUsuario
                                             DELETE FROM ItemPedido WHERE CodPedido IN (SELECT CodPedido FROM Pedido WHERE CodUsuario = @codUsuario)
                                             DELETE FROM Pagamento WHERE CodPedido IN (SELECT CodPedido FROM Pedido WHERE CodUsuario = @codUsuario)
                                             DELETE FROM LogStatusPedido WHERE CodPedido IN (SELECT CodPedido FROM Pedido WHERE CodUsuario = @codUsuario)
                                             DELETE FROM ItemDesejo WHERE CodUsuario = @codUsuario
                                             DELETE FROM Pedido WHERE CodUsuario = @codUsuario
                                             DELETE FROM UsuarioPermissao WHERE codUsuario = @codUsuario
                                             DELETE FROM Usuario WHERE codUsuario = @codUsuario
                                             DELETE FROM Pessoa WHERE codPessoa = @codPessoa
                                             DELETE FROM Endereco WHERE codEndereco = @codEndereco",
                    new[] { new SqlParameter("@codUsuario", codUsuario) }) > 0;
            }
            catch(Exception ex)
            {
                return false;
            }
        }
        public bool VerificarEmail(string email)
        {
            try
            {
                return RepUtil.ExecuteReader("SELECT 1 FROM Usuario WHERE Email = @email",
                                                new[] { new SqlParameter("@email", email) }).HasRows;
            }
            catch 
            {
                return false;
            }
        }
        public bool VerificarCPF(string cpf)
        {
            try
            {
                return RepUtil.ExecuteReader("SELECT 1 FROM Usuario u JOIN Pessoa p ON p.CodPessoa = u.CodPessoa WHERE p.CPF = @cpf",
                                                new[] { new SqlParameter("@cpf", cpf)}).HasRows;
            }
            catch
            {
                return false;
            }
        }
        public bool SalvarEndereco(Endereco e, int codUsuario)
        {
            try
            {
                return RepUtil.ExecutaSQL($@"DECLARE @codEndereco INT = (SELECT p.CodEndereco FROM Usuario u
                                                                        JOIN dbo.Pessoa p ON p.CodPessoa = u.CodPessoa
                                                                        WHERE u.CodUsuario = @codUsuario)
                                             UPDATE Endereco 
                                             SET Logradouro = @logradouro,
                                             CEP = @cep,
                                             Bairro = @bairro,
                                             UF = @uf,
                                             Cidade = @cidade,
                                             Numero = @numero,
                                             Complemento = @complemento
                                             WHERE CodEndereco = @codEndereco",
                                            new[] {
                                                new SqlParameter("@logradouro", e.Logradouro),
                                                new SqlParameter("@cep", e.CEP),
                                                new SqlParameter("@bairro", e.Bairro),
                                                new SqlParameter("@uf", e.UF),
                                                new SqlParameter("@cidade", e.Cidade),
                                                new SqlParameter("@numero", e.Numero),
                                                new SqlParameter("@complemento", e.Complemento ?? string.Empty),
                                                new SqlParameter("@codUsuario", codUsuario),
                                            }) > 0;
            }
            catch
            {
                return false;
            }
        }
        public bool SalvarEnderecoCobranca(Endereco e, int codUsuario)
        {
            try
            {
                return RepUtil.ExecutaSQL($@"DECLARE @codEndereco INT = (SELECT p.CodEnderecoCobranca FROM Usuario u
                                                                        JOIN dbo.Pessoa p ON p.CodPessoa = u.CodPessoa
                                                                        WHERE u.CodUsuario = @codUsuario)
                                             UPDATE Endereco 
                                             SET Logradouro = @logradouro,
                                             CEP = @cep,
                                             Bairro = @bairro,
                                             UF = @uf,
                                             Cidade = @cidade,
                                             Numero = @numero,
                                             Complemento = @complemento
                                             WHERE CodEndereco = @codEndereco",
                                            new[] {
                                                new SqlParameter("@logradouro", e.Logradouro),
                                                new SqlParameter("@cep", e.CEP),
                                                new SqlParameter("@bairro", e.Bairro),
                                                new SqlParameter("@uf", e.UF),
                                                new SqlParameter("@cidade", e.Cidade),
                                                new SqlParameter("@numero", e.Numero),
                                                new SqlParameter("@complemento", e.Complemento ?? string.Empty),
                                                new SqlParameter("@codUsuario", codUsuario),
                                            }) > 0;
            }
            catch
            {
                return false;
            }
        }
        public Endereco ObterEndereco(int codUsuario)
        {
            using (var dados = RepUtil.ExecuteReader(@"DECLARE @codEndereco INT = (SELECT p.CodEndereco FROM Usuario u
                                                                                   JOIN dbo.Pessoa p ON p.CodPessoa = u.CodPessoa
                                                                                   WHERE u.CodUsuario = @codUsuario)
                                                       SELECT * FROM Endereco WHERE CodEndereco = @codEndereco",
                                                       new[] { new SqlParameter("@codUsuario", codUsuario) }))
            {
                while (dados.Read())
                {
                    return new Endereco
                    {
                        Bairro = dados["Bairro"].ToString(),
                        CEP = dados["CEP"].ToString(),
                        Cidade = dados["Cidade"].ToString(),
                        CodEndereco = Convert.ToInt32(dados["CodEndereco"]),
                        Complemento = dados["Complemento"].ToString(),
                        Logradouro = dados["Logradouro"].ToString(),
                        Numero = dados["Numero"].ToString(),
                        UF = dados["UF"].ToString()
                    };
                }
                throw new Exception();
            }
        }
        public Endereco ObterEnderecoCobranca(int codUsuario)
        {
            using (var dados = RepUtil.ExecuteReader(@"DECLARE @codEndereco INT = (SELECT p.CodEnderecoCobranca FROM Usuario u
                                                                                   JOIN dbo.Pessoa p ON p.CodPessoa = u.CodPessoa
                                                                                   WHERE u.CodUsuario = @codUsuario)
                                                       SELECT * FROM Endereco WHERE CodEndereco = @codEndereco",
                                                       new[] { new SqlParameter("@codUsuario", codUsuario) }))
            {
                while (dados.Read())
                {
                    return new Endereco
                    {
                        Bairro = dados["Bairro"].ToString(),
                        CEP = dados["CEP"].ToString(),
                        Cidade = dados["Cidade"].ToString(),
                        CodEndereco = Convert.ToInt32(dados["CodEndereco"]),
                        Complemento = dados["Complemento"].ToString(),
                        Logradouro = dados["Logradouro"].ToString(),
                        Numero = dados["Numero"].ToString(),
                        UF = dados["UF"].ToString()
                    };
                }
                throw new Exception();
            }
        }
        public bool AssinarEmail(string email)
        {
            return RepUtil.ExecutaSQL(@"DELETE FROM Emails WHERE Email = @email
                                        INSERT INTO Emails (Email, Data) VALUES (@email, @data)", 
                new[] {
                    new SqlParameter("@email", email),
                    new SqlParameter("@data", RepUtil.DateTimeNowBR())
                }) > 0;
        }
        private List<Usuario> Listar(string command, SqlParameter[] parameters = null)
        {
            var list = new List<Usuario>();
            using (var dados = RepUtil.ExecuteReader(command, parameters))
            {
                while (dados.Read())
                    list.Add(PopularObjeto(dados));
            }
            return list;
        }
        private Usuario Obter(string command, SqlParameter[] parameters = null)
        {
            var u = new Usuario();
            using (var dados = RepUtil.ExecuteReader(command, parameters))
            {
                while (dados.Read())
                    u = PopularObjeto(dados);
            }
            return u;
        }
        public Usuario PopularObjeto(SqlDataReader sql)
        {
            return new Usuario
            {
                CodUsuario = int.Parse(sql["CodUsuario"].ToString()),
                Email = sql["Email"].ToString(),
                CodPessoa = int.Parse(sql["CodPessoa"].ToString()),
                Nome = sql["Nome"].ToString(),
                CPF = sql["CPF"].ToString(),
                DataNascimento = Convert.ToDateTime(sql["DataNascimento"]),
                Telefone = sql["Telefone"].ToString(),
                CodEndereco = int.Parse(sql["CodEndereco"].ToString()),
                Logradouro = sql["Logradouro"].ToString(),
                CEP = sql["CEP"].ToString(),
                Bairro = sql["Bairro"].ToString(),
                UF = sql["UF"].ToString(),
                Cidade = sql["Cidade"].ToString(),
                Numero = sql["Numero"].ToString(),
                Complemento = sql["Complemento"].ToString(),
                DataCadastro = Convert.ToDateTime(sql["DataCadastro"]),
                Sobrenome = sql["Sobrenome"].ToString(),
                Senha = sql["Senha"].ToString(),
                IdWirecard = sql["IdWirecard"].ToString(),
                CodEnderecoCobranca = Convert.ToInt32(sql["CodEnderecoCobranca"]),
                EnderecoCobranca = new Endereco
                {
                    CodEndereco = int.Parse(sql["EndCobCodEndereco"].ToString()),
                    Logradouro = sql["EndCobLogradouro"].ToString(),
                    CEP = sql["EndCobCEP"].ToString(),
                    Bairro = sql["EndCobBairro"].ToString(),
                    UF = sql["EndCobUF"].ToString(),
                    Cidade = sql["EndCobCidade"].ToString(),
                    Numero = sql["EndCobNumero"].ToString(),
                    Complemento = sql["EndCobComplemento"].ToString(),
                }
            };
        }
    }
}