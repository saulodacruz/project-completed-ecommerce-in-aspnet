USE [saulodac_ecommerce]
GO
/****** Object:  User [saulodac_admin]    Script Date: 25/03/2020 01:44:12 ******/
CREATE USER [saulodac_admin] FOR LOGIN [saulodac_admin] WITH DEFAULT_SCHEMA=[saulodac_admin]
GO
ALTER ROLE [db_owner] ADD MEMBER [saulodac_admin]
GO
/****** Object:  Schema [saulodac_admin]    Script Date: 25/03/2020 01:44:13 ******/
CREATE SCHEMA [saulodac_admin]
GO
/****** Object:  Table [dbo].[Assinante]    Script Date: 25/03/2020 01:44:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Assinante](
	[Email] [varchar](200) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Avaliacao]    Script Date: 25/03/2020 01:44:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Avaliacao](
	[CodAvaliacao] [int] IDENTITY(1,1) NOT NULL,
	[CodUsuario] [int] NOT NULL,
	[CodProduto] [int] NOT NULL,
	[Estrelas] [int] NOT NULL,
	[Comentario] [varchar](250) NULL,
	[Data] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CodAvaliacao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Categoria]    Script Date: 25/03/2020 01:44:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Categoria](
	[CodCategoria] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](200) NOT NULL
) ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[Categoria] ADD [Descricao] [varchar](500) NULL
ALTER TABLE [dbo].[Categoria] ADD [DataDesabilitado] [datetime] NULL
PRIMARY KEY CLUSTERED 
(
	[CodCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cupom]    Script Date: 25/03/2020 01:44:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cupom](
	[CodCupom] [int] IDENTITY(1,1) NOT NULL,
	[Valor] [decimal](15, 2) NOT NULL,
	[Data] [datetime] NOT NULL,
	[DataDesabilitado] [datetime] NULL,
	[Codigo] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CodCupom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Emails]    Script Date: 25/03/2020 01:44:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Emails](
	[Email] [varchar](250) NOT NULL,
	[Data] [datetime] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Endereco]    Script Date: 25/03/2020 01:44:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Endereco](
	[CodEndereco] [int] IDENTITY(1,1) NOT NULL,
	[Logradouro] [varchar](100) NULL,
	[CEP] [varchar](10) NULL
) ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[Endereco] ADD [Bairro] [varchar](45) NULL
SET ANSI_PADDING OFF
ALTER TABLE [dbo].[Endereco] ADD [UF] [varchar](2) NULL
SET ANSI_PADDING ON
ALTER TABLE [dbo].[Endereco] ADD [Cidade] [varchar](32) NULL
ALTER TABLE [dbo].[Endereco] ADD [Numero] [varchar](10) NULL
SET ANSI_PADDING OFF
ALTER TABLE [dbo].[Endereco] ADD [Complemento] [varchar](50) NULL
PRIMARY KEY CLUSTERED 
(
	[CodEndereco] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Estorno]    Script Date: 25/03/2020 01:44:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Estorno](
	[CodEstorno] [bigint] IDENTITY(1,1) NOT NULL,
	[CodPedido] [bigint] NOT NULL,
	[TipoPagamento] [varchar](50) NOT NULL,
	[NumeroBanco] [varchar](10) NULL,
	[Agencia] [varchar](100) NULL,
	[Conta] [varchar](100) NULL,
	[CPF] [varchar](11) NULL,
	[NomeDeposito] [varchar](150) NULL,
	[Observacao] [varchar](200) NULL,
	[Data] [datetime] NULL,
	[IdWirecard] [varchar](250) NULL,
	[DataSolicitacao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CodEstorno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ImagemProduto]    Script Date: 25/03/2020 01:44:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ImagemProduto](
	[CodImagemProduto] [int] IDENTITY(1,1) NOT NULL,
	[CodProduto] [int] NOT NULL,
	[Url] [varchar](300) NOT NULL,
	[Ordem] [int] NOT NULL,
	[Miniatura] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CodImagemProduto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ItemCarrinho]    Script Date: 25/03/2020 01:44:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ItemCarrinho](
	[CodProduto] [int] NOT NULL,
	[CodUsuario] [int] NOT NULL,
	[Quantidade] [int] NOT NULL,
	[Observacao] [varchar](500) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ItemDesejo]    Script Date: 25/03/2020 01:44:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemDesejo](
	[CodProduto] [int] NOT NULL,
	[CodUsuario] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ItemPedido]    Script Date: 25/03/2020 01:44:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ItemPedido](
	[CodPedido] [bigint] NOT NULL,
	[CodProduto] [int] NOT NULL,
	[Quantidade] [int] NOT NULL,
	[Observacao] [varchar](500) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LogStatusPedido]    Script Date: 25/03/2020 01:44:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LogStatusPedido](
	[CodLogStatusPedido] [bigint] IDENTITY(1,1) NOT NULL,
	[CodPedido] [bigint] NOT NULL,
	[CodStatusPedido] [int] NOT NULL,
	[Data] [datetime] NOT NULL,
	[Observacao] [varchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[CodLogStatusPedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Pagamento]    Script Date: 25/03/2020 01:44:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pagamento](
	[IdWirecardPagamento] [varchar](250) NOT NULL,
	[Parcelas] [int] NOT NULL,
	[Boleto] [bit] NOT NULL,
	[CodPedido] [bigint] NOT NULL,
	[IdWirecardPedido] [varchar](250) NOT NULL,
	[Data] [datetime] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Pedido]    Script Date: 25/03/2020 01:44:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pedido](
	[CodPedido] [bigint] IDENTITY(1,1) NOT NULL,
	[CodUsuario] [int] NOT NULL,
	[ValorTotal] [decimal](15, 2) NOT NULL,
	[CodCupom] [int] NULL,
	[Data] [datetime] NOT NULL,
	[Observacao] [varchar](500) NULL,
	[CodigoRastreio] [varchar](200) NULL,
	[DataPrevista] [datetime] NULL,
	[ValorFrete] [decimal](15, 2) NOT NULL,
	[IdWirecard] [varchar](250) NULL,
	[DiasFrete] [int] NOT NULL,
	[EmailEnviado] [bit] NOT NULL,
	[TipoFrete] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CodPedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Permissao]    Script Date: 25/03/2020 01:44:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Permissao](
	[CodPermissao] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CodPermissao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Pessoa]    Script Date: 25/03/2020 01:44:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pessoa](
	[CodPessoa] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](40) NOT NULL
) ON [PRIMARY]
SET ANSI_PADDING OFF
ALTER TABLE [dbo].[Pessoa] ADD [CPF] [varchar](15) NULL
ALTER TABLE [dbo].[Pessoa] ADD [DataNascimento] [date] NULL
ALTER TABLE [dbo].[Pessoa] ADD [Telefone] [varchar](15) NULL
ALTER TABLE [dbo].[Pessoa] ADD [CodEndereco] [int] NOT NULL
SET ANSI_PADDING ON
ALTER TABLE [dbo].[Pessoa] ADD [Sobrenome] [varchar](49) NOT NULL
ALTER TABLE [dbo].[Pessoa] ADD [CodEnderecoCobranca] [int] NOT NULL
PRIMARY KEY CLUSTERED 
(
	[CodPessoa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Produto]    Script Date: 25/03/2020 01:44:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Produto](
	[CodProduto] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](200) NOT NULL,
	[Descricao] [varchar](500) NULL,
	[Valor] [decimal](15, 2) NOT NULL,
	[MateriaPrima] [varchar](200) NULL,
	[Altura] [decimal](15, 2) NOT NULL,
	[Largura] [decimal](15, 2) NOT NULL,
	[Comprimento] [decimal](15, 2) NOT NULL,
	[Espessura] [decimal](15, 2) NOT NULL,
	[DataDesabilitado] [datetime] NULL
) ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[Produto] ADD [UrlImgA] [varchar](300) NULL
ALTER TABLE [dbo].[Produto] ADD [UrlImgB] [varchar](300) NULL
ALTER TABLE [dbo].[Produto] ADD [UrlImgC] [varchar](300) NULL
ALTER TABLE [dbo].[Produto] ADD [UrlImgD] [varchar](300) NULL
ALTER TABLE [dbo].[Produto] ADD [DataCadastro] [datetime] NOT NULL
ALTER TABLE [dbo].[Produto] ADD [DataAtualizado] [datetime] NOT NULL
ALTER TABLE [dbo].[Produto] ADD [UrlImgASmall] [varchar](300) NULL
ALTER TABLE [dbo].[Produto] ADD [UrlImgBSmall] [varchar](300) NULL
ALTER TABLE [dbo].[Produto] ADD [Diametro] [decimal](15, 2) NOT NULL
ALTER TABLE [dbo].[Produto] ADD [Peso] [decimal](15, 2) NOT NULL
ALTER TABLE [dbo].[Produto] ADD [CodTipoEmbalagem] [char](1) NOT NULL
ALTER TABLE [dbo].[Produto] ADD [FreteGratis] [bit] NOT NULL
ALTER TABLE [dbo].[Produto] ADD [ProdutoEsgotado] [bit] NOT NULL
ALTER TABLE [dbo].[Produto] ADD [QtdDisponiveis] [int] NULL
ALTER TABLE [dbo].[Produto] ADD [OcultarProduto] [bit] NOT NULL
ALTER TABLE [dbo].[Produto] ADD [ValorAnterior] [decimal](15, 2) NULL
ALTER TABLE [dbo].[Produto] ADD [ValorAtacado] [decimal](15, 2) NULL
ALTER TABLE [dbo].[Produto] ADD [ObsBackOffice] [varchar](2000) NULL
ALTER TABLE [dbo].[Produto] ADD [Relevancia] [int] NOT NULL DEFAULT ((0))
PRIMARY KEY CLUSTERED 
(
	[CodProduto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProdutoCategoria]    Script Date: 25/03/2020 01:44:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProdutoCategoria](
	[CodCategoria] [int] NOT NULL,
	[CodProduto] [int] NOT NULL,
	[CategoriaPrincipal] [bit] NOT NULL DEFAULT ((0))
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProdutoObservacoes]    Script Date: 25/03/2020 01:44:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProdutoObservacoes](
	[CodProdutoObservacoes] [int] IDENTITY(1,1) NOT NULL,
	[CodProduto] [int] NULL,
	[Nome] [varchar](50) NOT NULL,
	[Tipo] [varchar](50) NOT NULL,
	[OpcoesCombo] [varchar](300) NULL,
	[Obrigatorio] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CodProdutoObservacoes] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StatusPedido]    Script Date: 25/03/2020 01:44:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StatusPedido](
	[CodStatusPedido] [int] NOT NULL,
	[Nome] [varchar](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CodStatusPedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TipoEmbalagem]    Script Date: 25/03/2020 01:44:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TipoEmbalagem](
	[CodTipoEmbalagem] [char](1) NOT NULL,
	[Altura] [decimal](15, 2) NOT NULL,
	[Largura] [decimal](15, 2) NOT NULL,
	[Comprimento] [decimal](15, 2) NOT NULL,
	[Diametro] [decimal](15, 2) NOT NULL,
	[Peso] [decimal](15, 2) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 25/03/2020 01:44:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuario](
	[CodUsuario] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](90) NOT NULL
) ON [PRIMARY]
SET ANSI_PADDING OFF
ALTER TABLE [dbo].[Usuario] ADD [Senha] [varchar](400) NOT NULL
ALTER TABLE [dbo].[Usuario] ADD [CodPessoa] [int] NOT NULL
ALTER TABLE [dbo].[Usuario] ADD [DataExclusao] [datetime] NULL
ALTER TABLE [dbo].[Usuario] ADD [DataCadastro] [datetime] NOT NULL
SET ANSI_PADDING ON
ALTER TABLE [dbo].[Usuario] ADD [IdWirecard] [varchar](250) NULL
PRIMARY KEY CLUSTERED 
(
	[CodUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UsuarioPermissao]    Script Date: 25/03/2020 01:44:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuarioPermissao](
	[CodUsuario] [int] NOT NULL,
	[CodPermissao] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [saulodac_admin].[EmailCodigo]    Script Date: 25/03/2020 01:44:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [saulodac_admin].[EmailCodigo](
	[Email] [varchar](256) NOT NULL,
	[Codigo] [varchar](4) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Categoria] ON 

INSERT [dbo].[Categoria] ([CodCategoria], [Nome], [Descricao], [DataDesabilitado]) VALUES (23, N'Aneis', N'Anéis', NULL)
INSERT [dbo].[Categoria] ([CodCategoria], [Nome], [Descricao], [DataDesabilitado]) VALUES (24, N'Colares', N'Colares', NULL)
INSERT [dbo].[Categoria] ([CodCategoria], [Nome], [Descricao], [DataDesabilitado]) VALUES (26, N'Pulseiras', N'Pulseiras', NULL)
INSERT [dbo].[Categoria] ([CodCategoria], [Nome], [Descricao], [DataDesabilitado]) VALUES (32, N'Berloques', N'Berloques', NULL)
INSERT [dbo].[Categoria] ([CodCategoria], [Nome], [Descricao], [DataDesabilitado]) VALUES (33, N'Em-destaque', N'Em destaque', NULL)
INSERT [dbo].[Categoria] ([CodCategoria], [Nome], [Descricao], [DataDesabilitado]) VALUES (34, N'Aneis-Com-Pedra', N'Aneis com Pedra', NULL)
INSERT [dbo].[Categoria] ([CodCategoria], [Nome], [Descricao], [DataDesabilitado]) VALUES (35, N'Brincos', N'Brincos', NULL)
INSERT [dbo].[Categoria] ([CodCategoria], [Nome], [Descricao], [DataDesabilitado]) VALUES (36, N'Colares-Com-Pedra', N'Colares com Pedra', NULL)
INSERT [dbo].[Categoria] ([CodCategoria], [Nome], [Descricao], [DataDesabilitado]) VALUES (37, N'Brincos-Com-Pedra', N'Brincos com Pedra', NULL)
INSERT [dbo].[Categoria] ([CodCategoria], [Nome], [Descricao], [DataDesabilitado]) VALUES (38, N'Pulseiras-Com-Pedra', N'Pulseiras com Pedra', NULL)
INSERT [dbo].[Categoria] ([CodCategoria], [Nome], [Descricao], [DataDesabilitado]) VALUES (39, N'Correntes', N'Correntes', NULL)
SET IDENTITY_INSERT [dbo].[Categoria] OFF
SET IDENTITY_INSERT [dbo].[Cupom] ON 

INSERT [dbo].[Cupom] ([CodCupom], [Valor], [Data], [DataDesabilitado], [Codigo]) VALUES (15, CAST(10.00 AS Decimal(15, 2)), CAST(N'2020-03-25 00:00:00.000' AS DateTime), NULL, N'ING10')
SET IDENTITY_INSERT [dbo].[Cupom] OFF
INSERT [dbo].[Emails] ([Email], [Data]) VALUES (N'sa@sa.com', CAST(N'2020-02-28 10:16:24.637' AS DateTime))
INSERT [dbo].[Emails] ([Email], [Data]) VALUES (N'Aaa@a.com', CAST(N'2020-02-28 17:26:35.430' AS DateTime))
INSERT [dbo].[Emails] ([Email], [Data]) VALUES (N'spinellibisneto@gmail.com', CAST(N'2020-03-08 07:56:51.140' AS DateTime))
INSERT [dbo].[Emails] ([Email], [Data]) VALUES (N'Saulodacruz1999@hotmail.com', CAST(N'2020-03-11 21:49:30.513' AS DateTime))
INSERT [dbo].[Emails] ([Email], [Data]) VALUES (N'tattysorriso@outlook.com', CAST(N'2020-03-19 22:46:26.463' AS DateTime))
INSERT [dbo].[Emails] ([Email], [Data]) VALUES (N'teste@gmail.com', CAST(N'2020-03-24 17:13:09.860' AS DateTime))
SET IDENTITY_INSERT [dbo].[Endereco] ON 

INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (19, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'1sasas', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (20, N'Rua São Bento', N'01010000', N'Centro', N'SP', N'São Paulo', N'15', N'até 318 - lado par')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (21, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'1', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (23, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'169', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (25, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'1', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (27, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'1', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (29, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'1', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (31, N'Rua Anísio da Silveira', N'06065230', N'Jaguaribe', N'SP', N'Osasco', N'500', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (33, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'1', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (35, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'1', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (37, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'1', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (39, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'17', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (41, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'1', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (43, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'169', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (45, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'5', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (47, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'1', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (49, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'169', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (51, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'12', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (53, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'111', N'Qq')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (55, N'Travessa Antônio Leite dos Santos', N'03614080', N'Vila Santana', N'SP', N'São Paulo', N'7', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (57, N'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', N'11111111', N'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', N'AC', N'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', N'AAAAAAAAAA', N'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (59, N'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', N'11111111', N'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', N'AC', N'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', N'AAAAAAAAAA', N'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (61, N'1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111', N'1111111', N'111111111111111111111111111111111111111111111', N'DF', N'11111111111111111111111111111111', N'1111111111', N'11111111111111111111111111111111111111111111111111')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (64, N'Rodovia Engenheiro Miguel Noel Nascentes Burnier Km 2', N'13088900', N'Parque São Quirino', N'SP', N'Campinas', N'800', N'5')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (66, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'169', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (68, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'1', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (70, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'169', N't  4 254')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (72, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'169', N't  4 254')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (74, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'169', N't  4 254')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (76, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'12', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (78, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'12', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (80, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'12', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (82, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'6', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (84, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'1', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (86, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'169', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (88, N'Avenida Cruz Cabugá', N'50040000', N'Santo Amaro', N'PE', N'Recife', N'06', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (90, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'7', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (92, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'169', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (94, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'169', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (96, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'12', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (98, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'169', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (100, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'1', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (102, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'1', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (104, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'169', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (106, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'19', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (108, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N's', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (110, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'169', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (112, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'169', N'T 2 54')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (113, N'Rua Duque de Caxias', N'13322122', N'Jardim Bandeirantes', N'SP', N'Salto', N'206', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (114, N'Rua Duque de Caxias', N'13322122', N'Jardim Bandeirantes', N'SP', N'Salto', N'206', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (115, N'Rua Colibrí', N'79040200', N'Vila Manoel da costa Lima', N'MS', N'Campo Grande', N'72', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (116, N'Rua Colibrí', N'79040200', N'Vila Manoel da costa Lima', N'MS', N'Campo Grande', N'72', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (117, N'Rua Anísio da Silveira', N'06065230', N'Jaguaribe', N'SP', N'Osasco', N'500', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (118, N'Rua Anísio da Silveira', N'06065230', N'Jaguaribe', N'SP', N'Osasco', N'500', N'')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (119, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'169', N'Torre 2 apto 54')
INSERT [dbo].[Endereco] ([CodEndereco], [Logradouro], [CEP], [Bairro], [UF], [Cidade], [Numero], [Complemento]) VALUES (120, N'Via Transversal Sul', N'06045420', N'Novo Osasco', N'SP', N'Osasco', N'169', N'Torre 2 apto 54')
SET IDENTITY_INSERT [dbo].[Endereco] OFF
SET IDENTITY_INSERT [dbo].[Estorno] ON 

INSERT [dbo].[Estorno] ([CodEstorno], [CodPedido], [TipoPagamento], [NumeroBanco], [Agencia], [Conta], [CPF], [NomeDeposito], [Observacao], [Data], [IdWirecard], [DataSolicitacao]) VALUES (10086, 311, N'CREDITO', N'0', N'', N'', N'', N'', N'', CAST(N'2020-03-24 18:43:26.770' AS DateTime), N'REF-E0M5EFL8MO6B', CAST(N'2020-03-24 18:43:25.123' AS DateTime))
SET IDENTITY_INSERT [dbo].[Estorno] OFF
INSERT [dbo].[ItemDesejo] ([CodProduto], [CodUsuario]) VALUES (3215, 68)
INSERT [dbo].[ItemDesejo] ([CodProduto], [CodUsuario]) VALUES (3214, 68)
INSERT [dbo].[ItemPedido] ([CodPedido], [CodProduto], [Quantidade], [Observacao]) VALUES (312, 3174, 2, N' ')
INSERT [dbo].[ItemPedido] ([CodPedido], [CodProduto], [Quantidade], [Observacao]) VALUES (303, 3207, 1, N' ')
INSERT [dbo].[ItemPedido] ([CodPedido], [CodProduto], [Quantidade], [Observacao]) VALUES (303, 3162, 1, N' ')
INSERT [dbo].[ItemPedido] ([CodPedido], [CodProduto], [Quantidade], [Observacao]) VALUES (308, 3148, 1, N' ')
INSERT [dbo].[ItemPedido] ([CodPedido], [CodProduto], [Quantidade], [Observacao]) VALUES (309, 3185, 1, N' ')
INSERT [dbo].[ItemPedido] ([CodPedido], [CodProduto], [Quantidade], [Observacao]) VALUES (304, 3214, 1, N' ')
INSERT [dbo].[ItemPedido] ([CodPedido], [CodProduto], [Quantidade], [Observacao]) VALUES (311, 3180, 1, N' ')
SET IDENTITY_INSERT [dbo].[LogStatusPedido] ON 

INSERT [dbo].[LogStatusPedido] ([CodLogStatusPedido], [CodPedido], [CodStatusPedido], [Data], [Observacao]) VALUES (20654, 303, 1, CAST(N'2020-03-24 08:00:14.830' AS DateTime), N'')
INSERT [dbo].[LogStatusPedido] ([CodLogStatusPedido], [CodPedido], [CodStatusPedido], [Data], [Observacao]) VALUES (20655, 303, 3, CAST(N'2020-03-24 08:00:39.423' AS DateTime), N'')
INSERT [dbo].[LogStatusPedido] ([CodLogStatusPedido], [CodPedido], [CodStatusPedido], [Data], [Observacao]) VALUES (20656, 304, 1, CAST(N'2020-03-24 12:22:37.490' AS DateTime), N'')
INSERT [dbo].[LogStatusPedido] ([CodLogStatusPedido], [CodPedido], [CodStatusPedido], [Data], [Observacao]) VALUES (20657, 304, 4, CAST(N'2020-03-24 12:24:11.717' AS DateTime), N'')
INSERT [dbo].[LogStatusPedido] ([CodLogStatusPedido], [CodPedido], [CodStatusPedido], [Data], [Observacao]) VALUES (20658, 304, 7, CAST(N'2020-03-24 22:26:06.770' AS DateTime), N'')
INSERT [dbo].[LogStatusPedido] ([CodLogStatusPedido], [CodPedido], [CodStatusPedido], [Data], [Observacao]) VALUES (20668, 308, 1, CAST(N'2020-03-24 15:28:35.053' AS DateTime), N'')
INSERT [dbo].[LogStatusPedido] ([CodLogStatusPedido], [CodPedido], [CodStatusPedido], [Data], [Observacao]) VALUES (20669, 308, 4, CAST(N'2020-03-24 15:30:05.747' AS DateTime), N'')
INSERT [dbo].[LogStatusPedido] ([CodLogStatusPedido], [CodPedido], [CodStatusPedido], [Data], [Observacao]) VALUES (20670, 308, 7, CAST(N'2020-03-24 22:26:06.770' AS DateTime), N'')
INSERT [dbo].[LogStatusPedido] ([CodLogStatusPedido], [CodPedido], [CodStatusPedido], [Data], [Observacao]) VALUES (20672, 309, 1, CAST(N'2020-03-24 15:37:03.040' AS DateTime), N'')
INSERT [dbo].[LogStatusPedido] ([CodLogStatusPedido], [CodPedido], [CodStatusPedido], [Data], [Observacao]) VALUES (20673, 309, 4, CAST(N'2020-03-24 15:38:23.283' AS DateTime), N'')
INSERT [dbo].[LogStatusPedido] ([CodLogStatusPedido], [CodPedido], [CodStatusPedido], [Data], [Observacao]) VALUES (20674, 309, 7, CAST(N'2020-03-24 22:26:06.770' AS DateTime), N'')
INSERT [dbo].[LogStatusPedido] ([CodLogStatusPedido], [CodPedido], [CodStatusPedido], [Data], [Observacao]) VALUES (20676, 311, 1, CAST(N'2020-03-24 18:39:01.483' AS DateTime), N'')
INSERT [dbo].[LogStatusPedido] ([CodLogStatusPedido], [CodPedido], [CodStatusPedido], [Data], [Observacao]) VALUES (20677, 311, 4, CAST(N'2020-03-24 18:41:43.457' AS DateTime), N'')
INSERT [dbo].[LogStatusPedido] ([CodLogStatusPedido], [CodPedido], [CodStatusPedido], [Data], [Observacao]) VALUES (20678, 311, 6, CAST(N'2020-03-24 18:41:46.000' AS DateTime), N'')
INSERT [dbo].[LogStatusPedido] ([CodLogStatusPedido], [CodPedido], [CodStatusPedido], [Data], [Observacao]) VALUES (20679, 311, 12, CAST(N'2020-03-24 18:43:25.297' AS DateTime), N'')
INSERT [dbo].[LogStatusPedido] ([CodLogStatusPedido], [CodPedido], [CodStatusPedido], [Data], [Observacao]) VALUES (20680, 311, 8, CAST(N'2020-03-24 18:43:26.930' AS DateTime), N'')
INSERT [dbo].[LogStatusPedido] ([CodLogStatusPedido], [CodPedido], [CodStatusPedido], [Data], [Observacao]) VALUES (20681, 312, 1, CAST(N'2020-03-25 01:14:34.400' AS DateTime), N'')
INSERT [dbo].[LogStatusPedido] ([CodLogStatusPedido], [CodPedido], [CodStatusPedido], [Data], [Observacao]) VALUES (20682, 312, 4, CAST(N'2020-03-25 01:15:26.097' AS DateTime), N'')
INSERT [dbo].[LogStatusPedido] ([CodLogStatusPedido], [CodPedido], [CodStatusPedido], [Data], [Observacao]) VALUES (20683, 312, 6, CAST(N'2020-03-25 01:15:29.000' AS DateTime), N'')
SET IDENTITY_INSERT [dbo].[LogStatusPedido] OFF
INSERT [dbo].[Pagamento] ([IdWirecardPagamento], [Parcelas], [Boleto], [CodPedido], [IdWirecardPedido], [Data]) VALUES (N'PAY-Q2LU01R1ECTQ', 1, 0, 304, N'ORD-2BNGR6T3FC1L', CAST(N'2020-03-24 12:24:11.700' AS DateTime))
INSERT [dbo].[Pagamento] ([IdWirecardPagamento], [Parcelas], [Boleto], [CodPedido], [IdWirecardPedido], [Data]) VALUES (N'PAY-ACHNHHM6P7Z1', 1, 0, 311, N'ORD-IBG79D723EDT', CAST(N'2020-03-24 18:41:43.290' AS DateTime))
INSERT [dbo].[Pagamento] ([IdWirecardPagamento], [Parcelas], [Boleto], [CodPedido], [IdWirecardPedido], [Data]) VALUES (N'PAY-M9GZZ0CV50CE', 1, 0, 309, N'ORD-LAWCUHV9LYR9', CAST(N'2020-03-24 15:38:23.253' AS DateTime))
INSERT [dbo].[Pagamento] ([IdWirecardPagamento], [Parcelas], [Boleto], [CodPedido], [IdWirecardPedido], [Data]) VALUES (N'PAY-SDB9FFSDY0JS', 1, 0, 312, N'ORD-5U0FSKH6DRCH', CAST(N'2020-03-25 01:15:25.957' AS DateTime))
INSERT [dbo].[Pagamento] ([IdWirecardPagamento], [Parcelas], [Boleto], [CodPedido], [IdWirecardPedido], [Data]) VALUES (N'PAY-7AEO7GQTC3OS', 1, 0, 308, N'ORD-48F1TJRVJTH2', CAST(N'2020-03-24 15:30:05.730' AS DateTime))
INSERT [dbo].[Pagamento] ([IdWirecardPagamento], [Parcelas], [Boleto], [CodPedido], [IdWirecardPedido], [Data]) VALUES (N'PAY-LEMAI38KMIVC', 1, 1, 303, N'ORD-4H5UXDY7FDRX', CAST(N'2020-03-24 08:00:39.423' AS DateTime))
SET IDENTITY_INSERT [dbo].[Pedido] ON 

INSERT [dbo].[Pedido] ([CodPedido], [CodUsuario], [ValorTotal], [CodCupom], [Data], [Observacao], [CodigoRastreio], [DataPrevista], [ValorFrete], [IdWirecard], [DiasFrete], [EmailEnviado], [TipoFrete]) VALUES (303, 65, CAST(129.99 AS Decimal(15, 2)), NULL, CAST(N'2020-03-24 08:00:14.723' AS DateTime), N'', N'', NULL, CAST(10.19 AS Decimal(15, 2)), N'ORD-4H5UXDY7FDRX', 2, 0, N'SEDEX')
INSERT [dbo].[Pedido] ([CodPedido], [CodUsuario], [ValorTotal], [CodCupom], [Data], [Observacao], [CodigoRastreio], [DataPrevista], [ValorFrete], [IdWirecard], [DiasFrete], [EmailEnviado], [TipoFrete]) VALUES (304, 66, CAST(74.46 AS Decimal(15, 2)), NULL, CAST(N'2020-03-24 12:22:37.427' AS DateTime), N'', N'', NULL, CAST(29.56 AS Decimal(15, 2)), N'ORD-2BNGR6T3FC1L', 3, 0, N'SEDEX')
INSERT [dbo].[Pedido] ([CodPedido], [CodUsuario], [ValorTotal], [CodCupom], [Data], [Observacao], [CodigoRastreio], [DataPrevista], [ValorFrete], [IdWirecard], [DiasFrete], [EmailEnviado], [TipoFrete]) VALUES (308, 67, CAST(40.09 AS Decimal(15, 2)), NULL, CAST(N'2020-03-24 15:28:35.023' AS DateTime), N'', N'', NULL, CAST(10.19 AS Decimal(15, 2)), N'ORD-48F1TJRVJTH2', 2, 0, N'SEDEX')
INSERT [dbo].[Pedido] ([CodPedido], [CodUsuario], [ValorTotal], [CodCupom], [Data], [Observacao], [CodigoRastreio], [DataPrevista], [ValorFrete], [IdWirecard], [DiasFrete], [EmailEnviado], [TipoFrete]) VALUES (309, 67, CAST(59.09 AS Decimal(15, 2)), NULL, CAST(N'2020-03-24 15:37:02.993' AS DateTime), N'', N'', NULL, CAST(10.19 AS Decimal(15, 2)), N'ORD-LAWCUHV9LYR9', 2, 0, N'SEDEX')
INSERT [dbo].[Pedido] ([CodPedido], [CodUsuario], [ValorTotal], [CodCupom], [Data], [Observacao], [CodigoRastreio], [DataPrevista], [ValorFrete], [IdWirecard], [DiasFrete], [EmailEnviado], [TipoFrete]) VALUES (311, 68, CAST(160.09 AS Decimal(15, 2)), NULL, CAST(N'2020-03-24 18:39:00.633' AS DateTime), N'', N'', NULL, CAST(10.19 AS Decimal(15, 2)), N'ORD-IBG79D723EDT', 2, 0, N'SEDEX')
INSERT [dbo].[Pedido] ([CodPedido], [CodUsuario], [ValorTotal], [CodCupom], [Data], [Observacao], [CodigoRastreio], [DataPrevista], [ValorFrete], [IdWirecard], [DiasFrete], [EmailEnviado], [TipoFrete]) VALUES (312, 68, CAST(249.99 AS Decimal(15, 2)), NULL, CAST(N'2020-03-25 01:14:33.653' AS DateTime), N'', N'', NULL, CAST(10.19 AS Decimal(15, 2)), N'ORD-5U0FSKH6DRCH', 2, 0, N'SEDEX')
SET IDENTITY_INSERT [dbo].[Pedido] OFF
SET IDENTITY_INSERT [dbo].[Permissao] ON 

INSERT [dbo].[Permissao] ([CodPermissao], [Nome]) VALUES (1, N'Cliente')
SET IDENTITY_INSERT [dbo].[Permissao] OFF
SET IDENTITY_INSERT [dbo].[Pessoa] ON 

INSERT [dbo].[Pessoa] ([CodPessoa], [Nome], [CPF], [DataNascimento], [Telefone], [CodEndereco], [Sobrenome], [CodEnderecoCobranca]) VALUES (65, N'nilson', N'09919118818', CAST(N'1971-10-23' AS Date), N'(47) 98872-1531', 113, N'cruz', 114)
INSERT [dbo].[Pessoa] ([CodPessoa], [Nome], [CPF], [DataNascimento], [Telefone], [CodEndereco], [Sobrenome], [CodEnderecoCobranca]) VALUES (66, N'Leticia', N'02726543022', CAST(N'1993-01-22' AS Date), N'(55) 99137-0022', 115, N'Teixeira', 116)
INSERT [dbo].[Pessoa] ([CodPessoa], [Nome], [CPF], [DataNascimento], [Telefone], [CodEndereco], [Sobrenome], [CodEnderecoCobranca]) VALUES (67, N'Erika Maria Betânia', N'46075965823', CAST(N'1996-06-25' AS Date), N'(11) 97660-3585', 117, N'Sotero', 118)
INSERT [dbo].[Pessoa] ([CodPessoa], [Nome], [CPF], [DataNascimento], [Telefone], [CodEndereco], [Sobrenome], [CodEnderecoCobranca]) VALUES (68, N'Saulo', N'43199225810', CAST(N'1999-01-12' AS Date), N'(11) 97053-8505', 119, N'Cruz', 120)
SET IDENTITY_INSERT [dbo].[Pessoa] OFF
SET IDENTITY_INSERT [dbo].[Produto] ON 

INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3137, N'Trava de Segurança de Prata com Corrente', N'A trava de segurança serve para que ao abrir a sua pulseira os seus berloques não saiam, ou acidentalmente a pulseira abra os berloques permaneceram na pulseira. Esse é um item indispensável para a sua coleção.', CAST(69.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3137/Trava-de-Segurança-de-Prata-com-Corrente-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3137/Trava-de-Segurança-de-Prata-com-Corrente-B.jpg', N'', N'', CAST(N'2020-03-21 16:13:22.043' AS DateTime), CAST(N'2020-03-24 00:21:02.307' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3137/Trava-de-Segurança-de-Prata-com-Corrente-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(25.90 AS Decimal(15, 2)), N'0131978
PING. TRAVA PEGA LADRAO FECHO POL. 7CM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3138, N'Pulsera de Prata Life para Berloques', N'', CAST(159.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3138/Pulsera-de-Prata-Life-para-Berloques-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3138/Pulsera-de-Prata-Life-para-Berloques-B.jpg', N'', N'', CAST(N'2020-03-21 16:15:58.220' AS DateTime), CAST(N'2020-03-24 00:20:36.670' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3138/Pulsera-de-Prata-Life-para-Berloques-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(79.00 AS Decimal(15, 2)), N'0150066
PULS. R72 FECHO TRAVA 17/18/19/20/21//22', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3139, N'Anel Solitário de Prata Base Cravejada com Zircônia', N'', CAST(89.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3139/Anel-Solitário-de-Prata-Base-Cravejada-com-Zircônia-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3139/Anel-Solitário-de-Prata-Base-Cravejada-com-Zircônia-B.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3139/Anel-Solitário-de-Prata-Base-Cravejada-com-Zircônia-C.jpg', N'', CAST(N'2020-03-21 18:47:20.590' AS DateTime), CAST(N'2020-03-24 00:19:53.480' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3139/Anel-Solitário-de-Prata-Base-Cravejada-com-Zircônia-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(17.90 AS Decimal(15, 2)), N'0310223
AN. SOLIT. BASE CUBA LAT. ZIRC. 4MM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3140, N'Anel Solitário de Prata Detalhado com Zircônia', N'', CAST(79.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3140/Anel-Solitário-de-Prata-Detalhado-com-Zircônia-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3140/Anel-Solitário-de-Prata-Detalhado-com-Zircônia-B.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3140/Anel-Solitário-de-Prata-Detalhado-com-Zircônia-C.jpg', N'', CAST(N'2020-03-21 18:48:41.870' AS DateTime), CAST(N'2020-03-24 00:19:45.807' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3140/Anel-Solitário-de-Prata-Detalhado-com-Zircônia-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(12.50 AS Decimal(15, 2)), N'0310225
AN. SOLIT. LAT. TRAB. 4MM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3141, N'Berloque de Prata Nossa Senhora com Pedras Zircônia Azul', N'', CAST(58.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3141/Berloque-de-Prata-Nossa-Senhora-com-Pedras-Zircônia-Azul-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3141/Berloque-de-Prata-Nossa-Senhora-com-Pedras-Zircônia-Azul-B.jpg', N'', N'', CAST(N'2020-03-21 18:51:24.327' AS DateTime), CAST(N'2020-03-23 23:34:40.607' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3141/Berloque-de-Prata-Nossa-Senhora-com-Pedras-Zircônia-Azul-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(25.50 AS Decimal(15, 2)), N'0330306
PING. N.S.A. ZIRC. AZUL SEP. POL. 25MM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3142, N'Berloque de Prata Chimarrão', N'', CAST(48.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3142/Berloque-de-Prata-Chimarrão-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3142/Berloque-de-Prata-Chimarrão-B.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3142/Berloque-de-Prata-Chimarrão-C.jpg', N'', CAST(N'2020-03-21 18:52:28.033' AS DateTime), CAST(N'2020-03-23 23:33:57.823' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3142/Berloque-de-Prata-Chimarrão-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(12.90 AS Decimal(15, 2)), N'0330855
PING. SEP. CHIMARRAO ENV. 12MM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3143, N'Berloque de Prata Cachorro com Osso', N'', CAST(48.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3143/Berloque-de-Prata-Cachorro-com-Osso-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3143/Berloque-de-Prata-Cachorro-com-Osso-B.jpg', N'', N'', CAST(N'2020-03-21 18:54:37.620' AS DateTime), CAST(N'2020-03-23 23:33:32.097' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3143/Berloque-de-Prata-Cachorro-com-Osso-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(18.40 AS Decimal(15, 2)), N'0330868
PING. SEP. CACHORRO COM OSSO ENV. 16MM ', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3145, N'Berloque de Prata com Pedras de Zircônia Azul', N'', CAST(79.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3145/Berloque-de-Prata-com-Pedras-de-Zircônia-Azul-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3145/Berloque-de-Prata-com-Pedras-de-Zircônia-Azul-B.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3145/Berloque-de-Prata-com-Pedras-de-Zircônia-Azul-C.jpg', N'', CAST(N'2020-03-21 18:59:01.990' AS DateTime), CAST(N'2020-03-23 23:52:15.393' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3145/Berloque-de-Prata-com-Pedras-de-Zircônia-Azul-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(31.50 AS Decimal(15, 2)), N'0331912
PING. SEP. OVAL TRAB. ZIRC. AZUL 12MM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3146, N'Brinco de Prata com Zircônia Quadrada Vermelha', N'', CAST(29.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3146/Brinco-de-Prata-com-Zircônia-Quadrada-Vermelha-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3146/Brinco-de-Prata-com-Zircônia-Quadrada-Vermelha-B.jpg', N'', N'', CAST(N'2020-03-21 19:00:18.750' AS DateTime), CAST(N'2020-03-24 00:22:37.110' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3146/Brinco-de-Prata-com-Zircônia-Quadrada-Vermelha-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(33.70 AS Decimal(15, 2)), N'0520203
BR. ZIRC. QUAD. VERM. 5MM COM 4 PARES', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3147, N'Brinco de Prata com Zircônia Redonda Média', N'', CAST(39.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3147/Brinco-de-Prata-com-Zircônia-Redonda-Média-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3147/Brinco-de-Prata-com-Zircônia-Redonda-Média-B.jpg', N'', N'', CAST(N'2020-03-21 19:02:09.237' AS DateTime), CAST(N'2020-03-24 01:46:34.000' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3147/Brinco-de-Prata-com-Zircônia-Redonda-Média-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(41.90 AS Decimal(15, 2)), N'0520204
BR. ZIRC. RED. BRANCA 6MM C/4 PARES', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3148, N'Brinco de Prata com Zircônia Redonda Pequena', N'', CAST(29.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3148/Brinco-de-Prata-com-Zircônia-Pequeno-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3148/Brinco-de-Prata-com-Zircônia-Pequeno-B.jpg', N'', N'', CAST(N'2020-03-21 19:03:44.123' AS DateTime), CAST(N'2020-03-24 00:21:47.203' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3148/Brinco-de-Prata-com-Zircônia-Redonda-Pequena-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(35.90 AS Decimal(15, 2)), N'0520423
BR. ZIRC. RED. BRANCA 3,5MM C/4 PARES', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3149, N'Brinco de Prata Coração com Zircônia', N'', CAST(39.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3149/Brinco-de-Prata-Coração-com-Zircônia-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3149/Brinco-de-Prata-Coração-com-Zircônia-B.jpg', N'', N'', CAST(N'2020-03-21 19:05:01.793' AS DateTime), CAST(N'2020-03-24 00:18:28.773' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3149/Brinco-de-Prata-Coração-com-Zircônia-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(43.90 AS Decimal(15, 2)), N'0520593
BR. ZIRC. COR. BRANCA 6MM C/4 PARES', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3150, N'Brinco de Prata Bola Média', N'', CAST(49.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3150/Brinco-de-Prata-Bola-Média-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3150/Brinco-de-Prata-Bola-Média-B.jpg', N'', N'', CAST(N'2020-03-21 19:06:17.443' AS DateTime), CAST(N'2020-03-24 01:50:45.307' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3150/Brinco-de-Prata-Bola-Média-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(40.90 AS Decimal(15, 2)), N'0520730
BR. BOLA 6MM C/4 PARES', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3151, N'Brinco de Prata com Zircônia Rosa Bebê Quadrado', N'', CAST(39.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3151/Brinco-de-Prata-com-Zircônia-Rosa-Bebê-Quadrado-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3151/Brinco-de-Prata-com-Zircônia-Rosa-Bebê-Quadrado-B.jpg', N'', N'', CAST(N'2020-03-21 19:08:20.903' AS DateTime), CAST(N'2020-03-24 00:17:16.280' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3151/Brinco-de-Prata-com-Zircônia-Rosa-Bebê-Quadrado-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(37.90 AS Decimal(15, 2)), N'0521125
BR. ZIRC. QUAD. ROSA L 6MM COM 4 PARES', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3152, N'Brinco de Prata Bola Pequena', N'', CAST(29.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3152/Brinco-de-Prata-Bola-Pequena-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3152/Brinco-de-Prata-Bola-Pequena-B.jpg', N'', N'', CAST(N'2020-03-21 19:10:22.683' AS DateTime), CAST(N'2020-03-24 00:16:43.473' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3152/Brinco-de-Prata-Bola-Pequena-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(28.90 AS Decimal(15, 2)), N'0521208
BR. BOLA 4MM C/4 PARES', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3153, N'Brinco de Prata Com Zircônia Vermelho Redondo', N'', CAST(39.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3153/Brinco-de-Prata-Com-Zircônia-Vermelha-Redonda-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3153/Brinco-de-Prata-Com-Zircônia-Vermelha-Redonda-B.jpg', N'', N'', CAST(N'2020-03-21 19:13:22.693' AS DateTime), CAST(N'2020-03-24 00:15:33.650' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3153/Brinco-de-Prata-Com-Zircônia-Vermelho-Redondo-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(46.90 AS Decimal(15, 2)), N'0521686
BR. ZIRC. RED. GARNET 7MM C/4 PARES', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3154, N'Colar de Prata Ponto de Luz Cristal Redondo 45cm', N'', CAST(79.90 AS Decimal(15, 2)), N'Prata, Cristal', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3154/Colar-de-Prata-Ponto-de-Luz-Cristal-Redondo-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3154/Colar-de-Prata-Ponto-de-Luz-Cristal-Redondo-B.jpg', N'', N'', CAST(N'2020-03-21 19:19:02.657' AS DateTime), CAST(N'2020-03-24 02:10:37.420' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3154/Colar-de-Prata-Ponto-de-Luz-Cristal-Redondo-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(20.90 AS Decimal(15, 2)), N'0540157
GARG. PTO LUZ CRISTAL GAL. V25 8MM 45CM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3155, N'Colar de Prata Gravata com Sequência de Bolas 45cm', N'', CAST(109.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3155/Colar-de-Prata-Gravata-com-Sequência-de-Bolas-45cm-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3155/Colar-de-Prata-Gravata-com-Sequência-de-Bolas-45cm-B.jpg', N'', N'', CAST(N'2020-03-21 19:20:14.633' AS DateTime), CAST(N'2020-03-24 00:14:33.340' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3155/Colar-de-Prata-Gravata-com-Sequência-de-Bolas-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(30.90 AS Decimal(15, 2)), N'1040816
GARG. GRAV. SEQ. BOLA 3MM VENEZ. 45 CM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3156, N'Brinco de Prata com Perola Achatada', N'', CAST(39.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3156/Brinco-de-Prata-com-Perola-Achatada-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3156/Brinco-de-Prata-com-Perola-Achatada-B.jpg', N'', N'', CAST(N'2020-03-21 19:21:51.480' AS DateTime), CAST(N'2020-03-24 00:13:20.927' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3156/Brinco-de-Prata-com-Perola-Achatada-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(14.90 AS Decimal(15, 2)), N'1921445
BR. PEROLA ACHATADA 7MM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3157, N'Brinco de Prata com Pedra Bolinha Azul', N'', CAST(79.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3157/Brinco-de-Prata-com-Pedra-Bolinha-Azul-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3157/Brinco-de-Prata-com-Pedra-Bolinha-Azul-B.jpg', N'', N'', CAST(N'2020-03-21 19:23:26.040' AS DateTime), CAST(N'2020-03-24 01:34:26.053' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3157/Brinco-de-Prata-com-Pedra-Bolinha-Azul-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(35.60 AS Decimal(15, 2)), N'1921497
BR. MAND. ENV. PEDRA CORES 9MM ', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3158, N'Berloque de Prata Flor Vermelha', N'', CAST(68.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3158/Berloque-de-Prata-Flor-Vermelha-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3158/Berloque-de-Prata-Flor-Vermelha-B.jpg', N'', N'', CAST(N'2020-03-21 19:24:28.007' AS DateTime), CAST(N'2020-03-25 01:28:14.237' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3158/Berloque-de-Prata-Flor-Vermelha-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(34.50 AS Decimal(15, 2)), N'1931810
PING. ORG. RED. FLORES CORES SEP. 12MM', 1)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3159, N'Colar de Prata Coração Olho Grego Madre 45cm', N'', CAST(89.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3159/Colar-de-Prata-Coração-Olho-Grego-Madre-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3159/Colar-de-Prata-Coração-Olho-Grego-Madre-B.jpg', N'', N'', CAST(N'2020-03-21 19:25:26.540' AS DateTime), CAST(N'2020-03-24 00:12:31.000' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3159/Colar-de-Prata-Coração-Olho-Grego-Madre-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(31.40 AS Decimal(15, 2)), N'1940385
GARG. OLHO GREGO COR. MADRE 45CM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3160, N'Anel de Prata Solitário com Zircônia', N'', CAST(79.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3160/Anel-de-Prata-Solitário-com-Zircônia-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3160/Anel-de-Prata-Solitário-com-Zircônia-B.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3160/Anel-de-Prata-Solitário-com-Zircônia-C.jpg', N'', CAST(N'2020-03-21 19:26:05.533' AS DateTime), CAST(N'2020-03-24 00:11:58.967' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3160/Anel-de-Prata-Solitário-com-Zircônia-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(16.40 AS Decimal(15, 2)), N'2010427
AN. SOLIT. ZIRC. RED. 4MM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3161, N'Anel de Prata Meio Dedo Coração com Zircônia', N'', CAST(49.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3161/Anel-de-Prata-Meio-Dedo-Coração-com-Zirconia-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3161/Anel-de-Prata-Meio-Dedo-Coração-com-Zirconia-B.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3161/Anel-de-Prata-Meio-Dedo-Coração-com-Zirconia-C.jpg', N'', CAST(N'2020-03-21 19:41:32.367' AS DateTime), CAST(N'2020-03-24 02:09:29.183' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3161/Anel-de-Prata-Meio-Dedo-Coração-com-Zirconia-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(19.10 AS Decimal(15, 2)), N'2010431
AN. FAL. COR. POL. ZIRC 5MM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3162, N'Anel de Prata Meio Dedo Paz e Amor', N'', CAST(39.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3162/Anel-de-Prata-Meio-Dedo-Paz-e-Amor-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3162/Anel-de-Prata-Meio-Dedo-Paz-e-Amor-B.jpg', N'', N'', CAST(N'2020-03-21 19:42:20.657' AS DateTime), CAST(N'2020-03-24 00:11:31.353' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3162/Anel-de-Prata-Meio-Dedo-Paz-e-Amor-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(11.40 AS Decimal(15, 2)), N'2010451
AN. FAL. PAZ E AMOR VAZ. 8MM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3163, N'Brinco de Prata Coruja Vazada com Zircônia Azul', N'', CAST(49.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3163/Brinco-de-Prata-Coruja-Vazada-com-Zircônia-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3163/Brinco-de-Prata-Coruja-Vazada-com-Zircônia-B.jpg', N'', N'', CAST(N'2020-03-21 19:43:07.100' AS DateTime), CAST(N'2020-03-24 00:10:54.630' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3163/Brinco-de-Prata-Coruja-Vazada-com-Zircônia-Azul-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(18.00 AS Decimal(15, 2)), N'2020012
BR. CORUJA OLHOS TURQ. VAZ. 12MM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3164, N'Colar de Prata Trio Pedras de Zircônia 45cm', N'', CAST(179.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3164/Colar-de-Prata-Trio-Pedras-de-Zircônia-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3164/Colar-de-Prata-Trio-Pedras-de-Zircônia-B.jpg', N'', N'', CAST(N'2020-03-21 19:44:03.603' AS DateTime), CAST(N'2020-03-24 00:50:29.870' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3164/Colar-de-Prata-Trio-Pedras-de-Zircônia-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(60.90 AS Decimal(15, 2)), N'2240708
GARG. TRIO ZIRC. 45CM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3165, N'Pulseira de Prata Infinito', N'', CAST(59.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(18.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3165/Pulseira-de-Prata-Infinito-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3165/Pulseira-de-Prata-Infinito-B.jpg', N'', N'', CAST(N'2020-03-21 19:44:50.817' AS DateTime), CAST(N'2020-03-24 02:16:15.600' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3165/Pulseira-de-Prata-Infinito-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(13.90 AS Decimal(15, 2)), N'2250059
PULS. INFINITO VENEZ. 18CM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3166, N'Anel Chuveirinho com Zircônia', N'', CAST(89.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3166/Anel-Chuveirinho-com-Zircônia-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3166/Anel-Chuveirinho-com-Zircônia-B.jpg', N'', N'', CAST(N'2020-03-21 19:46:02.343' AS DateTime), CAST(N'2020-03-24 00:09:20.340' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3166/Anel-Chuveirinho-com-Zircônia-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(17.90 AS Decimal(15, 2)), N'3011072
AN. CHUVEIRINHO ZIRC. 6MM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3167, N'Pulseira de Prata Filtro dos Sonhos', N'', CAST(89.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(19.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3167/Pulseira-de-Prata-Filtro-dos-Sonhos-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3167/Pulseira-de-Prata-Filtro-dos-Sonhos-B.jpg', N'', N'', CAST(N'2020-03-21 19:46:57.680' AS DateTime), CAST(N'2020-03-25 01:31:58.257' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3167/Pulseira-de-Prata-Filtro-dos-Sonhos-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(35.70 AS Decimal(15, 2)), N'3750177
PULS. FILTRO DOS SONHOS TURQ. 19CM', 10)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3168, N'Pulseira de Prata Corações Ligados', N'', CAST(59.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(18.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3168/Pulseira-de-Prata-Corações-Ligados-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3168/Pulseira-de-Prata-Corações-Ligados-B.jpg', N'', N'', CAST(N'2020-03-21 19:47:41.117' AS DateTime), CAST(N'2020-03-24 02:16:40.330' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3168/Pulseira-de-Prata-Corações-Ligados-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(14.70 AS Decimal(15, 2)), N'5250069
PULS. 2 COR. CENTRAL FAZ. VENEZ. 18CM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3169, N'Berloque Murano Marrom com Prata', N'', CAST(48.90 AS Decimal(15, 2)), N'Prata, Murano', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3169/Berloque-Murano-Marrom-com-Prata-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3169/Berloque-Murano-Marrom-com-Prata-B.jpg', N'', N'', CAST(N'2020-03-21 19:48:22.170' AS DateTime), CAST(N'2020-03-23 23:32:23.450' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3169/Berloque-Murano-Marrom-com-Prata-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(17.90 AS Decimal(15, 2)), N'6631575
PING. SEP. MURANO DIVERSOS 14MM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3170, N'Berloque Murano Dirversos Cores com Prata', N'', CAST(68.90 AS Decimal(15, 2)), N'Prata, Murano', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3170/Berloque-Murano-Azul-com-Prata-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3170/Berloque-Murano-Azul-com-Prata-B.jpg', N'', N'', CAST(N'2020-03-21 19:49:01.103' AS DateTime), CAST(N'2020-03-25 01:27:45.607' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3170/Berloque-Murano-Azul-com-Prata-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(31.90 AS Decimal(15, 2)), N'6631591
PING. SEP. MURANO CORES 15MM', 1)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3171, N'Anel Solitário de Prata Delicado com Zircônia', N'', CAST(79.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3171/Anel-Solitário-de-Prata-Delicado-com-Zircônia-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3171/Anel-Solitário-de-Prata-Delicado-com-Zircônia-B.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3171/Anel-Solitário-de-Prata-Delicado-com-Zircônia-C.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3171/Anel-Solitário-de-Prata-Delicado-com-Zircônia-D.jpg', CAST(N'2020-03-21 19:50:18.860' AS DateTime), CAST(N'2020-03-24 00:06:55.057' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3171/Anel-Solitário-de-Prata-Delicado-com-Zircônia-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(15.30 AS Decimal(15, 2)), N'7910326
AN.  SOLIT. DELICADO 4MM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3172, N'Anel de Prata Cravejado Zircônia e Pedra de Cristal', N'', CAST(89.90 AS Decimal(15, 2)), N'Prata, Zircônia, Cristal', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3172/Anel-de-Prata-Cravejado-Zircônia-e-Pedra-de-Cristal-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3172/Anel-de-Prata-Cravejado-Zircônia-e-Pedra-de-Cristal-B.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3172/Anel-de-Prata-Cravejado-Zircônia-e-Pedra-de-Cristal-C.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3172/Anel-de-Prata-Cravejado-Zircônia-e-Pedra-de-Cristal-D.jpg', CAST(N'2020-03-21 19:51:13.963' AS DateTime), CAST(N'2020-03-24 02:10:24.193' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3172/Anel-de-Prata-Cravejado-Zircônia-e-Pedra-de-Cristal-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(20.60 AS Decimal(15, 2)), N'7910353
AN. RET. CRISTAL LAT. ZIRC 7MM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3173, N'Anel de Prata Cravejado e Pedra de Zircônia', N'', CAST(89.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3173/Anel-de-Prata-Cravejado-e-Pedra-de-Zircônia-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3173/Anel-de-Prata-Cravejado-e-Pedra-de-Zircônia-B.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3173/Anel-de-Prata-Cravejado-e-Pedra-de-Zircônia-C.jpg', N'', CAST(N'2020-03-21 19:52:04.433' AS DateTime), CAST(N'2020-03-24 00:05:00.157' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3173/Anel-de-Prata-Cravejado-e-Pedra-de-Zircônia-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(27.60 AS Decimal(15, 2)), N'8310137
AN. ZIRC. BORGA LAT. 10 ZIRC 8MM ', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3174, N'Colar de Prata Coração Cravejada com Zircônia 45cm', N'', CAST(119.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3174/Colar-de-Prata-Coração-Cravejada-com-Zircônia-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3174/Colar-de-Prata-Coração-Cravejada-com-Zircônia-B.jpg', N'', N'', CAST(N'2020-03-21 19:52:29.290' AS DateTime), CAST(N'2020-03-25 01:32:47.703' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3174/Colar-de-Prata-Coração-Cravejada-com-Zircônia-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(35.90 AS Decimal(15, 2)), N'8340235
GARG. COR. ZIRC. PONTO CRISTAL 45CM', 9)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3175, N'Anel Meia Aliança de Prata com Zircônia', N'', CAST(89.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3175/Anel-Meia-Aliança-de-Prata-com-Zircônia-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3175/Anel-Meia-Aliança-de-Prata-com-Zircônia-B.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3175/Anel-Meia-Aliança-de-Prata-com-Zircônia-C.jpg', N'', CAST(N'2020-03-21 19:53:18.463' AS DateTime), CAST(N'2020-03-24 00:04:19.523' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3175/Anel-Meia-Aliança-de-Prata-com-Zircônia-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(31.10 AS Decimal(15, 2)), N'8510393
ANEL MEIA ALIANCA COM 7 ZIRC. 3MM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3176, N'Brinco de Prata Pendente Zircônia Rosa Safira', N'', CAST(59.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3176/Brinco-de-Prata-Pendente-Zircônia-Rosa-Safira-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3176/Brinco-de-Prata-Pendente-Zircônia-Rosa-Safira-B.jpg', N'', N'', CAST(N'2020-03-21 19:54:17.763' AS DateTime), CAST(N'2020-03-24 01:39:35.567' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3176/Brinco-de-Prata-Pendente-Zircônia-Rosa-Safira-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(24.60 AS Decimal(15, 2)), N'9320257
BR. ZIRC. GOTA PEND. SAF. ROSA 12MM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3177, N'Brinco de Prata com Zircônia Oval', N'', CAST(59.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3177/Brinco-de-Prata-com-Zircônia-Oval-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3177/Brinco-de-Prata-com-Zircônia-Oval-B.jpg', N'', N'', CAST(N'2020-03-21 19:54:55.543' AS DateTime), CAST(N'2020-03-24 00:00:36.257' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3177/Brinco-de-Prata-com-Zircônia-Oval-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(27.90 AS Decimal(15, 2)), N'9320286
BR. OVAL CRISTAL 8X 6MM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3178, N'Brinco de Prata com Zircônia Oval Azul Água', N'', CAST(59.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3178/Brinco-de-Prata-com-Zircônia-Oval-Azul-Água-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3178/Brinco-de-Prata-com-Zircônia-Oval-Azul-Água-B.jpg', N'', N'', CAST(N'2020-03-21 19:55:59.490' AS DateTime), CAST(N'2020-03-24 00:00:26.473' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3178/Brinco-de-Prata-com-Zircônia-Oval-Azul-Água-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(27.90 AS Decimal(15, 2)), N'9321399
BR. OVAL SKY 8X 6MM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3179, N'Brinco de Prata com Haste e Zircônia Azul Água', N'', CAST(69.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3179/Brinco-de-Prata-com-Haste-e-Zircônia-Azul-Água-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3179/Brinco-de-Prata-com-Haste-e-Zircônia-Azul-Água-B.jpg', N'', N'', CAST(N'2020-03-21 19:56:36.723' AS DateTime), CAST(N'2020-03-23 23:59:47.230' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3179/Brinco-de-Prata-com-Haste-e-Zircônia-Azul-Água-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(30.90 AS Decimal(15, 2)), N'9321578
BR. HASTE COR. SKY 18MM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3180, N'Colar de Prata Coração Verde Borda Cravejada Zircônia 45cm', N'', CAST(149.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3180/Colar-de-Prata-Coração-Verde-Borda-Cravejada-Zircônia-45cm-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3180/Colar-de-Prata-Coração-Verde-Borda-Cravejada-Zircônia-45cm-B.jpg', N'', N'', CAST(N'2020-03-21 19:57:12.117' AS DateTime), CAST(N'2020-03-25 01:32:51.413' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3180/Colar-de-Prata-Coração-Verde-Borda-Cravejada-Zircônia-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(33.90 AS Decimal(15, 2)), N'9340037
GARG. CORACAO ZIRC. VERDE 45CM', 9)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3181, N'Colar de Prata Navete Verde Água Borda Cravejada Zircônia 45cm', N'', CAST(109.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3181/Colar-de-Prata-Navete-Verde-Água-Borda-Cravejada-Zircônia-45cm-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3181/Colar-de-Prata-Navete-Verde-Água-Borda-Cravejada-Zircônia-45cm-B.jpg', N'', N'', CAST(N'2020-03-21 19:57:53.763' AS DateTime), CAST(N'2020-03-23 23:58:29.900' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3181/Colar-de-Prata-Navete-Verde-Água-Borda-Cravejada-Zircônia-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(22.90 AS Decimal(15, 2)), N'9340092
GARG. OVAL. LONDON BORDA ZIRC. 45CM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3182, N'Colar de Prata Navete Rosa Safira Borda Cravejada Zircônia 45cm', N'', CAST(109.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3182/Colar-de-Prata-Navete-Rosa-Safira-Borda-Cravejada-Zircônia-45cm-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3182/Colar-de-Prata-Navete-Rosa-Safira-Borda-Cravejada-Zircônia-45cm-B.jpg', N'', N'', CAST(N'2020-03-21 19:58:51.827' AS DateTime), CAST(N'2020-03-23 23:46:59.077' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3182/Colar-de-Prata-Navete-Rosa-Safira-Borda-Cravejada-Zircônia-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(24.90 AS Decimal(15, 2)), N'9340124
GARG. NAVETE SAF. ROSA BORDA ZIRC 45CM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3183, N'Colar de Prata Gota Rosa Safira Borda Cravejada Zircônia 45cm', N'', CAST(149.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3183/Colar-de-Prata-Gota-Rosa-Safira-Borda-Cravejada-Zircônia-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3183/Colar-de-Prata-Gota-Rosa-Safira-Borda-Cravejada-Zircônia-B.jpg', N'', N'', CAST(N'2020-03-21 19:59:24.930' AS DateTime), CAST(N'2020-03-25 01:31:09.957' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3183/Colar-de-Prata-Gota-Rosa-Safira-Borda-Cravejada-Zircônia-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(31.40 AS Decimal(15, 2)), N'9340328
GARG. GOTA SAF. ROSA BORDA ZIRC. 45CM', 10)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3184, N'Colar de Prata com Cristal Oval 45cm', N'', CAST(79.90 AS Decimal(15, 2)), N'Prata, Cristal', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3184/Colar-de-Prata-com-Cristal-Oval-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3184/Colar-de-Prata-com-Cristal-Oval-B.jpg', N'', N'', CAST(N'2020-03-21 20:00:08.890' AS DateTime), CAST(N'2020-03-24 02:10:10.673' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3184/Colar-de-Prata-com-Cristal-Oval-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(24.90 AS Decimal(15, 2)), N'9340685
GARG. OVAL CRISTAL 8X6MM 45CM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3185, N'Berloque de Prata Coração Turquesa', N'', CAST(48.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3185/Berloque-de-Prata-Coração-Turquesa-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3185/Berloque-de-Prata-Coração-Turquesa-B.jpg', N'', N'', CAST(N'2020-03-21 20:01:17.493' AS DateTime), CAST(N'2020-03-25 01:28:04.730' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3185/Berloque-de-Prata-Coração-Turquesa-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(23.80 AS Decimal(15, 2)), N'9430950
PING. COR. ALÇA LAS. RES TURQ SEP. 20MM ', 1)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3186, N'Berloque de Prata Menino Vazado com Zircônia', N'', CAST(48.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3186/Berloque-de-Prata-Menino-Vazado-com-Zircônia-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3186/Berloque-de-Prata-Menino-Vazado-com-Zircônia-B.jpg', N'', N'', CAST(N'2020-03-21 20:01:57.290' AS DateTime), CAST(N'2020-03-25 01:29:32.890' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3186/Berloque-de-Prata-Menino-Vazado-com-Zircônia-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(19.40 AS Decimal(15, 2)), N'9430976
PING. MENINO VAZ. ZIRC. SEP. AZUL 25MM', 2)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3188, N'Berloque de Prata Coração Zircônia Rosa', N'', CAST(48.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3188/Berloque-de-Prata-Coração-Zircônia-Rosa-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3188/Berloque-de-Prata-Coração-Zircônia-Rosa-B.jpg', N'', N'', CAST(N'2020-03-21 20:28:04.800' AS DateTime), CAST(N'2020-03-23 23:28:26.677' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3188/Berloque-de-Prata-Coração-Zircônia-Rosa-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(14.90 AS Decimal(15, 2)), N'9431342
PING. COR. ZIRC. ROSA SAF. SEP. POL. 7MM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3189, N'Berloque de Prata Coração Zircônia Verde Esmeralda', N'', CAST(48.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3189/Berloque-de-Prata-Coração-Zircônia-Verde-Esmeralda-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3189/Berloque-de-Prata-Coração-Zircônia-Verde-Esmeralda-B.jpg', N'', N'', CAST(N'2020-03-21 20:29:14.670' AS DateTime), CAST(N'2020-03-25 01:29:12.573' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3189/Berloque-de-Prata-Coração-Zircônia-Verde-Esmeralda-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(14.90 AS Decimal(15, 2)), N'9431349
PING. COR. ZIRC. ESMERALDA SEP. POL. 7MM', 2)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3191, N'Berloque de Prata Menina Vazada', N'', CAST(48.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3191/Berloque-de-Prata-Menina-Vazada-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3191/Berloque-de-Prata-Menina-Vazada-B.jpg', N'', N'', CAST(N'2020-03-21 20:32:32.917' AS DateTime), CAST(N'2020-03-25 01:29:23.540' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3191/Berloque-de-Prata-Menina-Vazada-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(16.90 AS Decimal(15, 2)), N'9431711
PING. MENINA VAZ. SEP. 16MM', 2)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3192, N'Berloque de Prata Infinito Vermelho', N'', CAST(48.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3192/Berloque-de-Prata-Infinito-Vermelho-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3192/Berloque-de-Prata-Infinito-Vermelho-B.jpg', N'', N'', CAST(N'2020-03-21 20:33:51.753' AS DateTime), CAST(N'2020-03-23 23:27:28.490' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3192/Berloque-de-Prata-Infinito-Vermelho-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(20.90 AS Decimal(15, 2)), N'9431750
PING. INFINITO RES. VERM. SEP. POL 23MM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3193, N'Berloque de Prata Love Cachorro Pata', N'', CAST(48.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3193/Berloque-de-Prata-Love-Cachorro-Pata-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3193/Berloque-de-Prata-Love-Cachorro-Pata-B.jpg', N'', N'', CAST(N'2020-03-21 20:36:52.920' AS DateTime), CAST(N'2020-03-23 23:26:30.150' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3193/Berloque-de-Prata-Love-Cachorro-Pata-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(23.90 AS Decimal(15, 2)), N'9431758
PING. LOVE PRATA CAO RES. LASER SEP. 23MM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3194, N'Berloque de Prata Cachorro', N'', CAST(48.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3194/Berloque-de-Prata-Cachorro-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3194/Berloque-de-Prata-Cachorro-B.jpg', N'', N'', CAST(N'2020-03-21 20:38:02.753' AS DateTime), CAST(N'2020-03-25 01:30:19.127' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3194/Berloque-de-Prata-Cachorro-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(23.70 AS Decimal(15, 2)), N'9431761
PING. CAO DALMATAS RES. SEP. POL. 20MM', 2)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3195, N'Berloque de Prata Coração com Chave', N'', CAST(48.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3195/Berloque-de-Prata-Coração-com-Chave-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3195/Berloque-de-Prata-Coração-com-Chave-B.jpg', N'', N'', CAST(N'2020-03-21 20:39:10.050' AS DateTime), CAST(N'2020-03-23 23:20:44.540' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3195/Berloque-de-Prata-Coração-com-Chave-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(29.10 AS Decimal(15, 2)), N'9431956
PING. COR CHAVE RES. VERM. SEP. 12MM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3196, N'Colar de Prata Gravata Zircônia Verde 45cm', N'', CAST(129.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3196/Colar-de-Prata-Gravata-Zircônia-Verde-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3196/Colar-de-Prata-Gravata-Zircônia-Verde-B.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3196/Colar-de-Prata-Gravata-Zircônia-Verde-C.jpg', N'', CAST(N'2020-03-21 20:39:56.573' AS DateTime), CAST(N'2020-03-23 23:18:04.447' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3196/Colar-de-Prata-Gravata-Zircônia-Verde-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(44.90 AS Decimal(15, 2)), N'9440067
GARG. GRAV. VERDE CARTIER 5MM 45CM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3197, N'Colar de Prata Gravata Zircônia Verde Água Paraiba 45cm', N'', CAST(129.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3197/Colar-de-Prata-Gravata-Zircônia-Verde-Paraiba-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3197/Colar-de-Prata-Gravata-Zircônia-Verde-Paraiba-B.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3197/Colar-de-Prata-Gravata-Zircônia-Verde-Paraiba-C.jpg', N'', CAST(N'2020-03-21 20:40:45.050' AS DateTime), CAST(N'2020-03-23 23:15:56.420' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3197/Colar-de-Prata-Gravata-Zircônia-Verde-Água-Paraiba-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(44.90 AS Decimal(15, 2)), N'9440068
GARG. GRAV. PARAIBA CARTIER 5MM 45CM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3198, N'Colar de Prata Ponto de Luz Coração Zircônia 45cm', N'', CAST(79.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3198/Colar-de-Prata-Ponto-de-Luz-Coração-Zircônia-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3198/Colar-de-Prata-Ponto-de-Luz-Coração-Zircônia-B.jpg', N'', N'', CAST(N'2020-03-21 20:41:52.243' AS DateTime), CAST(N'2020-03-23 23:51:25.970' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3198/Colar-de-Prata-Ponto-de-Luz-Coração-Zircônia-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(17.10 AS Decimal(15, 2)), N'9440152
GARG. PTO LUZ COR. VENEZ 5MM 45CM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3199, N'Colar de Prata Ponto de Luz Gota Zircônia 45cm', N'', CAST(79.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3199/Colar-de-Prata-Ponto-de-Luz-Gota-Zircônia-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3199/Colar-de-Prata-Ponto-de-Luz-Gota-Zircônia-B.jpg', N'', N'', CAST(N'2020-03-21 20:42:40.673' AS DateTime), CAST(N'2020-03-23 23:48:02.737' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3199/Colar-de-Prata-Ponto-de-Luz-Gota-Zircônia-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(17.90 AS Decimal(15, 2)), N'9440153
GARG. PTO LUZ GOTA VENEZ. 8MM 45CM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3200, N'Colar de Prata Gravata Coração e Gota de Zircônia 45cm', N'', CAST(109.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3200/Colar-de-Prata-Gravata-Coração-e-Gota-Zircônia-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3200/Colar-de-Prata-Gravata-Coração-e-Gota-Zircônia-B.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3200/Colar-de-Prata-Gravata-Coração-e-Gota-Zircônia-C.jpg', N'', CAST(N'2020-03-21 20:43:33.337' AS DateTime), CAST(N'2020-03-23 23:12:51.320' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3200/Colar-de-Prata-Gravata-Coração-e-Gota-de-Zircônia-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(36.90 AS Decimal(15, 2)), N'9440259
GARG. GRAV. COR/GOTA ZIRC. VEN. 45CM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3201, N'Colar de Prata Gravata Coração e Gota Azul 45cm', N'', CAST(119.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3201/Colar-de-Prata-Gravata-Coração-e-Gota-Azul-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3201/Colar-de-Prata-Gravata-Coração-e-Gota-Azul-B.jpg', N'', N'', CAST(N'2020-03-21 20:44:22.830' AS DateTime), CAST(N'2020-03-23 23:12:20.217' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3201/Colar-de-Prata-Gravata-Coração-e-Gota-Azul-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(38.20 AS Decimal(15, 2)), N'9440265
GARG. GRAV. COR/GOTA TOP SWISS. VEN. 45CM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3202, N'Colar de Prata Gravata Coração e Gota Verde Paraiba 45cm', N'', CAST(119.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3202/Colar-de-Prata-Gravata-Coração-e-Gota-Verde-Paraiba-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3202/Colar-de-Prata-Gravata-Coração-e-Gota-Verde-Paraiba-B.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3202/Colar-de-Prata-Gravata-Coração-e-Gota-Verde-Paraiba-C.jpg', N'', CAST(N'2020-03-21 20:46:20.417' AS DateTime), CAST(N'2020-03-23 23:12:03.997' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3202/Colar-de-Prata-Gravata-Coração-e-Gota-Verde-Paraiba-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(38.20 AS Decimal(15, 2)), N'9440267
GARG. GRAV. COR/GOTA PARAIBA VEN. 45CM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3203, N'Colar de Prata Gravata Gota Verde Esmeralda 45cm', N'', CAST(109.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3203/Colar-de-Prata-Gravata-Gota-Verde-Esmeralda-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3203/Colar-de-Prata-Gravata-Gota-Verde-Esmeralda-B.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3203/Colar-de-Prata-Gravata-Gota-Verde-Esmeralda-C.jpg', N'', CAST(N'2020-03-21 20:47:18.553' AS DateTime), CAST(N'2020-03-23 23:11:47.467' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3203/Colar-de-Prata-Gravata-Gota-Verde-Esmeralda-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(34.70 AS Decimal(15, 2)), N'9440270
GARG. GRAV. COR/GOTA VERDE V30 45CM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3204, N'Colar de Prata Gravata Gota Verde Água Paraiba 45cm', N'', CAST(109.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3204/Colar-de-Prata-Gravata-Gota-Verde-Água-Paraiba-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3204/Colar-de-Prata-Gravata-Gota-Verde-Água-Paraiba-B.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3204/Colar-de-Prata-Gravata-Gota-Verde-Água-Paraiba-C.jpg', N'', CAST(N'2020-03-21 20:48:12.530' AS DateTime), CAST(N'2020-03-23 23:11:15.200' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3204/Colar-de-Prata-Gravata-Gota-Verde-Água-Paraiba-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(34.70 AS Decimal(15, 2)), N'9440275
GARG. GRAV. COR/GOTA PARAIBA PORT. 45CM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3205, N'Colar Gravata de Coração de Prata 65cm', N'', CAST(89.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(65.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3205/Colar-Gravata-de-Coração-de-Prata-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3205/Colar-Gravata-de-Coração-de-Prata-B.jpg', N'', N'', CAST(N'2020-03-21 20:49:28.597' AS DateTime), CAST(N'2020-03-25 01:32:43.687' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3205/Colar-Gravata-de-Coração-de-Prata-65cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(29.90 AS Decimal(15, 2)), N'9440446
GARG. GRAV. COR/GOTA COR VAZ. 65CM', 9)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3206, N'Gargantilha Choker de Prata com Pedras em Coração Vermelho', N'', CAST(129.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(40.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3206/Gargantilha-Choker-de-Prata-com-Pedras-em-Coração-Vermelho-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3206/Gargantilha-Choker-de-Prata-com-Pedras-em-Coração-Vermelho-B.jpg', N'', N'', CAST(N'2020-03-21 20:50:27.673' AS DateTime), CAST(N'2020-03-23 23:16:08.077' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3206/Gargantilha-Choker-de-Prata-com-Pedras-em-Coração-Vermelho-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(45.80 AS Decimal(15, 2)), N'9440810
GARG. CARTIER SEQ. COR. PEND. VERM. 35CM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3207, N'Pulseira de Prata Com Zircônia Azul', N'', CAST(79.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(19.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3207/Pulseira-de-Prata-Com-Zircônia-Azul-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3207/Pulseira-de-Prata-Com-Zircônia-Azul-B.jpg', N'', N'', CAST(N'2020-03-21 20:51:33.350' AS DateTime), CAST(N'2020-03-24 02:16:56.823' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3207/Pulseira-de-Prata-Com-Zircônia-Azul-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(27.50 AS Decimal(15, 2)), N'9450088
PULS ZIRC. AZUL ELO PORT. 5MM 19CM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3208, N'Pulseira de Prata Com Zircônia Rosa', N'', CAST(79.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(18.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3208/Pulseira-de-Prata-Com-Zircônia-Rosa-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3208/Pulseira-de-Prata-Com-Zircônia-Rosa-B.jpg', N'', N'', CAST(N'2020-03-21 20:52:40.243' AS DateTime), CAST(N'2020-03-23 23:08:45.983' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3208/Pulseira-de-Prata-Com-Zircônia-Rosa-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(25.90 AS Decimal(15, 2)), N'9450091
PULS. ZIRC. ROSA ELO PORT. 5MM 18CM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3209, N'Pulseira de Prata Com Zircônia Ametista', N'', CAST(79.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(18.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3209/Pulseira-de-Prata-Com-Zircônia-Ametista-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3209/Pulseira-de-Prata-Com-Zircônia-Ametista-B.jpg', N'', N'', CAST(N'2020-03-21 20:53:52.143' AS DateTime), CAST(N'2020-03-24 02:16:06.243' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3209/Pulseira-de-Prata-Com-Zircônia-Ametista-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(27.50 AS Decimal(15, 2)), N'9450092
PULS. ZIRC. AMETISTA ELO PORT. 5MM 18CM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3210, N'Pulseira de Prata Com Gotas de Zircônia Verde Esmeralda', N'', CAST(89.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(18.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3210/Pulseira-de-Prata-Com-Gotas-de-Zircônia-Verde-Esmeralda-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3210/Pulseira-de-Prata-Com-Gotas-de-Zircônia-Verde-Esmeralda-B.jpg', N'', N'', CAST(N'2020-03-21 20:55:36.960' AS DateTime), CAST(N'2020-03-24 02:15:41.847' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3210/Pulseira-de-Prata-Com-Gotas-de-Zircônia-Verde-Esmeralda-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(31.90 AS Decimal(15, 2)), N'9450241
PULS. SEQ. ZIRC. RED. ESMERALDA 17CM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3211, N'Pulseira de Prata Com Gotas de Zircônia Verde Água Paraiba', N'', CAST(89.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(18.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3211/Pulseira-de-Prata-Com-Gotas-de-Zircônia-Verde-Água-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3211/Pulseira-de-Prata-Com-Gotas-de-Zircônia-Verde-Água-B.jpg', N'', N'', CAST(N'2020-03-21 20:56:32.670' AS DateTime), CAST(N'2020-03-24 02:15:29.623' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3211/Pulseira-de-Prata-Com-Gotas-de-Zircônia-Verde-Água-Paraiba-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(35.90 AS Decimal(15, 2)), N'9450242
PULS. SEQ. ZIRC. RED. PARAIBA 17CM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3212, N'Pulseira de Prata Coração Cravejado Vermelho', N'', CAST(89.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(18.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3212/Pulseira-de-Prata-Coração-Cravejado-Vermelho-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3212/Pulseira-de-Prata-Coração-Cravejado-Vermelho-B.jpg', N'', N'', CAST(N'2020-03-21 20:57:37.997' AS DateTime), CAST(N'2020-03-24 02:15:18.867' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3212/Pulseira-de-Prata-Coração-Cravejado-Vermelho-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(35.90 AS Decimal(15, 2)), N'9450262
PULS. COR. CRAV. VERM. VAZ. 10MM 17CM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3213, N'Corrente Veneziana de Prata 40cm', N'', CAST(39.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(40.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3213/Corrente-Veneziana-de-Prata-40cm-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3213/Corrente-Veneziana-de-Prata-40cm-B.jpg', N'', N'', CAST(N'2020-03-21 21:15:40.897' AS DateTime), CAST(N'2020-03-23 23:07:11.497' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3213/Corrente-Veneziana-de-Prata-40cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(15.00 AS Decimal(15, 2)), N'Correntaria lote 5
1770005', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3214, N'Corrente Veneziana de Prata 45cm', N'', CAST(44.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3214/Corrente-Veneziana-de-Prata-45cm-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3214/Corrente-Veneziana-de-Prata-45cm-B.jpg', N'', N'', CAST(N'2020-03-21 21:17:00.913' AS DateTime), CAST(N'2020-03-23 23:06:13.637' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3214/Corrente-Veneziana-de-Prata-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(17.00 AS Decimal(15, 2)), N'1770005
Corrente Veneziana de Prata 45cm', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3215, N'Corrente Veneziana de Prata 60cm', N'', CAST(64.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(60.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3215/Corrente-Veneziana-de-Prata-60cm-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3215/Corrente-Veneziana-de-Prata-60cm-B.jpg', N'', N'', CAST(N'2020-03-21 21:17:45.780' AS DateTime), CAST(N'2020-03-23 23:05:28.333' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3215/Corrente-Veneziana-de-Prata-60cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(25.00 AS Decimal(15, 2)), N'1770005
Corrente Veneziana de Prata 60cm', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3216, N'Colar de Prata Gota Árvore da Vida Rosa 45cm', N'', CAST(129.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3216/Colar-de-Prata-Gota-Árvore-da-Vida-Rosa-45cm-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3216/Colar-de-Prata-Gota-Árvore-da-Vida-Rosa-45cm-B.jpg', N'', N'', CAST(N'2020-03-21 21:22:00.933' AS DateTime), CAST(N'2020-03-25 01:30:45.770' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3216/Colar-de-Prata-Gota-Árvore-da-Vida-Rosa-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(45.90 AS Decimal(15, 2)), N'1770005
Corrente Veneziana de Prata 45cm
1931975
PING. ORG. GOTA ARV. VIDA CORES 18MM', 10)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3217, N'Colar de Prata Coração Árvore da Vida Azul 45cm', N'', CAST(129.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3217/Colar-de-Prata-Coração-Árvore-da-Vida-Azul-45cm-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3217/Colar-de-Prata-Coração-Árvore-da-Vida-Azul-45cm-B.jpg', N'', N'', CAST(N'2020-03-21 21:24:14.393' AS DateTime), CAST(N'2020-03-23 23:16:56.780' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3217/Colar-de-Prata-Coração-Árvore-da-Vida-Azul-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(45.90 AS Decimal(15, 2)), N'1770005
Corrente Veneziana de Prata 45cm
1931976
PING. ORG. COR. ARV. VIDA CORES 15MM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3218, N'Colar de Prata Olho Grego Madre 45cm', N'', CAST(89.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3218/Colar-de-Prata-Olho-Grego-Madre-45cm-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3218/Colar-de-Prata-Olho-Grego-Madre-45cm-B.jpg', N'', N'', CAST(N'2020-03-21 21:26:47.493' AS DateTime), CAST(N'2020-03-23 23:02:56.597' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3218/Colar-de-Prata-Olho-Grego-Madre-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(31.90 AS Decimal(15, 2)), N'1770005
Corrente Veneziana de Prata 45cm
1931534
PING. OLHO GREGO MADRE 8MM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3219, N'Colar de Prata Ponto de Luz Quadrado 45cm', N'', CAST(79.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3219/Colar-de-Prata-Ponto-de-Luz-Quadrado-45cm-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3219/Colar-de-Prata-Ponto-de-Luz-Quadrado-45cm-B.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3219/Colar-de-Prata-Ponto-de-Luz-Quadrado-45cm-C.jpg', N'', CAST(N'2020-03-21 21:34:39.953' AS DateTime), CAST(N'2020-03-23 23:51:16.293' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3219/Colar-de-Prata-Ponto-de-Luz-Quadrado-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(22.97 AS Decimal(15, 2)), N'1770005
Corrente Veneziana de Prata 45cm
0531162
PING. ZIRC. QUAD. BRANCA 5MM', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3220, N'Colar de Prata Ponto de Luz Redondo 45cm', N'', CAST(79.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3220/Colar-de-Prata-Ponto-de-Luz-Redondo-45cm-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3220/Colar-de-Prata-Ponto-de-Luz-Redondo-45cm-B.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3220/Colar-de-Prata-Ponto-de-Luz-Redondo-45cm-C.jpg', N'', CAST(N'2020-03-21 21:38:07.123' AS DateTime), CAST(N'2020-03-23 23:51:21.153' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3220/Colar-de-Prata-Ponto-de-Luz-Redondo-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(24.95 AS Decimal(15, 2)), N'1770005
Corrente Veneziana de Prata 45cm
0530136
PING. PTO LUZ 8MM ', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3221, N'Colar de Prata Ponto de Luz Gota de Zircônia 45cm', N'', CAST(79.90 AS Decimal(15, 2)), N'Prata, Zircônia', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3221/Colar-de-Prata-Ponto-de-Luz-Gota-de-Zircônia-45cm-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3221/Colar-de-Prata-Ponto-de-Luz-Gota-de-Zircônia-45cm-B.jpg', N'', N'', CAST(N'2020-03-21 21:40:22.417' AS DateTime), CAST(N'2020-03-23 23:49:40.120' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3221/Colar-de-Prata-Ponto-de-Luz-Gota-de-Zircônia-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(22.72 AS Decimal(15, 2)), N'1770005
Corrente Veneziana de Prata 45cm
PING. GOTA ZIRC. BRANCA 7MM
', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3222, N'Colar de Prata Coração Vazado 45cm', N'', CAST(74.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3222/Colar-de-Prata-Coração-Vazado-45cm-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3222/Colar-de-Prata-Coração-Vazado-45cm-B.jpg', N'', N'', CAST(N'2020-03-21 21:47:39.533' AS DateTime), CAST(N'2020-03-24 02:12:53.937' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3222/Colar-de-Prata-Coração-Vazado-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(26.25 AS Decimal(15, 2)), N'1770005
Corrente Veneziana de Prata 45cm
PING. COR. VAZ. POL. FIO QUAD. 14MM
', 0)
INSERT [dbo].[Produto] ([CodProduto], [Nome], [Descricao], [Valor], [MateriaPrima], [Altura], [Largura], [Comprimento], [Espessura], [DataDesabilitado], [UrlImgA], [UrlImgB], [UrlImgC], [UrlImgD], [DataCadastro], [DataAtualizado], [UrlImgASmall], [UrlImgBSmall], [Diametro], [Peso], [CodTipoEmbalagem], [FreteGratis], [ProdutoEsgotado], [QtdDisponiveis], [OcultarProduto], [ValorAnterior], [ValorAtacado], [ObsBackOffice], [Relevancia]) VALUES (3225, N'Colar de Prata Hamsa Olho Grego 45cm', N'', CAST(84.90 AS Decimal(15, 2)), N'Prata', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(45.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), NULL, N'https://www.bomagendador.com.br//ProdutosEcommerce/3225/Colar-de-Prata-Hamsa-Olho-Grego-45cm-A.jpg', N'https://www.bomagendador.com.br//ProdutosEcommerce/3225/Colar-de-Prata-Hamsa-Olho-Grego-45cm-B.jpg', N'', N'', CAST(N'2020-03-22 15:49:20.417' AS DateTime), CAST(N'2020-03-25 00:42:08.953' AS DateTime), N'https://www.bomagendador.com.br//ProdutosEcommerce/3225/Colar-de-Prata-Hamsa-Olho-Grego-45cm-AS.jpg', N'', CAST(0.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), N'A', 0, 0, NULL, 0, CAST(0.00 AS Decimal(15, 2)), CAST(33.90 AS Decimal(15, 2)), N'1770005
Corrente Veneziana de Prata 45cm
9431616
PING. HAMSA RES. BRANCO 13MM', 0)
SET IDENTITY_INSERT [dbo].[Produto] OFF
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (23, 3171, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (34, 3171, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (32, 3169, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (26, 3168, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (23, 3166, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (34, 3166, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (26, 3165, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3164, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (36, 3164, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (35, 3163, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (37, 3163, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (23, 3162, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (23, 3161, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (34, 3161, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (23, 3160, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (34, 3160, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3159, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (32, 3158, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (35, 3157, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (37, 3157, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (35, 3156, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (37, 3156, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3155, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3154, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (36, 3154, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (35, 3153, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (37, 3153, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (35, 3152, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (35, 3151, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (37, 3151, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (35, 3150, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (35, 3149, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (37, 3149, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (35, 3148, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (37, 3148, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (35, 3147, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (37, 3147, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (35, 3146, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (37, 3146, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (32, 3145, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (32, 3143, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (32, 3142, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (32, 3141, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (32, 3137, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (26, 3137, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (26, 3138, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (23, 3139, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (34, 3139, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (23, 3140, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (34, 3140, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (32, 3170, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (33, 3216, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (33, 3205, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (33, 3201, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (33, 3194, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (33, 3183, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (33, 3189, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (33, 3174, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (33, 3180, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (33, 3167, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (26, 3167, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3225, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3222, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3221, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (36, 3221, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3220, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (36, 3220, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3219, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (36, 3219, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3218, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3217, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3216, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (39, 3215, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (39, 3214, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3214, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3215, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3213, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (39, 3213, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (26, 3212, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (38, 3212, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (26, 3211, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (38, 3211, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (26, 3210, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (38, 3210, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (26, 3209, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (38, 3209, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (26, 3208, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (38, 3208, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (26, 3207, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (38, 3207, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3206, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3205, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3204, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (36, 3204, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (36, 3206, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3203, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (36, 3203, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3202, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (36, 3202, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3201, 1)
GO
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (36, 3201, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3200, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (36, 3200, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3199, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (36, 3199, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (36, 3198, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3198, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3197, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (36, 3197, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3196, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (36, 3196, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (32, 3195, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (32, 3194, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (32, 3193, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (32, 3192, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (32, 3191, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (32, 3189, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (32, 3188, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (32, 3186, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (32, 3185, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3184, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (36, 3184, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3183, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (36, 3183, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3182, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (36, 3182, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3181, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (36, 3181, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3180, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (36, 3180, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (35, 3179, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (37, 3179, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (35, 3178, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (37, 3178, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (35, 3177, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (37, 3177, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (35, 3176, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (37, 3176, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (23, 3175, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (34, 3175, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (24, 3174, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (36, 3174, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (23, 3173, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (34, 3173, 0)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (23, 3172, 1)
INSERT [dbo].[ProdutoCategoria] ([CodCategoria], [CodProduto], [CategoriaPrincipal]) VALUES (34, 3172, 0)
INSERT [dbo].[StatusPedido] ([CodStatusPedido], [Nome]) VALUES (1, N'Aguardando Forma de Pagamento')
INSERT [dbo].[StatusPedido] ([CodStatusPedido], [Nome]) VALUES (2, N'Pagamento Criado')
INSERT [dbo].[StatusPedido] ([CodStatusPedido], [Nome]) VALUES (3, N'Aguardando Pagamento')
INSERT [dbo].[StatusPedido] ([CodStatusPedido], [Nome]) VALUES (4, N'Pagamento em Análise')
INSERT [dbo].[StatusPedido] ([CodStatusPedido], [Nome]) VALUES (5, N'Pagamento Pre-autorizado')
INSERT [dbo].[StatusPedido] ([CodStatusPedido], [Nome]) VALUES (6, N'Pagamento Autorizado')
INSERT [dbo].[StatusPedido] ([CodStatusPedido], [Nome]) VALUES (7, N'Pagamento Cancelado')
INSERT [dbo].[StatusPedido] ([CodStatusPedido], [Nome]) VALUES (8, N'Pagamento Reembolsado')
INSERT [dbo].[StatusPedido] ([CodStatusPedido], [Nome]) VALUES (9, N'Pagamento Estornado')
INSERT [dbo].[StatusPedido] ([CodStatusPedido], [Nome]) VALUES (10, N'Pagamento Concluído')
INSERT [dbo].[StatusPedido] ([CodStatusPedido], [Nome]) VALUES (11, N'Aguardando Aprovação')
INSERT [dbo].[StatusPedido] ([CodStatusPedido], [Nome]) VALUES (12, N'Pedido Cancelado')
INSERT [dbo].[StatusPedido] ([CodStatusPedido], [Nome]) VALUES (13, N'Preparando Pedido')
INSERT [dbo].[StatusPedido] ([CodStatusPedido], [Nome]) VALUES (14, N'Encaminhado para Postagem')
INSERT [dbo].[StatusPedido] ([CodStatusPedido], [Nome]) VALUES (15, N'Pedido foi postado no Correios')
INSERT [dbo].[StatusPedido] ([CodStatusPedido], [Nome]) VALUES (16, N'Pedido enviado ao Destinatário')
INSERT [dbo].[StatusPedido] ([CodStatusPedido], [Nome]) VALUES (17, N'Pedido à Caminho')
INSERT [dbo].[StatusPedido] ([CodStatusPedido], [Nome]) VALUES (18, N'Pedido foi Entregue')
INSERT [dbo].[StatusPedido] ([CodStatusPedido], [Nome]) VALUES (19, N'Pedido não Entregue')
INSERT [dbo].[StatusPedido] ([CodStatusPedido], [Nome]) VALUES (20, N'Entrega Cancelada')
INSERT [dbo].[StatusPedido] ([CodStatusPedido], [Nome]) VALUES (21, N'Envio Liberado')
INSERT [dbo].[TipoEmbalagem] ([CodTipoEmbalagem], [Altura], [Largura], [Comprimento], [Diametro], [Peso]) VALUES (N'A', CAST(2.00 AS Decimal(15, 2)), CAST(12.00 AS Decimal(15, 2)), CAST(17.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(0.30 AS Decimal(15, 2)))
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([CodUsuario], [Email], [Senha], [CodPessoa], [DataExclusao], [DataCadastro], [IdWirecard]) VALUES (65, N'nilsoncarlosdacruz@outlook.com', N'j6eQZrCNSRp7Ntmsk3duUISqVk5x2in0Skkl0iyj30hz6kXVW+cf1Ne8tLZX03yFdliCFpQ14+bJ6GJtaWIJ8GnAGMYwVdjFlTVQsAans9C7GUcJ79xCtkb4Yajiyc80', 65, NULL, CAST(N'2020-03-24 07:59:46.303' AS DateTime), N'CUS-DBKMU64W7MHI')
INSERT [dbo].[Usuario] ([CodUsuario], [Email], [Senha], [CodPessoa], [DataExclusao], [DataCadastro], [IdWirecard]) VALUES (66, N'leticiateixeira0122@gmail.com', N'0PZCmns4CBN7Vw5s1271kJn6N3bYT21nlexRYwyZpexltwzv7zwALWtIITtuK0e5wFQt7+pjDOziPRXRpvDKKy3G6pfupiR/T9HAnlkNAmxtclpK2JbKsB4R1FNs+flI', 66, NULL, CAST(N'2020-03-24 12:20:04.870' AS DateTime), N'CUS-FVUSR6RKSF1E')
INSERT [dbo].[Usuario] ([CodUsuario], [Email], [Senha], [CodPessoa], [DataExclusao], [DataCadastro], [IdWirecard]) VALUES (67, N'ericka_istetili@hotmail.com', N'mfsu4qRy4qv/K1WJUOpYkRBsYlVJIOvsE/0tEemlOx5Bf67gVgNfrI+jA4TXkptvpcMAA4LVVCAV/hOIUZwE/Q9CzDGl9mtxco/tvv9dMZ5/dbPOuceOXGQwmjCA54Ro', 67, NULL, CAST(N'2020-03-24 15:28:26.160' AS DateTime), N'CUS-6W718GC6TE8S')
INSERT [dbo].[Usuario] ([CodUsuario], [Email], [Senha], [CodPessoa], [DataExclusao], [DataCadastro], [IdWirecard]) VALUES (68, N'saulodacruz1999@hotmail.com', N'77j+f0DBFwizAiO1uwvL4a/joOzx/a6A/9JeVYHyf0y2mQ+SZXGCiD1/9laPdqWFltbT75QDjXI/dlN8cvynKGDjxJlnERq8Sg3yzwAGAz0Fm00f/GQdwFmdYXAHQLGp', 68, NULL, CAST(N'2020-03-24 18:38:42.997' AS DateTime), N'CUS-87HGGZDUYG86')
SET IDENTITY_INSERT [dbo].[Usuario] OFF
INSERT [dbo].[UsuarioPermissao] ([CodUsuario], [CodPermissao]) VALUES (66, 1)
INSERT [dbo].[UsuarioPermissao] ([CodUsuario], [CodPermissao]) VALUES (68, 1)
INSERT [dbo].[UsuarioPermissao] ([CodUsuario], [CodPermissao]) VALUES (67, 1)
INSERT [dbo].[UsuarioPermissao] ([CodUsuario], [CodPermissao]) VALUES (65, 1)
INSERT [saulodac_admin].[EmailCodigo] ([Email], [Codigo]) VALUES (N'sa@sa.com', N'1221')
INSERT [saulodac_admin].[EmailCodigo] ([Email], [Codigo]) VALUES (N'sasa@sa.com', N'2985')
INSERT [saulodac_admin].[EmailCodigo] ([Email], [Codigo]) VALUES (N'spinellibisneto@hotmail.com', N'9032')
INSERT [saulodac_admin].[EmailCodigo] ([Email], [Codigo]) VALUES (N'wwww@gmail.com', N'2630')
INSERT [saulodac_admin].[EmailCodigo] ([Email], [Codigo]) VALUES (N'saulokocruz@gmail.com', N'2101')
INSERT [saulodac_admin].[EmailCodigo] ([Email], [Codigo]) VALUES (N'testete@gmail.com', N'4998')
INSERT [saulodac_admin].[EmailCodigo] ([Email], [Codigo]) VALUES (N'saulodacruz1999@hotmail.coma', N'4063')
ALTER TABLE [dbo].[Avaliacao]  WITH CHECK ADD FOREIGN KEY([CodProduto])
REFERENCES [dbo].[Produto] ([CodProduto])
GO
ALTER TABLE [dbo].[Avaliacao]  WITH CHECK ADD FOREIGN KEY([CodUsuario])
REFERENCES [dbo].[Usuario] ([CodUsuario])
GO
ALTER TABLE [dbo].[Estorno]  WITH CHECK ADD FOREIGN KEY([CodPedido])
REFERENCES [dbo].[Pedido] ([CodPedido])
GO
ALTER TABLE [dbo].[ImagemProduto]  WITH CHECK ADD FOREIGN KEY([CodProduto])
REFERENCES [dbo].[Produto] ([CodProduto])
GO
ALTER TABLE [dbo].[ItemCarrinho]  WITH NOCHECK ADD FOREIGN KEY([CodProduto])
REFERENCES [dbo].[Produto] ([CodProduto])
GO
ALTER TABLE [dbo].[ItemCarrinho]  WITH NOCHECK ADD FOREIGN KEY([CodUsuario])
REFERENCES [dbo].[Usuario] ([CodUsuario])
GO
ALTER TABLE [dbo].[ItemDesejo]  WITH NOCHECK ADD FOREIGN KEY([CodProduto])
REFERENCES [dbo].[Produto] ([CodProduto])
GO
ALTER TABLE [dbo].[ItemDesejo]  WITH NOCHECK ADD FOREIGN KEY([CodUsuario])
REFERENCES [dbo].[Usuario] ([CodUsuario])
GO
ALTER TABLE [dbo].[ItemPedido]  WITH CHECK ADD FOREIGN KEY([CodPedido])
REFERENCES [dbo].[Pedido] ([CodPedido])
GO
ALTER TABLE [dbo].[ItemPedido]  WITH CHECK ADD FOREIGN KEY([CodProduto])
REFERENCES [dbo].[Produto] ([CodProduto])
GO
ALTER TABLE [dbo].[LogStatusPedido]  WITH CHECK ADD FOREIGN KEY([CodPedido])
REFERENCES [dbo].[Pedido] ([CodPedido])
GO
ALTER TABLE [dbo].[LogStatusPedido]  WITH CHECK ADD FOREIGN KEY([CodStatusPedido])
REFERENCES [dbo].[StatusPedido] ([CodStatusPedido])
GO
ALTER TABLE [dbo].[Pagamento]  WITH CHECK ADD FOREIGN KEY([CodPedido])
REFERENCES [dbo].[Pedido] ([CodPedido])
GO
ALTER TABLE [dbo].[Pedido]  WITH CHECK ADD FOREIGN KEY([CodCupom])
REFERENCES [dbo].[Cupom] ([CodCupom])
GO
ALTER TABLE [dbo].[Pedido]  WITH CHECK ADD FOREIGN KEY([CodUsuario])
REFERENCES [dbo].[Usuario] ([CodUsuario])
GO
ALTER TABLE [dbo].[Pessoa]  WITH CHECK ADD FOREIGN KEY([CodEndereco])
REFERENCES [dbo].[Endereco] ([CodEndereco])
GO
ALTER TABLE [dbo].[ProdutoCategoria]  WITH CHECK ADD FOREIGN KEY([CodCategoria])
REFERENCES [dbo].[Categoria] ([CodCategoria])
GO
ALTER TABLE [dbo].[ProdutoCategoria]  WITH CHECK ADD FOREIGN KEY([CodProduto])
REFERENCES [dbo].[Produto] ([CodProduto])
GO
ALTER TABLE [dbo].[ProdutoObservacoes]  WITH CHECK ADD FOREIGN KEY([CodProduto])
REFERENCES [dbo].[Produto] ([CodProduto])
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD FOREIGN KEY([CodPessoa])
REFERENCES [dbo].[Pessoa] ([CodPessoa])
GO
ALTER TABLE [dbo].[UsuarioPermissao]  WITH CHECK ADD FOREIGN KEY([CodPermissao])
REFERENCES [dbo].[Permissao] ([CodPermissao])
GO
ALTER TABLE [dbo].[UsuarioPermissao]  WITH CHECK ADD FOREIGN KEY([CodUsuario])
REFERENCES [dbo].[Usuario] ([CodUsuario])
GO
/****** Object:  StoredProcedure [dbo].[pCadastrarUsuario]    Script Date: 25/03/2020 01:44:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pCadastrarUsuario]    
 @Nome varchar(50),    
 @TipoPessoa char,    
 @CPF varchar(14) = NULL,    
 @DataNascimento date = NULL,    
 @Telefone varchar(16) = NULL,    
 @Celular varchar(16) = NULL,    
     
 @Email varchar(100),    
 @Senha varchar(300),    
    
 @Logradouro varchar(100) = NULL,    
 @CEP varchar(10) = NULL,    
 @Cidade varchar(50) = NULL,    
 @Bairro varchar(50) = NULL,    
 @UF varchar(10) = NULL,    
 @Numero varchar(10) = NULL,    
 @Complemento varchar(100) = NULL,    
 @Retorno varchar(250) output    
as    
begin     
 if(RTRIM(LTRIM(@CPF)) = '')    
 begin     
  set @CPF = null    
 end    

 if(LTRIM(RTRIM(@Nome)) = '' or LTRIM(RTRIM(@Email)) = '' or LTRIM(RTRIM(@Senha)) = '' 
	or @Nome is null or @Email is null or @Senha is null)
  begin     
   set @Retorno = 'Por favor, reveja os campos novamente.'    
   return    
  end    
 else if (EXISTS(SELECT Email FROM Usuario WHERE Email = lower(LTRIM(RTRIM(@EMAIL))) and DataExclusao is null))
  begin     
   set @Retorno = 'Este e-mail já existe em nosso banco !'    
   return    
  end    
 else    
  begin     
   set @Email = lower(@Email)    
   begin try    
    begin tran    
     insert into Endereco (Logradouro, CEP, Bairro, UF, Cidade, Numero, Complemento)     
       values(@Logradouro, @CEP, @Bairro, @UF, @Cidade, @Numero, @Complemento)    
     declare @CodEndereco int     
     set @CodEndereco = SCOPE_IDENTITY()
     insert into Pessoa (Nome, CPF, DataNascimento, Telefone, Celular, CodEndereco)     
       values(@Nome, @CPF, @DataNascimento, @Telefone, @Celular, @CodEndereco)    
     declare  @CodPessoa int    
     set @CodPessoa = SCOPE_IDENTITY()
               
     insert into Usuario (Email, Senha, CodPessoa, DataCadastro) values(@Email, @Senha, @CodPessoa, getdate())
     commit    
     set @Retorno = 'Cadastro realizado com sucesso !'    
     return     
   end try    
   begin catch    
    rollback    
    set @Retorno = ERROR_MESSAGE()    
    return     
   end catch    
  end    
end 

GO
/****** Object:  StoredProcedure [dbo].[pCadastrarUsuarioERetornar]    Script Date: 25/03/2020 01:44:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pCadastrarUsuarioERetornar]
 @Nome varchar(50),    
 @TipoPessoa char,    
 @CPF varchar(14) = NULL,    
 @DataNascimento date = NULL,    
 @Telefone varchar(16) = NULL,    
 @Celular varchar(16) = NULL,    
     
 @Email varchar(100),    
 @Senha varchar(300),    
    
 @Logradouro varchar(100) = NULL,    
 @CEP varchar(10) = NULL,    
 @Cidade varchar(50) = NULL,    
 @Bairro varchar(50) = NULL,    
 @UF varchar(10) = NULL,    
 @Numero varchar(10) = NULL,    
 @Complemento varchar(100) = NULL,    
 @Retorno varchar(250) output    
as    
begin     
 if(RTRIM(LTRIM(@CPF)) = '')    
 begin     
  set @CPF = null    
 end    
     
 if(LTRIM(RTRIM(@Nome)) = '' or LTRIM(RTRIM(@Email)) = '' or LTRIM(RTRIM(@Senha)) = '' 
	or @Nome is null or @Email is null or @Senha is null)
  begin     
   set @Retorno = 'Por favor, reveja os campos novamente.'    
   return    
  end    
 else if (EXISTS(SELECT Email FROM Usuario WHERE Email = lower(LTRIM(RTRIM(@EMAIL))) and DataExclusao is null))
  begin     
   set @Retorno = 'Este e-mail já existe em nosso banco !'    
   return    
  end    
 else    
  begin     
   set @Email = lower(@Email)    
   begin try    
    begin tran    
     insert into Endereco (Logradouro, CEP, Bairro, UF, Cidade, Numero, Complemento)     
       values(@Logradouro, @CEP, @Bairro, @UF, @Cidade, @Numero, @Complemento)    
     declare @CodEndereco int     
     set @CodEndereco = SCOPE_IDENTITY()
     insert into Pessoa (Nome, CPF, DataNascimento, Telefone, Celular, CodEndereco)     
       values(@Nome, @CPF, @DataNascimento, @Telefone, @Celular, @CodEndereco)    
     declare  @CodPessoa int    
     set @CodPessoa = SCOPE_IDENTITY()
               
     insert into Usuario (Email, Senha, CodPessoa, DataCadastro) values(@Email, @Senha, @CodPessoa, getdate())    
     commit    
	 select * from Usuario where CodUsuario = SCOPE_IDENTITY()
     set @Retorno = 'Cadastro realizado com sucesso !'    
     return     
   end try    
   begin catch    
    rollback    
    set @Retorno = ERROR_MESSAGE()    
    return     
   end catch    
  end    
end 

GO
/****** Object:  StoredProcedure [dbo].[pEditarUsuario]    Script Date: 25/03/2020 01:44:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pEditarUsuario]     
 @CodUsuario varchar(50),    
 @CodPessoa varchar(50),    
 @CodEndereco varchar(50),    
     
 @Email varchar(100),    
 @Senha varchar(300) = null,  
    
 @Nome varchar(50),    
 @CPF varchar(14) = null,    
 @DataNascimento date = null,    
 @Telefone varchar(16) = null,    
 @Celular varchar(16) = null,    
    
 @Logradouro varchar(100) = null,    
 @CEP varchar(10) = null,    
 @Cidade varchar(50) = null,    
 @Bairro varchar(50) = null,    
 @UF varchar(10) = null,    
 @Numero varchar(10) = null,    
 @Complemento varchar(100) = null,    
 @Retorno varchar(250) output    
as    
begin    
 SET @Email = LTRIM(RTRIM(LOWER(@Email)))    
 SET @Senha = LTRIM(RTRIM(@Senha))    
     
 if(EXISTS(select email from Usuario where email = @Email) and @Email != (select email from Usuario where CodUsuario = @CodUsuario))    
 begin    
  set @Retorno = 'Este e-mail já está em uso.'    
  return    
 end    
    
 if(LTRIM(RTRIM(@Nome)) = '' or @Email = ''
	or @Nome is null or @Email is null)    
 begin     
  set @Retorno = 'Por favor, reveja os campos novamente.'    
  return    
 end    
 else begin    
 begin try    
  begin tran    
  DECLARE @EMAILANTIGO VARCHAR(50)
  SELECT @EMAILANTIGO = Email FROM Usuario (NOLOCK) WHERE CodUsuario = @CodUsuario    
      
  if(@Senha != '' and @Senha is not null)    
   begin    
    update Usuario     
     set  Email = @Email, Senha = @Senha  
     where CodUsuario = @CodUsuario    
    update Pessoa     
     set Nome = @Nome, CPF = @CPF, DataNascimento = @DataNascimento,    
     Telefone = @Telefone, Celular = @Celular
     where CodPessoa = @CodPessoa    
    update Endereco    
     set Logradouro = @Logradouro, CEP = @CEP, Cidade = @Cidade, Bairro = @Bairro, UF = @UF,     
     Numero = @Numero, Complemento = @Complemento    
     where CodEndereco = @CodEndereco    
    commit    
    set @Retorno = 'Dados Atualizados com sucesso !'    
    return    
   end    
  else    
   begin    
    update Usuario     
     set  Email = @Email  
     where CodUsuario = @CodUsuario    
    update Pessoa     
     set Nome = @Nome, CPF = @CPF, DataNascimento = @DataNascimento,    
     Telefone = @Telefone, Celular = @Celular
     where CodPessoa = @CodPessoa    
    update Endereco    
     set Logradouro = @Logradouro, CEP = @CEP, Cidade = @Cidade, Bairro = @Bairro, UF = @UF,     
     Numero = @Numero, Complemento = @Complemento    
     where CodEndereco = @CodEndereco
    commit    
    set @Retorno = 'Dados Atualizados com sucesso !'    
    return    
   end    
 end try    
 begin catch    
  rollback    
  set @Retorno = ERROR_MESSAGE()    
  return    
 end catch    
 end      
end 

GO
