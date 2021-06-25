USE [saulodac_ecommerce]
GO
/****** Object:  User [saulodac_admin]    Script Date: 13/01/2020 20:01:53 ******/
CREATE USER [saulodac_admin] FOR LOGIN [saulodac_admin] WITH DEFAULT_SCHEMA=[saulodac_admin]
GO
ALTER ROLE [db_owner] ADD MEMBER [saulodac_admin]
GO
/****** Object:  Schema [saulodac_admin]    Script Date: 13/01/2020 20:01:54 ******/
CREATE SCHEMA [saulodac_admin]
GO
/****** Object:  Table [dbo].[Assinante]    Script Date: 13/01/2020 20:01:54 ******/
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
/****** Object:  Table [dbo].[Avaliacao]    Script Date: 13/01/2020 20:01:55 ******/
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
/****** Object:  Table [dbo].[Categoria]    Script Date: 13/01/2020 20:01:55 ******/
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
/****** Object:  Table [dbo].[Cupom]    Script Date: 13/01/2020 20:01:55 ******/
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
/****** Object:  Table [dbo].[Endereco]    Script Date: 13/01/2020 20:01:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Endereco](
	[CodEndereco] [int] IDENTITY(1,1) NOT NULL,
	[Logradouro] [varchar](100) NULL,
	[CEP] [varchar](10) NULL,
	[Bairro] [varchar](50) NULL,
	[UF] [varchar](2) NULL,
	[Cidade] [varchar](50) NULL,
	[Numero] [varchar](20) NULL,
	[Complemento] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[CodEndereco] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ImagemProduto]    Script Date: 13/01/2020 20:01:55 ******/
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
/****** Object:  Table [dbo].[ItemCarrinho]    Script Date: 13/01/2020 20:01:55 ******/
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
/****** Object:  Table [dbo].[ItemPedido]    Script Date: 13/01/2020 20:01:55 ******/
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
/****** Object:  Table [dbo].[LogStatusPedido]    Script Date: 13/01/2020 20:01:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogStatusPedido](
	[CodLogStatusPedido] [bigint] IDENTITY(1,1) NOT NULL,
	[CodPedido] [bigint] NOT NULL,
	[CodStatusPedido] [int] NOT NULL,
	[Data] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CodLogStatusPedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Pedido]    Script Date: 13/01/2020 20:01:55 ******/
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
PRIMARY KEY CLUSTERED 
(
	[CodPedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Permissao]    Script Date: 13/01/2020 20:01:55 ******/
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
/****** Object:  Table [dbo].[Pessoa]    Script Date: 13/01/2020 20:01:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Pessoa](
	[CodPessoa] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](50) NOT NULL,
	[CPF] [varchar](15) NULL,
	[DataNascimento] [date] NULL,
	[Telefone] [varchar](15) NULL,
	[CodEndereco] [int] NOT NULL
) ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[Pessoa] ADD [Sobrenome] [varchar](50) NOT NULL
PRIMARY KEY CLUSTERED 
(
	[CodPessoa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Produto]    Script Date: 13/01/2020 20:01:55 ******/
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
	[Altura] [varchar](100) NULL,
	[Largura] [varchar](100) NULL,
	[Comprimento] [varchar](100) NULL,
	[Espessura] [varchar](100) NULL,
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
PRIMARY KEY CLUSTERED 
(
	[CodProduto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProdutoCategoria]    Script Date: 13/01/2020 20:01:55 ******/
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
/****** Object:  Table [dbo].[ProdutoObservacoes]    Script Date: 13/01/2020 20:01:55 ******/
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
/****** Object:  Table [dbo].[StatusPedido]    Script Date: 13/01/2020 20:01:55 ******/
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
/****** Object:  Table [dbo].[Usuario]    Script Date: 13/01/2020 20:01:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuario](
	[CodUsuario] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](256) NOT NULL
) ON [PRIMARY]
SET ANSI_PADDING OFF
ALTER TABLE [dbo].[Usuario] ADD [Senha] [varchar](400) NOT NULL
ALTER TABLE [dbo].[Usuario] ADD [CodPessoa] [int] NOT NULL
ALTER TABLE [dbo].[Usuario] ADD [DataExclusao] [datetime] NULL
ALTER TABLE [dbo].[Usuario] ADD [DataCadastro] [datetime] NOT NULL
PRIMARY KEY CLUSTERED 
(
	[CodUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UsuarioPermissao]    Script Date: 13/01/2020 20:01:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuarioPermissao](
	[CodUsuario] [int] NOT NULL,
	[CodPermissao] [int] NOT NULL
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Avaliacao]  WITH CHECK ADD FOREIGN KEY([CodProduto])
REFERENCES [dbo].[Produto] ([CodProduto])
GO
ALTER TABLE [dbo].[Avaliacao]  WITH CHECK ADD FOREIGN KEY([CodUsuario])
REFERENCES [dbo].[Usuario] ([CodUsuario])
GO
ALTER TABLE [dbo].[ImagemProduto]  WITH CHECK ADD FOREIGN KEY([CodProduto])
REFERENCES [dbo].[Produto] ([CodProduto])
GO
ALTER TABLE [dbo].[ItemCarrinho]  WITH CHECK ADD FOREIGN KEY([CodProduto])
REFERENCES [dbo].[Produto] ([CodProduto])
GO
ALTER TABLE [dbo].[ItemCarrinho]  WITH CHECK ADD FOREIGN KEY([CodUsuario])
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
/****** Object:  StoredProcedure [dbo].[pCadastrarUsuario]    Script Date: 13/01/2020 20:01:55 ******/
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
/****** Object:  StoredProcedure [dbo].[pCadastrarUsuarioERetornar]    Script Date: 13/01/2020 20:01:55 ******/
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
/****** Object:  StoredProcedure [dbo].[pEditarUsuario]    Script Date: 13/01/2020 20:01:55 ******/
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
