using Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Threading.Tasks;
using Wirecard;
using Wirecard.Models;

namespace Servicos.Wirecard
{
    public class ConnectWirecard
    {
        private readonly WirecardClient WC = new WirecardClient
        (environments: Util.Producao ? Environments.PRODUCTION : Environments.SANDBOX,
         token: Util.Producao ? ConfigurationManager.AppSettings["WireTokenProd"].ToString() : ConfigurationManager.AppSettings["WireTokenDev"].ToString(),
         key: Util.Producao ? ConfigurationManager.AppSettings["WireKeyProd"].ToString() : ConfigurationManager.AppSettings["WireKeyDev"].ToString());
        public void Teste()
        {
            //var clientes = Task.Run(() => WC.Customer.List()).Result;
            //var pedidos = Task.Run(() => WC.Order.List()).Result;
            //var pedido = Task.Run(() => WC.Order.Consult("ORD-J4LG5H5N86A9")).Result;
            //CriarPedido();
            //CriarCliente();
        }
        public CustomerResponse CriarCliente(Usuario u)
        {
            CustomerRequest body()
            {
                var cr = new CustomerRequest
                {
                    OwnId = u.CodUsuario.ToString(),
                    FullName = u.Nome + " " + u.Sobrenome,
                    Email = u.Email,
                    BirthDate = $"{u.DataNascimento.Year}-{u.DataNascimento.Month}-{u.DataNascimento.Day}",
                    TaxDocument = new Taxdocument
                    {
                        Type = "CPF",
                        Number = u.CPF
                    },
                    Phone = new Phone
                    {
                        CountryCode = "55",
                        AreaCode = u.Telefone.Replace("(", "").Replace(")", "").Replace("-", "").Replace(" ", "").Substring(0, 2),
                        Number = u.Telefone.Replace("(", "").Replace(")", "").Replace("-", "").Replace(" ", "").Remove(0, 2)
                    },
                    ShippingAddress = new Shippingaddress
                    {
                        City = u.Cidade,
                        Complement = u.Complemento,
                        District = u.Bairro,
                        Street = u.Logradouro,
                        StreetNumber = u.Numero,
                        ZipCode = u.CEP,
                        State = u.UF,
                        Country = "BRA"
                    }
                };
                return cr;
            }
            try
            {
                return Task.Run(() => WC.Customer.Create(body())).Result;
            }
            catch
            {
                Task.Delay(2000).Wait();
                return Task.Run(() => WC.Customer.Create(body())).Result;
            }
        }
        public PaymentResponse ObterPagamento(string id)
        {
            try
            {
                return Task.Run(() => WC.Payment.Consult(id)).Result;
            }
            catch
            {
                Task.Delay(2000).Wait();
                return Task.Run(() => WC.Payment.Consult(id)).Result;
            }
        }
        public OrderResponse CriarPedido(Pedido p, decimal valorCupom)
        {
            OrderRequest body()
            {
                var or = new OrderRequest
                {
                    OwnId = p.CodPedido.ToString(),
                    Amount = new Amount
                    {
                        Currency = "BRL",
                        Subtotals = new Subtotals
                        {
                            Shipping = int.Parse(Math.Round(p.ValorFrete, 2).ToString().Replace(",", "").Replace(".", "")),
                            Discount = int.Parse(Math.Round(valorCupom, 2).ToString().Replace(",", "").Replace(".", ""))
                        }
                    },
                    Customer = new Customer
                    {
                        Id = p.Usuario.IdWirecard,
                        FullName = p.Usuario.Nome + " " + p.Usuario.Sobrenome,
                        Email = p.Usuario.Email,
                        BirthDate = $"{p.Usuario.DataNascimento.Year}-{p.Usuario.DataNascimento.Month}-{p.Usuario.DataNascimento.Day}",
                        Phone = new Phone
                        {
                            CountryCode = "55",
                            AreaCode = p.Usuario.Telefone.Replace("(", "").Replace(")", "").Replace("-", "").Replace(" ", "").Substring(0, 2),
                            Number = p.Usuario.Telefone.Replace("(", "").Replace(")", "").Replace("-", "").Replace(" ", "").Remove(0, 2)
                        },
                        TaxDocument = new Taxdocument
                        {
                            Type = "CPF",
                            Number = p.Usuario.CPF
                        },
                        ShippingAddress = new Shippingaddress
                        {
                            City = p.Usuario.EnderecoCobranca.Cidade,
                            Complement = p.Usuario.EnderecoCobranca.Complemento,
                            District = p.Usuario.EnderecoCobranca.Bairro,
                            Street = p.Usuario.EnderecoCobranca.Logradouro,
                            StreetNumber = p.Usuario.EnderecoCobranca.Numero,
                            ZipCode = p.Usuario.EnderecoCobranca.CEP,
                            State = p.Usuario.EnderecoCobranca.UF,
                            Country = "BRA"
                        }
                    },
                    Items = new List<Item>(),
                };
                p.ItensPedido.ForEach(x =>
                {
                    or.Items.Add(
                        new Item
                        {
                            Product = x.Produto.Nome,
                            Category = "APPAREL_AND_ACCESSORIES",
                            Quantity = x.Quantidade,
                            Detail = x.Observacao,
                            Price = int.Parse(Math.Round(x.Produto.Valor, 2).ToString().Replace(",", "").Replace(".", ""))
                        });
                });
                return or;
            }
            try
            {
                return Task.Run(() => WC.Order.Create(body())).Result;
            }
            catch
            {
                Task.Delay(2000).Wait();
                return Task.Run(() => WC.Order.Create(body())).Result;
            }
        }
        public PaymentResponse CriarPagamento(Pagamento p, Usuario u)
        {
            PaymentRequest body()
            {
                var datetime = Util.DateTimeNowBR().AddDays(15);
                var pr = p.Boleto ?
                    new PaymentRequest
                    {
                        FundingInstrument = new Fundinginstrument
                        {
                            Method = "BOLETO",
                            Boleto = new Boleto
                            {
                                ExpirationDate = datetime.ToString("yyyy-MM-dd")
                            }
                        }

                    }
                    :
                    new PaymentRequest
                    {
                        InstallmentCount = p.Parcelas,
                        FundingInstrument = new Fundinginstrument
                        {
                            Method = "CREDIT_CARD",
                            CreditCard = new Creditcard
                            {
                                Hash = p.Hash,
                                Holder = new Holder
                                {
                                    FullName = p.Nome,
                                    BirthDate = p.DataNascimento.ToString("yyyy-MM-dd"),
                                    TaxDocument = new Taxdocument
                                    {
                                        Type = "CPF",
                                        Number = p.CPF
                                    },
                                    Phone = new Phone
                                    {
                                        CountryCode = "55",
                                        AreaCode = u.Telefone.Replace("(", "").Replace(")", "").Replace("-", "").Replace(" ", "").Substring(0, 2),
                                        Number = u.Telefone.Replace("(", "").Replace(")", "").Replace("-", "").Replace(" ", "").Substring(2)
                                    },
                                    BillingAddress = new Billingaddress
                                    {
                                        City = u.EnderecoCobranca.Cidade,
                                        District = u.EnderecoCobranca.Bairro,
                                        Street = u.EnderecoCobranca.Logradouro,
                                        StreetNumber = u.EnderecoCobranca.Numero,
                                        ZipCode = u.EnderecoCobranca.CEP,
                                        State = u.EnderecoCobranca.UF,
                                        Country = "BRA"
                                    }
                                }
                            }
                        }
                    };
                return pr;
            }
            try
            {
                return Task.Run(() => WC.Payment.Create(body(), p.IdWirecardPedido)).Result;
            }
            catch
            {
                Task.Delay(2000).Wait();
                return Task.Run(() => WC.Payment.Create(body(), p.IdWirecardPedido)).Result;
            }
        }
        public OrderResponse ObterPedido(string id)
        {
            try
            {
                return Task.Run(() => WC.Order.Consult(id)).Result;
            }
            catch
            {
                Task.Delay(2000).Wait();
                return Task.Run(() => WC.Order.Consult(id)).Result;
            }
        }
        public RefundResponse ReembolsarPedido(Estorno e)
        {
            return Task.Run(() => WC.Refund.RefundRequestCreditCard(new RefundRequest(), e.Pedido.IdWirecard)).Result;
        }
    }
}