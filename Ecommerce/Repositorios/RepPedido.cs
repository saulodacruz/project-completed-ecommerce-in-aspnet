using Models;
using MoreLinq;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositorios
{
    public class RepPedido
    {
        public List<Pedido> Obter()
        {
            return Listar(@"DECLARE @cods TABLE (codPedido BIGINT);
                            INSERT @cods(codPedido) SELECT p.codpedido FROM pedido p 
                            SELECT * FROM Pedido p 
                            SELECT * FROM ItemPedido ic
                                    JOIN Produto p ON ic.CodProduto = p.CodProduto
                                    WHERE CodPedido IN (SELECT codPedido FROM @cods)
                            SELECT * FROM LogStatusPedido lsp
                                JOIN StatusPedido sp ON lsp.CodStatusPedido = sp.CodStatusPedido
                                WHERE CodPedido IN (SELECT codPedido FROM @cods)
                            SELECT * FROM Pagamento WHERE CodPedido IN (SELECT codPedido FROM @cods)
                            SELECT *, 
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
                                    INNER JOIN Pedido pe ON u.CodUsuario = pe.CodUsuario
                                    WHERE pe.CodPedido IN (SELECT codPedido FROM @cods)");
        }

        public List<Pedido> ObterPorCupom(string codigo)
        {
            return Listar(@"DECLARE @codCupom INT = (SELECT CodCupom FROM Cupom WHERE Codigo = @codigo)
                            DECLARE @cods TABLE (codPedido BIGINT);
                            INSERT @cods(codPedido) SELECT p.codpedido FROM pedido p WHERE CodCupom = @codCupom
                            SELECT * FROM Pedido p WHERE CodCupom = @codCupom
                            SELECT * FROM ItemPedido ic
                                JOIN Produto p ON ic.CodProduto = p.CodProduto
                                WHERE CodPedido IN (SELECT codPedido FROM @cods)
                            SELECT * FROM LogStatusPedido lsp
                                JOIN StatusPedido sp ON lsp.CodStatusPedido = sp.CodStatusPedido
                                WHERE CodPedido IN (SELECT codPedido FROM @cods)",
                            new[] { new SqlParameter("@codigo", codigo) });
        }

        public List<Pedido> ObterPorStatus(int codStatusPedido)
        {
            return Listar(@"DECLARE @cods TABLE (codPedido BIGINT);
                            INSERT @cods(codPedido) SELECT p.CodPedido
                                                    FROM Pedido p
                                                    CROSS APPLY (
	                                                    SELECT TOP 1 CodLogStatusPedido, CodStatusPedido FROM dbo.LogStatusPedido lsp 
	                                                    WHERE codpedido = p.codpedido ORDER BY lsp.CodLogStatusPedido DESC
                                                    ) AS l
                                                    WHERE l.CodStatusPedido = @codStatusPedido
                            SELECT p.*
                            FROM Pedido p
                            CROSS APPLY (
	                            SELECT TOP 1 CodLogStatusPedido, CodStatusPedido FROM dbo.LogStatusPedido lsp 
	                            WHERE codpedido = p.codpedido ORDER BY lsp.CodLogStatusPedido DESC
                            ) AS l
                            WHERE l.CodStatusPedido = @codStatusPedido
                            SELECT * FROM ItemPedido ic
                                    JOIN Produto p ON ic.CodProduto = p.CodProduto
                                    WHERE CodPedido IN (SELECT codPedido FROM @cods)
                            SELECT * FROM LogStatusPedido lsp
                                JOIN StatusPedido sp ON lsp.CodStatusPedido = sp.CodStatusPedido
                                WHERE CodPedido IN (SELECT codPedido FROM @cods)
                            SELECT * FROM Pagamento WHERE CodPedido IN (SELECT codPedido FROM @cods)
                            SELECT *, 
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
                                    INNER JOIN Pedido pe ON u.CodUsuario = pe.CodUsuario
                                    WHERE pe.CodPedido IN (SELECT codPedido FROM @cods)", 
                                    new[] { new SqlParameter("@codStatusPedido", codStatusPedido) });
        }
        public List<Pedido> ObterPorUsuario(int codUsuario)
        {
            return Listar(@"DECLARE @cods TABLE (codPedido BIGINT);
                            INSERT @cods(codPedido) SELECT p.codpedido FROM pedido p WHERE CodUsuario = @codUsuario
                            SELECT * FROM Pedido p WHERE CodUsuario = @codUsuario
                            SELECT * FROM ItemPedido ic
                                    JOIN Produto p ON ic.CodProduto = p.CodProduto
                                    WHERE CodPedido IN (SELECT codPedido FROM @cods)
                            SELECT * FROM LogStatusPedido lsp
                                JOIN StatusPedido sp ON lsp.CodStatusPedido = sp.CodStatusPedido
                                WHERE CodPedido IN (SELECT codPedido FROM @cods)
                            SELECT * FROM Pagamento WHERE CodPedido IN (SELECT codPedido FROM @cods)",
                new[] { new SqlParameter("@codUsuario", codUsuario) });
        }
        public List<Pedido> ObterTodosPedidosNaoConcluidoPagto()
        {
            return Listar(@"DECLARE @cods TABLE (codPedido BIGINT);
                            INSERT @cods(codPedido) SELECT DISTINCT(p.codpedido) FROM Pedido p
                            JOIN LogStatusPedido lsp ON lsp.CodPedido = p.CodPedido
                            JOIN StatusPedido sp ON sp.CodStatusPedido = lsp.CodStatusPedido 
                            WHERE lsp.CodStatusPedido NOT IN(12,13,14,15,16,17,18,19,20) AND (p.IdWirecard <> '' AND p.IdWirecard IS NOT NULL)

                            SELECT DISTINCT(p.codpedido)N, p.* FROM Pedido p
                            JOIN LogStatusPedido lsp ON lsp.CodPedido = p.CodPedido
                            JOIN StatusPedido sp ON sp.CodStatusPedido = lsp.CodStatusPedido 
                            WHERE lsp.CodStatusPedido NOT IN(12,13,14,15,16,17,18,19,20) AND (p.IdWirecard <> '' AND p.IdWirecard IS NOT NULL)

                            SELECT * FROM ItemPedido ic
                                    JOIN Produto p ON ic.CodProduto = p.CodProduto
                                    WHERE CodPedido IN (SELECT codPedido FROM @cods)
                            SELECT * FROM LogStatusPedido lsp
                                JOIN StatusPedido sp ON lsp.CodStatusPedido = sp.CodStatusPedido
                                WHERE CodPedido IN (SELECT codPedido FROM @cods)
                            SELECT * FROM Pagamento WHERE CodPedido IN (SELECT codPedido FROM @cods)");
        }
        public List<Pedido> ObterTodosPedidosPagosNaoEntregues() 
        {
            return Listar(@"DECLARE @cods TABLE (codPedido BIGINT);
                            INSERT @cods(codPedido) SELECT DISTINCT(p.codpedido) FROM Pedido p
                            JOIN LogStatusPedido lsp ON lsp.CodPedido = p.CodPedido
                            JOIN StatusPedido sp ON sp.CodStatusPedido = lsp.CodStatusPedido 
                            WHERE lsp.CodStatusPedido NOT IN(18) AND lsp.CodStatusPedido IN(14,15) AND (p.CodigoRastreio <> '' AND p.CodigoRastreio IS NOT NULL)

                            SELECT DISTINCT(p.codpedido)N, p.* FROM Pedido p
                            JOIN LogStatusPedido lsp ON lsp.CodPedido = p.CodPedido
                            JOIN StatusPedido sp ON sp.CodStatusPedido = lsp.CodStatusPedido 
                            WHERE lsp.CodStatusPedido NOT IN(18) AND lsp.CodStatusPedido IN(14,15) AND (p.CodigoRastreio <> '' AND p.CodigoRastreio IS NOT NULL)

                            SELECT * FROM ItemPedido ic
                                    JOIN Produto p ON ic.CodProduto = p.CodProduto
                                    WHERE CodPedido IN (SELECT codPedido FROM @cods)
                            SELECT * FROM LogStatusPedido lsp
                                JOIN StatusPedido sp ON lsp.CodStatusPedido = sp.CodStatusPedido
                                WHERE CodPedido IN (SELECT codPedido FROM @cods)
                            SELECT * FROM Pagamento WHERE CodPedido IN (SELECT codPedido FROM @cods)");
        }
        public Pedido Obter(long codPedido)
        {
            return Obter(@"SELECT * FROM Pedido p WHERE CodPedido = @codPedido
                           SELECT * FROM ItemPedido ic
                                    JOIN Produto p ON ic.CodProduto = p.CodProduto
                                    WHERE CodPedido = @codPedido
                           SELECT * FROM LogStatusPedido lsp
                                    JOIN StatusPedido sp ON lsp.CodStatusPedido = sp.CodStatusPedido
                                    WHERE CodPedido = @codPedido
                           SELECT * FROM Pagamento WHERE CodPedido = @codPedido
                           SELECT * FROM Cupom c 
                                    JOIN Pedido p ON c.CodCupom = p.CodCupom
                                    WHERE CodPedido = @codPedido
                           SELECT *, 
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
                                    INNER JOIN Pedido pe ON u.CodUsuario = pe.CodUsuario
                                    WHERE pe.CodPedido = @codPedido", 
                           new[] { new SqlParameter("@codPedido", codPedido)});
        }
        public Pedido Cadastrar(Pedido p)
        {
            try
            {
                using (var dados = RepUtil.ExecuteReader(@"INSERT INTO Pedido (CodUsuario, ValorTotal, CodCupom, Data, Observacao, CodigoRastreio, DataPrevista, ValorFrete, DiasFrete, EmailEnviado, TipoFrete) 
                                                            VALUES (@codUsuario, @valorTotal, @codCupom, @data, @observacao, @codigoRastreio, @dataPrevista, @valorFrete, @diasFrete, @emailEnviado, @tipoFrete)
                                                            SELECT SCOPE_IDENTITY() CodPedido;",
                                                            new[] {
                                                                new SqlParameter("@codUsuario", p.CodUsuario),
                                                                new SqlParameter("@valorTotal", p.ValorTotal),
                                                                new SqlParameter("@codCupom", p.CodCupom <= 0 ? (object)DBNull.Value : p.CodCupom),
                                                                new SqlParameter("@data", p.Data),
                                                                new SqlParameter("@observacao", p.Observacao ?? string.Empty),
                                                                new SqlParameter("@codigoRastreio", p.CodigoRastreio ?? string.Empty),
                                                                new SqlParameter("@dataPrevista", p.DataPrevista ?? (object)DBNull.Value),
                                                                new SqlParameter("@valorFrete", p.ValorFrete),
                                                                new SqlParameter("@diasFrete", p.DiasFrete),
                                                                new SqlParameter("@emailEnviado", p.EmailEnviado),
                                                                new SqlParameter("@tipoFrete", p.TipoFrete)
                                                            }))
                {
                    while (dados.Read())
                        p.CodPedido = Convert.ToInt64(dados["CodPedido"]);

                    return p;
                }
            }
            catch(Exception ex)
            {
                return null;
            }
        }
        public bool InserirIdWirecard(long codPedido, string idWirecard)
        {
            return RepUtil.ExecutaSQL(@"UPDATE Pedido
                                     SET IdWirecard = @idWirecard
                                     WHERE CodPedido = @codPedido",
                                    new[] {
                                         new SqlParameter("@idWirecard", idWirecard),
                                         new SqlParameter("@codPedido", codPedido)
                                    }) > 0;
        }
        public bool Remover(long codPedido)
        {
            return RepUtil.ExecutaSQL($@"DELETE FROM Estorno WHERE CodPedido = @codPedido
                                         DELETE FROM LogStatusPedido WHERE CodPedido = @codPedido
                                         DELETE FROM ItemPedido WHERE CodPedido = @codPedido
                                         DELETE FROM Pagamento WHERE CodPedido = @codPedido
                                         DELETE FROM Pedido WHERE CodPedido = @codPedido",
                                        new[] { new SqlParameter("@codPedido", codPedido) }) > 0;
        }
        public Pedido Editar(Pedido p)
        {
            try
            {
                return RepUtil.ExecutaSQL($@"UPDATE Pedido 
                                    SET CodUsuario = @codUsuario,
                                    ValorTotal = @valorTotal, 
                                    CodCupom = @codCupom, 
                                    Data = @data, 
                                    Observacao = @observacao,
                                    CodigoRastreio = @codigoRastreio,
                                    DataPrevista = @dataPrevista,
                                    ValorFrete = @valorFrete,
                                    DiasFrete = @diasFrete,
                                    TipoFrete = @tipoFrete
                                    WHERE CodPedido = @codPedido",
                                    new[] {
                                        new SqlParameter("@codUsuario", p.CodUsuario),
                                        new SqlParameter("@valorTotal", p.ValorTotal),
                                        new SqlParameter("@codCupom", p.CodCupom <= 0? (object)DBNull.Value : p.CodCupom),
                                        new SqlParameter("@data", p.Data),
                                        new SqlParameter("@observacao", p.Observacao ?? string.Empty),
                                        new SqlParameter("@codigoRastreio", p.CodigoRastreio ?? string.Empty),
                                        new SqlParameter("@dataPrevista", p.DataPrevista ?? (object)DBNull.Value),
                                        new SqlParameter("@codPedido", p.CodPedido),
                                        new SqlParameter("@valorFrete", p.ValorFrete),
                                        new SqlParameter("@diasFrete", p.DiasFrete),
                                        new SqlParameter("@tipoFrete", p.TipoFrete)
                                    }) > 0 ? p : null;
            }
            catch (Exception ex)
            {
                return null;
            }
        }
        public bool RemoverEstorno(long codPedido, int codStatusPedido)
        {
            return RepUtil.ExecutaSQL($@"DELETE FROM Estorno WHERE CodPedido = @codPedido
                                         DELETE FROM LogStatusPedido WHERE CodPedido = @codPedido AND CodStatusPedido = @codStatusPedido",
                                     new[] { new SqlParameter("@codPedido", codPedido), new SqlParameter("@codStatusPedido", codStatusPedido) }) > 0;
        }
        public Estorno CadastrarEstorno(Estorno e)
        {
            using (var dados = RepUtil.ExecuteReader(@"INSERT INTO Estorno (CodPedido, TipoPagamento, NumeroBanco, Agencia, Conta, CPF, NomeDeposito, Observacao, Data, DataSolicitacao)
                                                       VALUES(@codPedido, @tipoPagamento, @numeroBanco, @agencia, @conta, @cpf, @nomeDeposito, @observacao, @data, @dataSolicitacao)
                                                       SELECT SCOPE_IDENTITY() CodEstorno;",
                                                        new[] {
                                                                new SqlParameter("@codPedido", e.CodPedido),
                                                                new SqlParameter("@tipoPagamento", e.TipoPagamento),
                                                                new SqlParameter("@numeroBanco", e.NumeroBanco ?? string.Empty),
                                                                new SqlParameter("@agencia", e.Agencia ?? string.Empty),
                                                                new SqlParameter("@conta", e.Conta ?? string.Empty),
                                                                new SqlParameter("@cpf", e.CPF ?? string.Empty),
                                                                new SqlParameter("@nomeDeposito", e.NomeDeposito ?? string.Empty),
                                                                new SqlParameter("@observacao", e.Observacao ?? string.Empty),
                                                                new SqlParameter("@data", e.Data ?? (object)DBNull.Value),
                                                                new SqlParameter("@dataSolicitacao", RepUtil.DateTimeNowBR())
                                                        }))
            {
                while (dados.Read())
                    e.CodEstorno = Convert.ToInt64(dados["CodEstorno"]);

                return e;
            }
        }
        public Estorno EditarEstorno(Estorno e)
        {
            return RepUtil.ExecutaSQL(@"UPDATE Estorno  
                                        SET CodPedido = @codPedido, TipoPagamento = @tipoPagamento, NumeroBanco = @numeroBanco, Agencia = @agencia, Conta = @conta, CPF = @cpf, NomeDeposito = @nomeDeposito, Observacao = @observacao, Data = @data)
                                        WHERE CodEstorno = @codEstorno",
                                        new[] {
                                                new SqlParameter("@codEstorno", e.CodEstorno),
                                                new SqlParameter("@codPedido", e.CodPedido),
                                                new SqlParameter("@tipoPagamento", e.TipoPagamento),
                                                new SqlParameter("@numeroBanco", e.NumeroBanco ?? string.Empty),
                                                new SqlParameter("@agencia", e.Agencia ?? string.Empty),
                                                new SqlParameter("@conta", e.Conta ?? string.Empty),
                                                new SqlParameter("@cpf", e.CPF ?? string.Empty),
                                                new SqlParameter("@nomeDeposito", e.NomeDeposito ?? string.Empty),
                                                new SqlParameter("@observacao", e.Observacao ?? string.Empty),
                                                new SqlParameter("@data", e.Data ?? (object)DBNull.Value),
                                        }) > 0 ? e : null;
        }
        public Estorno ObterEstorno(long codPedido)
        {
            using (var dados = RepUtil.ExecuteReader("SELECT * FROM Estorno WHERE CodPedido = @codPedido",
                                                     new[] { new SqlParameter("@codPedido", codPedido) }))
            {
                var e = new Estorno();
                while(dados.Read())
                    e = PopularObjetoEstorno(dados);

                return e;
            }
        }
        public bool InserirIdWirecardEstorno(long codEstorno, string idWirecard)
        {
            return RepUtil.ExecutaSQL(@"UPDATE Estorno
                                     SET IdWirecard = @idWirecard
                                     WHERE CodEstorno = @codEstorno",
                                    new[] {
                                         new SqlParameter("@idWirecard", idWirecard),
                                         new SqlParameter("@codEstorno", codEstorno)
                                    }) > 0;
        }
        public bool FinalizarEstorno(long codEstorno)
        {
            return RepUtil.ExecutaSQL("UPDATE Estorno SET Data = @data WHERE CodEstorno = @codEstorno",
                                       new[] {
                                           new SqlParameter("@codEstorno", codEstorno),
                                           new SqlParameter("@data", RepUtil.DateTimeNowBR()),
                                       }) > 0;
        }
        public bool Salvar(Pedido p)
        {
            return RepUtil.ExecutaSQL($@"UPDATE Pedido SET 
                                        DataPrevista = @dataPrevista, 
                                        CodigoRastreio = @codigoRastreio 
                                        WHERE CodPedido = @codPedido",
                                        new[] {
                                            new SqlParameter("@codPedido", p.CodPedido),
                                            new SqlParameter("@dataPrevista", p.DataPrevista ?? (object)DBNull.Value),
                                            new SqlParameter("@codigoRastreio", p.CodigoRastreio ?? (object)DBNull.Value)
                                        }) > 0;
        }
        public bool MarcarEmailEnviado(long codPedido)
        {
            return RepUtil.ExecutaSQL($@"UPDATE Pedido SET EmailEnviado = 1 WHERE CodPedido = @codPedido",
                                       new[] {new SqlParameter("@codPedido", codPedido)}) > 0;
        }
        private List<Pedido> Listar(string command, SqlParameter[] parameters = null)
        {
            var list = new List<Pedido>();
            var itensPedidos = new List<ItemPedido>();
            var logStatusPedidos = new List<LogStatusPedido>();
            var pagamentos = new List<Pagamento>();
            var usuarios = new List<Usuario>();

            var repItemPedido = new RepItemPedido();
            var repLogStatusPedido = new RepLogStatusPedido();
            var repPagamento = new RepPagamento();
            var repUsuario = new RepUsuario();
            using (var dados = RepUtil.ExecuteReader(command, parameters))
            {
                while (dados.Read())
                    list.Add(PopularObjeto(dados));
                if (dados.NextResult())
                {
                    while (dados.Read())
                        itensPedidos.Add(repItemPedido.PopularObjeto(dados));
                }
                if (dados.NextResult())
                {
                    while (dados.Read())
                        logStatusPedidos.Add(repLogStatusPedido.PopularObjeto(dados));
                }
                if (dados.NextResult())
                {
                    while (dados.Read())
                        pagamentos.Add(repPagamento.PopularObjeto(dados));
                }
                if (dados.NextResult())
                {
                    while (dados.Read())
                        usuarios.Add(repUsuario.PopularObjeto(dados));
                }
            }
            list.ForEach(x =>
            {
                x.ItensPedido = itensPedidos.Where(z => z.CodPedido == x.CodPedido).ToList();
                x.LogStatusPedido = logStatusPedidos.Where(z => z.CodPedido == x.CodPedido).ToList();
                x.Pagamentos = pagamentos.Where(z => z.CodPedido == x.CodPedido).ToList();
                x.Usuario = usuarios.Where(z => z.CodUsuario == x.CodUsuario).FirstOrDefault();
            });
            return list;
        }
        private Pedido Obter(string command, SqlParameter[] parameters = null)
        {
            var p = new Pedido();
            var repItemPedido = new RepItemPedido();
            var repLogStatusPedido = new RepLogStatusPedido();
            var repPagamento = new RepPagamento();
            var repCupom = new RepCupom();
            var repUsuario = new RepUsuario();
            using (var dados = RepUtil.ExecuteReader(command, parameters))
            {
                while (dados.Read())
                    p = PopularObjeto(dados);
                if (dados.NextResult())
                {
                    while (dados.Read())
                        p.ItensPedido.Add(repItemPedido.PopularObjeto(dados));
                }
                if (dados.NextResult())
                {
                    while (dados.Read())
                        p.LogStatusPedido.Add(repLogStatusPedido.PopularObjeto(dados));
                }
                if (dados.NextResult())
                {
                    while (dados.Read())
                        p.Pagamentos.Add(repPagamento.PopularObjeto(dados));
                }
                if (dados.NextResult())
                {
                    while (dados.Read())
                        p.Cupom = repCupom.PopularObjeto(dados);
                }
                if (dados.NextResult())
                {
                    while (dados.Read())
                        p.Usuario = repUsuario.PopularObjeto(dados);
                }
            }
            return p;
        }
        private Pedido PopularObjeto(SqlDataReader sql)
        {
            return new Pedido
            {
                CodPedido = Convert.ToInt64(sql["CodPedido"]),
                CodUsuario = Convert.ToInt32(sql["CodUsuario"]),
                ValorTotal = Convert.ToDecimal(sql["ValorTotal"]),
                CodCupom = string.IsNullOrWhiteSpace(sql["CodCupom"].ToString()) ? 0 : Convert.ToInt32(sql["CodCupom"]),
                Data = Convert.ToDateTime(sql["Data"]),
                Observacao = sql["Observacao"].ToString(),
                CodigoRastreio = sql["CodigoRastreio"].ToString(),
                DataPrevista = string.IsNullOrWhiteSpace(sql["DataPrevista"].ToString())? (DateTime?)null : Convert.ToDateTime(sql["DataPrevista"]),
                ValorFrete = Convert.ToDecimal(sql["ValorFrete"]),
                IdWirecard = sql["IdWirecard"].ToString(),
                DiasFrete = Convert.ToInt32(sql["DiasFrete"]),
                EmailEnviado = Convert.ToBoolean(sql["EmailEnviado"]),
                TipoFrete = sql["TipoFrete"].ToString(),
                ItensPedido = new List<ItemPedido>(),
                LogStatusPedido = new List<LogStatusPedido>(),
                Pagamentos = new List<Pagamento>()
            };
        }
        private Estorno PopularObjetoEstorno(SqlDataReader sql)
        {
            return new Estorno
            {
                CodEstorno = Convert.ToInt64(sql["CodEstorno"]),
                CodPedido = Convert.ToInt64(sql["CodPedido"]),
                TipoPagamento = sql["TipoPagamento"].ToString(),
                NumeroBanco = sql["NumeroBanco"].ToString(),
                Agencia = sql["Agencia"].ToString(),
                Conta = sql["Conta"].ToString(),
                CPF = sql["CPF"].ToString(),
                NomeDeposito = sql["NomeDeposito"].ToString(),
                Observacao = sql["Observacao"].ToString(),
                Data = string.IsNullOrWhiteSpace(sql["Data"].ToString()) ? (DateTime?)null : Convert.ToDateTime(sql["Data"]),
                Pedido = Obter(Convert.ToInt64(sql["CodPedido"])),
                IdWirecard = sql["IdWirecard"].ToString(),
                DataSolicitacao = Convert.ToDateTime(sql["DataSolicitacao"])
            };
        }
    }
}