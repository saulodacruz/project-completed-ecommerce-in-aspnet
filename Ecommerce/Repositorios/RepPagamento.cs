using Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositorios
{
    public class RepPagamento
    {
        public Pagamento Cadastrar(Pagamento p)
        {
            try
            {
                using (var dados = RepUtil.ExecuteReader($@"INSERT INTO Pagamento (IdWirecardPagamento,Parcelas,Boleto,CodPedido,IdWirecardPedido,Data)
                                            VALUES(@idWirecardPagamento,@parcelas,@boleto,@codPedido,@idWirecardPedido,@data)",
                                            new[] {
                                                new SqlParameter("@idWirecardPagamento", p.IdWirecardPagamento),
                                                new SqlParameter("@parcelas", p.Parcelas),
                                                new SqlParameter("@boleto", p.Boleto),
                                                new SqlParameter("@codPedido", p.CodPedido),
                                                new SqlParameter("@idWirecardPedido", p.IdWirecardPedido),
                                                new SqlParameter("@data", RepUtil.DateTimeNowBR()),
                                            }))
                {
                    return p;
                };
            }
            catch
            {
                return null;
            }
        }
        public List<Pagamento> Obter(int codPedido)
        {
            return null;
        }
        public Pagamento PopularObjeto(SqlDataReader sql, bool vemDePedido = false)
        {
            return new Pagamento
            {
                IdWirecardPagamento = sql["IdWirecardPagamento"].ToString(),
                Parcelas = Convert.ToInt32(sql["Parcelas"]),
                Boleto = Convert.ToBoolean(sql["Boleto"]),
                CodPedido = Convert.ToInt64(sql["CodPedido"]),
                IdWirecardPedido = sql["IdWirecardPedido"].ToString(),
                Data = Convert.ToDateTime(sql["Data"])
            };
        }
    }
}
