using Models;
using Repositorios;
using Servicos.Wirecard;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Servicos
{
    public class SerUsuario
    {
        public JsonObject Cadastrar(Usuario u)
        {
            string result = Validar(u);
            string erroCad = "Cadastro não realizado. Tente novamente.";
            if (string.IsNullOrWhiteSpace(result))
            {
                var ru = new RepUsuario();
                u.Senha = SerCriptografia.Encrypt(u.Senha);
                u.Email = u.Email.Trim().ToLower();
                u = ru.Cadastrar(u);
                if (u.CodUsuario <= 0)
                    return new JsonObject { mensagem = erroCad, sucesso = false };
                else
                {
                    var rp = new RepPermissao();
                    if (rp.CadastrarUsuarioPermissao(u.CodUsuario, 1))
                    {
                        try
                        {
                            var cliente = new ConnectWirecard().CriarCliente(u);
                            if (cliente.Id.Length > 0)
                            {
                                ru.InserirIdWirecard(u.CodUsuario, cliente.Id);
                                return new JsonObject { sucesso = true, obj = u };
                            }
                        }
                        catch (Exception ex){
                        }
                    }
                    ru.Remover(u.CodUsuario);
                    return new JsonObject { mensagem = erroCad, sucesso = false };
                }
            }
            else
                return new JsonObject { mensagem = result, sucesso = false };
        }
        public JsonObject Editar(Usuario u)
        {
            string result = Validar(u, edicao: true);
            if (string.IsNullOrWhiteSpace(result))
            {
                if (u.CodUsuario <= 0 || u.CodPessoa <= 0 || u.CodEndereco <= 0 || u.CodEnderecoCobranca <= 0)
                    return new JsonObject { mensagem = "Edição não realizada. Tente novamente.", sucesso = false };

                var ru = new RepUsuario();
                var usuarioDB = ru.Obter(u.CodUsuario);
                if (u.CPF != usuarioDB.CPF)
                {
                    if (VerificarCPF(u.CPF))
                        return new JsonObject { mensagem = "Este CPF já está cadastrado.", sucesso = false };
                }
                u = ru.Editar(u);
                if (u == null)
                    return new JsonObject { mensagem = "Edição não realizada. Tente novamente.", sucesso = false };
                else
                    return new JsonObject { sucesso = true, obj = u };
            }
            else
                return new JsonObject { mensagem = result, sucesso = false };
        }
        public Usuario Obter(int codUsuario)
        {
            return new RepUsuario().Obter(codUsuario);
        }
        public Usuario ObterComPedidos(int codUsuario)
        {
            var u = new RepUsuario().Obter(codUsuario);
            u.Pedidos = new SerPedido().ObterPorUsuario(codUsuario);
            return u;
        }
        public JsonObject ObterSerialize(int codUsuario)
        {
            var r = new RepUsuario();
            var usuario = r.Obter(codUsuario);
            if (usuario == null)
                return new JsonObject { sucesso = false, mensagem = Util.MsgErroComum };
            if (usuario.CodUsuario <= 0)
                return new JsonObject { sucesso = false, mensagem = Util.MsgErroComum };
            return new JsonObject { sucesso = true, obj = usuario };
        }
        public List<Usuario> Obter()
        {
            return new RepUsuario().Obter();
        }
        public JsonObject EfetuarLogin(Usuario u)
        {
            if (u == null)
                return new JsonObject { sucesso = false, mensagem = "Usuário ou Senha não informados." };

            if (u.Email == null || u.Senha == null)
                return new JsonObject { sucesso = false, mensagem = "Usuário ou Senha não informados." };
            else
            {
                Usuario usuarioDB;
                if (IsCPF(u.Email))
                    usuarioDB = new RepUsuario().ObterPorCPF(u.Email.Trim().ToLower());
                else
                    usuarioDB = new RepUsuario().ObterPorEmail(u.Email.Trim().ToLower());
                if (usuarioDB.CodUsuario > 0)
                {
                    if (u.Senha == SerCriptografia.Decrypt(usuarioDB.Senha))
                        return new JsonObject { sucesso = true, obj = usuarioDB };
                    return new JsonObject { sucesso = false, mensagem = "Usuário ou Senha incorretos." };
                }
                return new JsonObject { sucesso = false, mensagem = "Este usuário não está cadastrado." };
            }
        }
        public bool RecuperarLogin(string email, out string mensagem)
        {
            mensagem = string.Empty;
            var ru = new RepUsuario();
            if (ru.ObterPorEmail(email) == null)
            {
                mensagem = "Este e-mail não está cadastrado.";
                return false;
            }
            var usuario = ru.ObterPorEmail(email);
            if (string.IsNullOrWhiteSpace(usuario.Senha))
            {
                mensagem = "Este usuário não está cadastrado.";
                return false;
            }
            else
            {
                var s = new SerEmail();
                return s.Enviar(
                    dest:email, 
                    assunto: "Recuperação de Senha", 
                    mensagem: s.CorpoRecuperacaoSenha(usuario),
                    from: Util.EmailSuporte, 
                    fromPass: Util.EmailSuporteSenha);
            }
        }
        public JsonObject EnviarCodigoEmail(string email, string nome)
        {
            var codigo = new Random().Next(1000, 9999).ToString();
            if (new RepUsuario().CadastrarCodigoEmail(email, codigo))
            {
                var s = new SerEmail();
                Task.Run(() => s.EnviarAsync(
                    dest: email, 
                    assunto: "Código de Verificação da Conta", 
                    mensagem: s.CorpoVerificacaoEmail(codigo, nome), 
                    from: Util.EmailSuporte,
                    fromPass: Util.EmailSuporteSenha
                    ));

                return new JsonObject() { sucesso = true };
            }
            else
                return new JsonObject() { sucesso = false, mensagem = Util.MsgErroComum };
        }
        public JsonObject VerificarCodigoEmail(string codigo, string email)
        {
            bool result = new RepUsuario().VerificarCodigoEmail(codigo, email);
            if (result)
                return new JsonObject() { sucesso = true };
            else
                return new JsonObject() { sucesso = false, mensagem = "Código inválido" };
        }
        public void MethodTemporary(string email, string senha)
        {
            new RepUsuario().MethodTemporary(email, SerCriptografia.Encrypt(senha));
        }
        public bool Remover(int codUsuario)
        {
            return new RepUsuario().Remover(codUsuario);
        }
        public bool VerificarEmail(string email)
        {
            return new RepUsuario().VerificarEmail(email.Trim());
        }
        public bool VerificarCPF(string cpf)
        {
            return new RepUsuario().VerificarCPF(cpf.Trim());
        }
        public JsonObject SalvarNovaSenha(int codUsuario, string senhaAtual, string novaSenha)
        {
            var ru = new RepUsuario();
            var usuario = ru.Obter(codUsuario);
            if (usuario == null)
                return new JsonObject { mensagem = Util.MsgErroComum, sucesso = false };
            if (senhaAtual == SerCriptografia.Decrypt(usuario.Senha))
            {
                if (novaSenha.Length == 0 || novaSenha.Length > 20)
                    return new JsonObject { mensagem = "A nova Senha não pode ser vazia ou maior que 20 caracteres.", sucesso = false};

                bool result = ru.SalvarNovaSenha(codUsuario, SerCriptografia.Encrypt(novaSenha));
                if (result)
                    return new JsonObject { sucesso = true };

                return new JsonObject { mensagem = Util.MsgErroComum, sucesso = false };
            }
            else
                return new JsonObject { mensagem = "A Senha atual está incorreta.", sucesso = false };
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
        private bool IsEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }
        public JsonObject SalvarEndereco(Endereco e, int codUsuario)
        {
            string result = ValidarEndereco(e);
            if (string.IsNullOrWhiteSpace(result))
            {
                if (codUsuario <= 0)
                    return new JsonObject { mensagem = Util.MsgErroComum, sucesso = false };
                else
                {
                    if (new RepUsuario().SalvarEndereco(e, codUsuario))
                        return new JsonObject { sucesso = true, obj = e };

                    return new JsonObject { mensagem = Util.MsgErroComum, sucesso = false };
                }
            }
            else
                return new JsonObject { mensagem = result, sucesso = false };
        }
        public JsonObject SalvarEnderecoCobranca(Endereco e, int codUsuario)
        {
            string result = ValidarEndereco(e);
            if (string.IsNullOrWhiteSpace(result))
            {
                if (codUsuario <= 0)
                    return new JsonObject { mensagem = Util.MsgErroComum, sucesso = false };
                else
                {
                    if (new RepUsuario().SalvarEnderecoCobranca(e, codUsuario))
                        return new JsonObject { sucesso = true, obj = e };

                    return new JsonObject { mensagem = Util.MsgErroComum, sucesso = false };
                }
            }
            else
                return new JsonObject { mensagem = result, sucesso = false };
        }
        public JsonObject ObterEndereco(int codUsuario)
        {
            var result = new RepUsuario().ObterEndereco(codUsuario);
            return new JsonObject { sucesso = true, obj = result };
        }
        public JsonObject ObterEnderecoCobranca(int codUsuario)
        {
            var result = new RepUsuario().ObterEnderecoCobranca(codUsuario);
            return new JsonObject { sucesso = true, obj = result };
        }
        private string Validar(Usuario u, bool edicao = false)
        {
            string eCampos = "Por favor revise os campos e tente novamente.";

            if (string.IsNullOrWhiteSpace(u.Nome))
                return eCampos;
            else if (u.Nome.Length > 40)
                return eCampos;

            if (string.IsNullOrWhiteSpace(u.Sobrenome))
                return eCampos;
            else if (u.Sobrenome.Length > 49)
                return eCampos;

            if (u.DataNascimento == null)
                return eCampos;
            else if (u.DataNascimento <= new DateTime(1753, 1, 1))
                return eCampos;

            if (string.IsNullOrWhiteSpace(u.CPF))
                return eCampos;
            else if (!IsCPF(u.CPF))
                return eCampos;
            else if (VerificarCPF(u.CPF) && !edicao)
                return "Este CPF já está cadastrado.";

            if (string.IsNullOrWhiteSpace(u.Telefone))
                return eCampos;
            else if (u.Telefone.Length > 15)
                return eCampos;

            if (!edicao)
            {
                if (string.IsNullOrWhiteSpace(u.Email))
                    return eCampos;
                else if (u.Email.Length > 90 || !IsEmail(u.Email))
                    return eCampos;
                else if (VerificarEmail(u.Email))
                    return "Este e-mail já está cadastrado.";

                if (string.IsNullOrWhiteSpace(u.Senha))
                    return eCampos;
                else if (u.Senha.Length > 20)
                    return eCampos;
            }

            if (string.IsNullOrWhiteSpace(u.CEP))
                return eCampos;
            else if (u.CEP.Length > 8)
                return eCampos;

            if (string.IsNullOrWhiteSpace(u.Logradouro))
                return eCampos;
            else if (u.Logradouro.Length > 100)
                return eCampos;

            if (string.IsNullOrWhiteSpace(u.Numero))
                return eCampos;
            else if (u.Numero.Length > 10)
                return eCampos;

            if (!string.IsNullOrWhiteSpace(u.Complemento))
            {
                if (u.Complemento.Length > 50)
                    return eCampos;
            }

            if (string.IsNullOrWhiteSpace(u.Bairro))
                return eCampos;
            else if (u.Bairro.Length > 45)
                return eCampos;

            if (string.IsNullOrWhiteSpace(u.Cidade))
                return eCampos;
            else if (u.Cidade.Length > 32)
                return eCampos;

            if (string.IsNullOrWhiteSpace(u.UF))
                return eCampos;
            else if (u.UF.Length != 2)
                return eCampos;

            if (edicao)
            {
                if (string.IsNullOrWhiteSpace(u.EnderecoCobranca.CEP))
                    return eCampos;
                else if (u.EnderecoCobranca.CEP.Length > 8)
                    return eCampos;

                if (string.IsNullOrWhiteSpace(u.EnderecoCobranca.Logradouro))
                    return eCampos;
                else if (u.EnderecoCobranca.Logradouro.Length > 100)
                    return eCampos;

                if (string.IsNullOrWhiteSpace(u.EnderecoCobranca.Numero))
                    return eCampos;
                else if (u.EnderecoCobranca.Numero.Length > 10)
                    return eCampos;

                if (!string.IsNullOrWhiteSpace(u.EnderecoCobranca.Complemento))
                {
                    if (u.EnderecoCobranca.Complemento.Length > 50)
                        return eCampos;
                }

                if (string.IsNullOrWhiteSpace(u.EnderecoCobranca.Bairro))
                    return eCampos;
                else if (u.EnderecoCobranca.Bairro.Length > 45)
                    return eCampos;

                if (string.IsNullOrWhiteSpace(u.EnderecoCobranca.Cidade))
                    return eCampos;
                else if (u.EnderecoCobranca.Cidade.Length > 32)
                    return eCampos;

                if (string.IsNullOrWhiteSpace(u.EnderecoCobranca.UF))
                    return eCampos;
                else if (u.EnderecoCobranca.UF.Length != 2)
                    return eCampos;
            }

            return string.Empty;
        }
        private string ValidarEndereco(Endereco e)
        {
            string eCampos = "Por favor revise os campos e tente novamente.";

            if (string.IsNullOrWhiteSpace(e.CEP))
                return eCampos;
            else if (e.CEP.Length > 8)
                return eCampos;

            if (string.IsNullOrWhiteSpace(e.Logradouro))
                return eCampos;
            else if (e.Logradouro.Length > 100)
                return eCampos;

            if (string.IsNullOrWhiteSpace(e.Numero))
                return eCampos;
            else if (e.Numero.Length > 10)
                return eCampos;

            if (!string.IsNullOrWhiteSpace(e.Complemento))
            {
                if (e.Complemento.Length > 50)
                    return eCampos;
            }

            if (string.IsNullOrWhiteSpace(e.Bairro))
                return eCampos;
            else if (e.Bairro.Length > 45)
                return eCampos;

            if (string.IsNullOrWhiteSpace(e.Cidade))
                return eCampos;
            else if (e.Cidade.Length > 32)
                return eCampos;

            if (string.IsNullOrWhiteSpace(e.UF))
                return eCampos;
            else if (e.UF.Length > 2)
                return eCampos;

            return string.Empty;
        }
        public JsonObject AssinarEmail(string email)
        {
            if (new RepUsuario().AssinarEmail(email))
                return new JsonObject { sucesso = true };
            else
                return new JsonObject { sucesso = false, mensagem = Util.MsgErroComum };
        }
    }
}
