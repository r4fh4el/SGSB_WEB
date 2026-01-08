IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [AspNetRoles] (
        [Id] nvarchar(450) NOT NULL,
        [Name] nvarchar(256) NULL,
        [NormalizedName] nvarchar(256) NULL,
        [ConcurrencyStamp] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetRoles] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [AspNetUsers] (
        [Id] nvarchar(450) NOT NULL,
        [USR_IDADE] int NOT NULL,
        [USR_CELULAR] nvarchar(max) NULL,
        [USR_TIPO] int NULL,
        [UserName] nvarchar(256) NULL,
        [NormalizedUserName] nvarchar(256) NULL,
        [Email] nvarchar(256) NULL,
        [NormalizedEmail] nvarchar(256) NULL,
        [EmailConfirmed] bit NOT NULL,
        [PasswordHash] nvarchar(max) NULL,
        [SecurityStamp] nvarchar(max) NULL,
        [ConcurrencyStamp] nvarchar(max) NULL,
        [PhoneNumber] nvarchar(max) NULL,
        [PhoneNumberConfirmed] bit NOT NULL,
        [TwoFactorEnabled] bit NOT NULL,
        [LockoutEnd] datetimeoffset NULL,
        [LockoutEnabled] bit NOT NULL,
        [AccessFailedCount] int NOT NULL,
        CONSTRAINT [PK_AspNetUsers] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [CARACTERIZACAO_AREA_JUSANTE] (
        [ID] int NOT NULL IDENTITY,
        [INT_DISTANCIA] int NOT NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_CARACTERIZACAO_AREA_JUSANTE] PRIMARY KEY ([ID])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [COTA_AREA_VOLUME] (
        [ID] int NOT NULL IDENTITY,
        [STR_COTA] nvarchar(max) NULL,
        [STR_VOLUME_ACUMULADO] nvarchar(max) NULL,
        [STR_AREA_SUPERFICIE] nvarchar(max) NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_COTA_AREA_VOLUME] PRIMARY KEY ([ID])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [DADOS_GERAl] (
        [ID] int NOT NULL IDENTITY,
        [STR_NOME_EMPREENDEDOR] nvarchar(255) NULL,
        [INT_TIPO_EMPREENDEDOR] int NOT NULL,
        [STR_ENDERECO_EMPREENDEDOR] nvarchar(255) NULL,
        [STR_RESPONSAVEL_EMPREENDEDOR] nvarchar(255) NULL,
        [STR_EMAIL_EMPREENDEDOR] nvarchar(255) NULL,
        [STR_TELEFONE_EMPREENDEDOR] nvarchar(50) NULL,
        [INT_QUANTIDADE_BARRAGEM] int NOT NULL,
        [STR_LATITUDE_EMPREENDEDOR] nvarchar(50) NULL,
        [STR_LONGITUDE_EMPREENDEDOR] nvarchar(50) NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_DADOS_GERAl] PRIMARY KEY ([ID])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [DESCARREGADOR_FUNDO] (
        [ID] int NOT NULL IDENTITY,
        [STR_TIPO] nvarchar(255) NULL,
        [STR_LOCALIZACAO] nvarchar(255) NULL,
        [DB_COTA_SOLEIRA_ENTRADA] float NOT NULL,
        [DB_COMPRIMENTO] float NOT NULL,
        [DB_DIMENSAO] float NOT NULL,
        [STR_TIPO_COMPORTA] nvarchar(255) NULL,
        [BOOL_TIPO_ACIONAMENTO_COMPORTA] bit NOT NULL,
        [BOOL_FONTE_ALTERNATIVA_ENERGIA] bit NOT NULL,
        [BOOL_COMANDO_DISTANCIA] bit NOT NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_DESCARREGADOR_FUNDO] PRIMARY KEY ([ID])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [INSTRUMENTOS] (
        [ID] int NOT NULL IDENTITY,
        [STR_NOME] nvarchar(255) NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_INSTRUMENTOS] PRIMARY KEY ([ID])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [RESERVATORIO] (
        [ID] int NOT NULL IDENTITY,
        [DB_CAPACIDADE_TOTAL_RESERVATORIO] float NOT NULL,
        [DB_VOLUME_UTIL_RESERVATORIO] float NOT NULL,
        [DB_BORDA_LIVRE] float NOT NULL,
        [DB_MAXIMO_MAXIMORUM] float NOT NULL,
        [DB_MAXIMO_NORMAL] float NOT NULL,
        [DB_MINIMO_OPERACIONAL] float NOT NULL,
        [DB_VOLUME_MORTO] float NOT NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_RESERVATORIO] PRIMARY KEY ([ID])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [SISTEMA_DRENAGEM] (
        [ID] int NOT NULL IDENTITY,
        [STR_NOME] nvarchar(255) NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_SISTEMA_DRENAGEM] PRIMARY KEY ([ID])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [TALUDE] (
        [ID] int NOT NULL IDENTITY,
        [DB_INCLINACAO_TALUDE_MONTANTE] float NOT NULL,
        [DB_INCLINACAO_TALUDE_JUSANTE] float NOT NULL,
        [STR_PROTECAO_SUPERFICIE_MONTANTE] nvarchar(255) NULL,
        [STR_PROTECAO_SUPERFICIE_JUSANTE] nvarchar(255) NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_TALUDE] PRIMARY KEY ([ID])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [TIPO_ESTRUTURA_BARRAGEM] (
        [ID] int NOT NULL IDENTITY,
        [STR_NOME] nvarchar(255) NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_TIPO_ESTRUTURA_BARRAGEM] PRIMARY KEY ([ID])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [TIPO_MATERIAL_BARRAGEM] (
        [ID] int NOT NULL IDENTITY,
        [STR_NOME] nvarchar(255) NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_TIPO_MATERIAL_BARRAGEM] PRIMARY KEY ([ID])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [TOMADA_DAGUA] (
        [ID] int NOT NULL IDENTITY,
        [STR_LOCALIZACAO] nvarchar(255) NULL,
        [DB_COMPRIMENTO] float NOT NULL,
        [STR_CONTROLE_ENTRADA] nvarchar(255) NULL,
        [STR_CONTROLE_Saida] nvarchar(255) NULL,
        [DB_COTAS_TOMADAS_DAGUA_ENTRADA] float NOT NULL,
        [BOOL_FONTE_ALTERNATIVA_ENERGIA] bit NOT NULL,
        [BOOL_POSSIBILIDADE_MANOBRA_MANUAL] bit NOT NULL,
        [BOOL_COMANDO_DISTANCIA] bit NOT NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_TOMADA_DAGUA] PRIMARY KEY ([ID])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [USO_BARRAGEM] (
        [ID] int NOT NULL IDENTITY,
        [STR_NOME] nvarchar(255) NULL,
        [BOOL_GERACAO_ENERGIA] bit NOT NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_USO_BARRAGEM] PRIMARY KEY ([ID])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [VERTEDOURO] (
        [ID] int NOT NULL IDENTITY,
        [STR_TIPO_ESTRUTURA_EXTRAVASORA] nvarchar(255) NULL,
        [BOOL_VERTEDOURO_CONTROLE] bit NOT NULL,
        [INT_QUANTIDADE_COMPORTA] int NOT NULL,
        [BOOL_TIPO_ACIONAMENTO_COMPORTAS] bit NOT NULL,
        [STR_LOCALIZACAO] nvarchar(255) NULL,
        [DB_COMPRIMENTO_TOTAL_VERTEDOURO] float NOT NULL,
        [DB_LARGURA_TOTAL_VERTEDOURO] float NOT NULL,
        [DB_ALTURA] float NOT NULL,
        [DB_COTA_SOLEIRO] float NOT NULL,
        [BOOL_VETEDOURO_AUXILIAR] bit NOT NULL,
        [DB_TEMPO_RETORNO_VAZAO] int NOT NULL,
        [DB_VAZAO] float NOT NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_VERTEDOURO] PRIMARY KEY ([ID])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [AspNetRoleClaims] (
        [Id] int NOT NULL IDENTITY,
        [RoleId] nvarchar(450) NOT NULL,
        [ClaimType] nvarchar(max) NULL,
        [ClaimValue] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [AspNetUserClaims] (
        [Id] int NOT NULL IDENTITY,
        [UserId] nvarchar(450) NOT NULL,
        [ClaimType] nvarchar(max) NULL,
        [ClaimValue] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [AspNetUserLogins] (
        [LoginProvider] nvarchar(450) NOT NULL,
        [ProviderKey] nvarchar(450) NOT NULL,
        [ProviderDisplayName] nvarchar(max) NULL,
        [UserId] nvarchar(450) NOT NULL,
        CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY ([LoginProvider], [ProviderKey]),
        CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [AspNetUserRoles] (
        [UserId] nvarchar(450) NOT NULL,
        [RoleId] nvarchar(450) NOT NULL,
        CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY ([UserId], [RoleId]),
        CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [AspNetUserTokens] (
        [UserId] nvarchar(450) NOT NULL,
        [LoginProvider] nvarchar(450) NOT NULL,
        [Name] nvarchar(450) NOT NULL,
        [Value] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY ([UserId], [LoginProvider], [Name]),
        CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [Barragem] (
        [Tipo_Material_Id] int NOT NULL,
        [Tipo_Estrutura_Id] int NOT NULL,
        [ID] int NOT NULL IDENTITY,
        [STR_BACIA_HIDROGRAFICA_ABRANGENCIA] nvarchar(255) NULL,
        [STR_CURSO_DAGUA_BARRADO] nvarchar(255) NULL,
        [STR_ANO_CONCLUSAO] nvarchar(255) NULL,
        [STR_IDADE_BARRAGEM] nvarchar(255) NULL,
        [STR_TIPO_FUNDACAO] nvarchar(255) NULL,
        [DB_ALTURA_MAXIMA] float NOT NULL,
        [DB_COMPRIMENTO_COROAMENTO] float NOT NULL,
        [DB_LARGURA_COROAMENTO_BARRAGEM] float NOT NULL,
        [DB_COTA_COROAMENTO_BARRAGEM] float NOT NULL,
        [TipoMaterialBarragemId] int NULL,
        [TipoEstruturaBarragemId] int NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_Barragem] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_Barragem_TIPO_ESTRUTURA_BARRAGEM_TipoEstruturaBarragemId] FOREIGN KEY ([TipoEstruturaBarragemId]) REFERENCES [TIPO_ESTRUTURA_BARRAGEM] ([ID]),
        CONSTRAINT [FK_Barragem_TIPO_MATERIAL_BARRAGEM_TipoMaterialBarragemId] FOREIGN KEY ([TipoMaterialBarragemId]) REFERENCES [TIPO_MATERIAL_BARRAGEM] ([ID])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [CARACTERIZACAO_AREA_JUSANTE_BARRAGEM] (
        [ID] int NOT NULL IDENTITY,
        [CaracterizacaoAreaJusanteBarragemId] int NOT NULL,
        [BarragemId] int NOT NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_CARACTERIZACAO_AREA_JUSANTE_BARRAGEM] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_CARACTERIZACAO_AREA_JUSANTE_BARRAGEM_Barragem_BarragemId] FOREIGN KEY ([BarragemId]) REFERENCES [Barragem] ([ID]) ON DELETE CASCADE,
        CONSTRAINT [FK_CARACTERIZACAO_AREA_JUSANTE_BARRAGEM_CARACTERIZACAO_AREA_JUSANTE_CaracterizacaoAreaJusanteBarragemId] FOREIGN KEY ([CaracterizacaoAreaJusanteBarragemId]) REFERENCES [CARACTERIZACAO_AREA_JUSANTE] ([ID]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [DOCUMENTACAO_PROJETO_CONSTRUCAO_OPERACAO] (
        [BarragemId] int NOT NULL,
        [ID] int NOT NULL IDENTITY,
        [STR_PERGUNTA] nvarchar(255) NULL,
        [BOOL_RESPOSTA] bit NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_DOCUMENTACAO_PROJETO_CONSTRUCAO_OPERACAO] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_DOCUMENTACAO_PROJETO_CONSTRUCAO_OPERACAO_Barragem_BarragemId] FOREIGN KEY ([BarragemId]) REFERENCES [Barragem] ([ID]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [INFORMACOES_COMPLEMENTARES] (
        [BarragemId] int NOT NULL,
        [ID] int NOT NULL IDENTITY,
        [STR_NOME_SETOR] nvarchar(255) NULL,
        [BOOL_TEM_OUTORGA_CONSTRUCAO] bit NOT NULL,
        [STR_NUMERO_PORTARIA_OUTORGA] nvarchar(255) NULL,
        [BOOL_TEM_LICENCA_OPERACAO] bit NOT NULL,
        [STR_NUMERO_PORTARIA_LICENCA_OPERACAO] nvarchar(255) NULL,
        [STR_VAZAO_MINIMA_RESTITUICAO_ANO] nvarchar(255) NULL,
        [BOOL_TEM_VIGIA] bit NOT NULL,
        [BOOL_TEM_OPERADOR24] bit NOT NULL,
        [BOOL_TEM_EQUIPE_OPERACAO] bit NOT NULL,
        [BOOL_TEM_ESCRITORIO_LOCAL] bit NOT NULL,
        [BOOL_TEM_EDIFICACAO_LOCAL] bit NOT NULL,
        [BOOL_TEM_HISTORICO_INCIDENTE_ACIDENTE] bit NOT NULL,
        [STR_HISTORICO_INCIDENTE_ACIDENTE] nvarchar(255) NULL,
        [INT_ANO_ULTIMA_REFORMA] int NOT NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_INFORMACOES_COMPLEMENTARES] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_INFORMACOES_COMPLEMENTARES_Barragem_BarragemId] FOREIGN KEY ([BarragemId]) REFERENCES [Barragem] ([ID]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [INSPECOES] (
        [BarragemId] int NOT NULL,
        [ID] int NOT NULL IDENTITY,
        [STR_NOME_SETOR] nvarchar(255) NULL,
        [STR_FREQUENCIA] nvarchar(255) NULL,
        [DT_DATA_ULTIMA_INSPECAO_ESPECIAL] datetime2 NULL,
        [DT_DATA_REVISAO_PERIODICA_RECENTE] datetime2 NULL,
        [BOOL_POSSUI_PAE] bit NOT NULL,
        [DT_DATA_PLANO_ACAO_EMERGENCIA] datetime2 NULL,
        [BOOL_POSSUI_ESTUDO_ROMPIMENTO] bit NOT NULL,
        [DT_DATA__ESTUDO_ROMPIMENTO] datetime2 NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_INSPECOES] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_INSPECOES_Barragem_BarragemId] FOREIGN KEY ([BarragemId]) REFERENCES [Barragem] ([ID]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [INSTRUMENTOS_BARRAGEM] (
        [ID] int NOT NULL IDENTITY,
        [InstrumentosId] int NOT NULL,
        [BarragemId] int NOT NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_INSTRUMENTOS_BARRAGEM] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_INSTRUMENTOS_BARRAGEM_Barragem_BarragemId] FOREIGN KEY ([BarragemId]) REFERENCES [Barragem] ([ID]) ON DELETE CASCADE,
        CONSTRAINT [FK_INSTRUMENTOS_BARRAGEM_INSTRUMENTOS_InstrumentosId] FOREIGN KEY ([InstrumentosId]) REFERENCES [INSTRUMENTOS] ([ID]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [SISTEMA_DRENAGEM_BARRAGEM] (
        [ID] int NOT NULL IDENTITY,
        [SistemaDrenagemId] int NOT NULL,
        [BarragemId] int NOT NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_SISTEMA_DRENAGEM_BARRAGEM] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_SISTEMA_DRENAGEM_BARRAGEM_Barragem_BarragemId] FOREIGN KEY ([BarragemId]) REFERENCES [Barragem] ([ID]) ON DELETE CASCADE,
        CONSTRAINT [FK_SISTEMA_DRENAGEM_BARRAGEM_SISTEMA_DRENAGEM_SistemaDrenagemId] FOREIGN KEY ([SistemaDrenagemId]) REFERENCES [SISTEMA_DRENAGEM] ([ID]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE TABLE [USO_BARRAGEM_BARRAGEM] (
        [ID] int NOT NULL IDENTITY,
        [UsoBarragemId] int NOT NULL,
        [BarragemId] int NOT NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_USO_BARRAGEM_BARRAGEM] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_USO_BARRAGEM_BARRAGEM_Barragem_BarragemId] FOREIGN KEY ([BarragemId]) REFERENCES [Barragem] ([ID]) ON DELETE CASCADE,
        CONSTRAINT [FK_USO_BARRAGEM_BARRAGEM_USO_BARRAGEM_UsoBarragemId] FOREIGN KEY ([UsoBarragemId]) REFERENCES [USO_BARRAGEM] ([ID]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE INDEX [IX_AspNetRoleClaims_RoleId] ON [AspNetRoleClaims] ([RoleId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [RoleNameIndex] ON [AspNetRoles] ([NormalizedName]) WHERE [NormalizedName] IS NOT NULL');
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE INDEX [IX_AspNetUserClaims_UserId] ON [AspNetUserClaims] ([UserId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE INDEX [IX_AspNetUserLogins_UserId] ON [AspNetUserLogins] ([UserId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE INDEX [IX_AspNetUserRoles_RoleId] ON [AspNetUserRoles] ([RoleId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE INDEX [EmailIndex] ON [AspNetUsers] ([NormalizedEmail]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [UserNameIndex] ON [AspNetUsers] ([NormalizedUserName]) WHERE [NormalizedUserName] IS NOT NULL');
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE INDEX [IX_Barragem_TipoEstruturaBarragemId] ON [Barragem] ([TipoEstruturaBarragemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE INDEX [IX_Barragem_TipoMaterialBarragemId] ON [Barragem] ([TipoMaterialBarragemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE INDEX [IX_CARACTERIZACAO_AREA_JUSANTE_BARRAGEM_BarragemId] ON [CARACTERIZACAO_AREA_JUSANTE_BARRAGEM] ([BarragemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE INDEX [IX_CARACTERIZACAO_AREA_JUSANTE_BARRAGEM_CaracterizacaoAreaJusanteBarragemId] ON [CARACTERIZACAO_AREA_JUSANTE_BARRAGEM] ([CaracterizacaoAreaJusanteBarragemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE INDEX [IX_DOCUMENTACAO_PROJETO_CONSTRUCAO_OPERACAO_BarragemId] ON [DOCUMENTACAO_PROJETO_CONSTRUCAO_OPERACAO] ([BarragemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE INDEX [IX_INFORMACOES_COMPLEMENTARES_BarragemId] ON [INFORMACOES_COMPLEMENTARES] ([BarragemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE INDEX [IX_INSPECOES_BarragemId] ON [INSPECOES] ([BarragemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE INDEX [IX_INSTRUMENTOS_BARRAGEM_BarragemId] ON [INSTRUMENTOS_BARRAGEM] ([BarragemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE INDEX [IX_INSTRUMENTOS_BARRAGEM_InstrumentosId] ON [INSTRUMENTOS_BARRAGEM] ([InstrumentosId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE INDEX [IX_SISTEMA_DRENAGEM_BARRAGEM_BarragemId] ON [SISTEMA_DRENAGEM_BARRAGEM] ([BarragemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE INDEX [IX_SISTEMA_DRENAGEM_BARRAGEM_SistemaDrenagemId] ON [SISTEMA_DRENAGEM_BARRAGEM] ([SistemaDrenagemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE INDEX [IX_USO_BARRAGEM_BARRAGEM_BarragemId] ON [USO_BARRAGEM_BARRAGEM] ([BarragemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    CREATE INDEX [IX_USO_BARRAGEM_BARRAGEM_UsoBarragemId] ON [USO_BARRAGEM_BARRAGEM] ([UsoBarragemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418124017_Criacao_18042023')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230418124017_Criacao_18042023', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418184411_Criacao_18042023_2')
BEGIN
    ALTER TABLE [AspNetUsers] ADD [USR_NOME] nvarchar(max) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230418184411_Criacao_18042023_2')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230418184411_Criacao_18042023_2', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230427233017_Criacao_27042023_2')
BEGIN
    ALTER TABLE [Barragem] ADD [CondicaoFundacaoId] int NOT NULL DEFAULT 0;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230427233017_Criacao_27042023_2')
BEGIN
    CREATE TABLE [CONDICAO_FUNDACAO] (
        [ID] int NOT NULL IDENTITY,
        [STR_NOME] nvarchar(255) NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_CONDICAO_FUNDACAO] PRIMARY KEY ([ID])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230427233017_Criacao_27042023_2')
BEGIN
    CREATE INDEX [IX_Barragem_CondicaoFundacaoId] ON [Barragem] ([CondicaoFundacaoId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230427233017_Criacao_27042023_2')
BEGIN
    ALTER TABLE [Barragem] ADD CONSTRAINT [FK_Barragem_CONDICAO_FUNDACAO_CondicaoFundacaoId] FOREIGN KEY ([CondicaoFundacaoId]) REFERENCES [CONDICAO_FUNDACAO] ([ID]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230427233017_Criacao_27042023_2')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230427233017_Criacao_27042023_2', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230428145346_AlterarModalidade')
BEGIN
    ALTER TABLE [VERTEDOURO] ADD [STR_MODALIDADE_DISSIPACAO_ENERGIA] nvarchar(255) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230428145346_AlterarModalidade')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230428145346_AlterarModalidade', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230429030007_TipoEdificacao')
BEGIN
    ALTER TABLE [CARACTERIZACAO_AREA_JUSANTE] ADD [TipoEdificacaoId] int NOT NULL DEFAULT 0;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230429030007_TipoEdificacao')
BEGIN
    CREATE TABLE [TIPO_EDIFICACAO] (
        [ID] int NOT NULL IDENTITY,
        [STR_NOME] nvarchar(255) NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_TIPO_EDIFICACAO] PRIMARY KEY ([ID])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230429030007_TipoEdificacao')
BEGIN
    CREATE INDEX [IX_CARACTERIZACAO_AREA_JUSANTE_TipoEdificacaoId] ON [CARACTERIZACAO_AREA_JUSANTE] ([TipoEdificacaoId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230429030007_TipoEdificacao')
BEGIN
    ALTER TABLE [CARACTERIZACAO_AREA_JUSANTE] ADD CONSTRAINT [FK_CARACTERIZACAO_AREA_JUSANTE_TIPO_EDIFICACAO_TipoEdificacaoId] FOREIGN KEY ([TipoEdificacaoId]) REFERENCES [TIPO_EDIFICACAO] ([ID]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230429030007_TipoEdificacao')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230429030007_TipoEdificacao', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230507015407_AtualicacaoTipoEmprreendedor')
BEGIN
    CREATE TABLE [TIPO_EMPREENDEDOR] (
        [ID] int NOT NULL IDENTITY,
        [STR_NOME] nvarchar(255) NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_TIPO_EMPREENDEDOR] PRIMARY KEY ([ID])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230507015407_AtualicacaoTipoEmprreendedor')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230507015407_AtualicacaoTipoEmprreendedor', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230508005422_DocumentacaoPerguntas')
BEGIN
    CREATE TABLE [DOCUMENTACAO_PERGUNTAS] (
        [ID] int NOT NULL IDENTITY,
        [STR_PERGUNTA] nvarchar(255) NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_DOCUMENTACAO_PERGUNTAS] PRIMARY KEY ([ID])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230508005422_DocumentacaoPerguntas')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230508005422_DocumentacaoPerguntas', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230525011226_DanoPotencial')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230525011226_DanoPotencial', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230525120446_Respostas')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230525120446_Respostas', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230605233523_CaracteristicaBacia')
BEGIN
    ALTER TABLE [Barragem] DROP CONSTRAINT [FK_Barragem_CONDICAO_FUNDACAO_CondicaoFundacaoId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230605233523_CaracteristicaBacia')
BEGIN
    ALTER TABLE [Barragem] DROP CONSTRAINT [FK_Barragem_TIPO_ESTRUTURA_BARRAGEM_TipoEstruturaBarragemId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230605233523_CaracteristicaBacia')
BEGIN
    ALTER TABLE [Barragem] DROP CONSTRAINT [FK_Barragem_TIPO_MATERIAL_BARRAGEM_TipoMaterialBarragemId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230605233523_CaracteristicaBacia')
BEGIN
    DROP INDEX [IX_Barragem_CondicaoFundacaoId] ON [Barragem];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230605233523_CaracteristicaBacia')
BEGIN
    DROP INDEX [IX_Barragem_TipoEstruturaBarragemId] ON [Barragem];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230605233523_CaracteristicaBacia')
BEGIN
    DROP INDEX [IX_Barragem_TipoMaterialBarragemId] ON [Barragem];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230605233523_CaracteristicaBacia')
BEGIN
    DECLARE @var0 sysname;
    SELECT @var0 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Barragem]') AND [c].[name] = N'TipoEstruturaBarragemId');
    IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [Barragem] DROP CONSTRAINT [' + @var0 + '];');
    ALTER TABLE [Barragem] DROP COLUMN [TipoEstruturaBarragemId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230605233523_CaracteristicaBacia')
BEGIN
    DECLARE @var1 sysname;
    SELECT @var1 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Barragem]') AND [c].[name] = N'TipoMaterialBarragemId');
    IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [Barragem] DROP CONSTRAINT [' + @var1 + '];');
    ALTER TABLE [Barragem] DROP COLUMN [TipoMaterialBarragemId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230605233523_CaracteristicaBacia')
BEGIN
    CREATE TABLE [DANO_POTENCIAL_ASSOCIADO] (
        [BarragemId] int NOT NULL,
        [ID] int NOT NULL IDENTITY,
        [INT_VTR_Q1] int NOT NULL,
        [INT_VTR_Q2] int NOT NULL,
        [INT_VTR_Q3] int NOT NULL,
        [INT_VTR_Q4] int NOT NULL,
        [INT_VTR_RESPOSTA] int NOT NULL,
        [INT_PPV_Q1] int NOT NULL,
        [INT_PPV_Q2] int NOT NULL,
        [INT_PPV_Q3] int NOT NULL,
        [INT_PPV_Q4] int NOT NULL,
        [INT_PPV_RESPOSTA] int NOT NULL,
        [INT_IA_Q1] int NOT NULL,
        [INT_IA_Q2] int NOT NULL,
        [INT_IA_RESPOSTA] int NOT NULL,
        [INT_ISE_Q1] int NOT NULL,
        [INT_ISE_Q2] int NOT NULL,
        [INT_ISE_Q3] int NOT NULL,
        [INT_ISE_RESPOSTA] int NOT NULL,
        [INT_DPA_TOTAL] int NOT NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_DANO_POTENCIAL_ASSOCIADO] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_DANO_POTENCIAL_ASSOCIADO_Barragem_BarragemId] FOREIGN KEY ([BarragemId]) REFERENCES [Barragem] ([ID]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230605233523_CaracteristicaBacia')
BEGIN
    CREATE INDEX [IX_DANO_POTENCIAL_ASSOCIADO_BarragemId] ON [DANO_POTENCIAL_ASSOCIADO] ([BarragemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230605233523_CaracteristicaBacia')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230605233523_CaracteristicaBacia', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230606012747_UsoSolo')
BEGIN
    CREATE TABLE [USO_SOLO_PREDOMINANTE] (
        [ID] int NOT NULL IDENTITY,
        [STR_NOME] nvarchar(255) NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_USO_SOLO_PREDOMINANTE] PRIMARY KEY ([ID])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230606012747_UsoSolo')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230606012747_UsoSolo', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230606012927_CaracteristicaBacia2')
BEGIN
    CREATE TABLE [CARACTERISTICA_BACIA] (
        [UsoSoloPredominanteId] int NOT NULL,
        [ID] int NOT NULL IDENTITY,
        [TXT_NOME] nvarchar(max) NOT NULL,
        [TXT_CURSO_HIDRICO] nvarchar(max) NOT NULL,
        [INT_CARACTERISTICA_PREDOMINANTE] int NOT NULL,
        [DB_AREA_BACIA] float NOT NULL,
        [DB_AREA_DRENAGEM] float NOT NULL,
        [DB_PERIMETRO] float NOT NULL,
        [DB_COMPRIMENTO_RIO_PRINCIPAL] float NOT NULL,
        [DB_COMPRIMENTO_VETORIAL_RIO_PRINCIPAL] float NOT NULL,
        [DB_COMPRIMENTO_TOTAL_RIO] float NOT NULL,
        [DB_COMPRIMENTO_AXIAL] float NOT NULL,
        [DB_ALTITUDE_MINIMA] float NOT NULL,
        [DB_ALTITUDE_MAXIMA] float NOT NULL,
        [DB_ALTITUDE_ALTIMETRICA_M] float NOT NULL,
        [DB_ALTITUDE_ALTIMETRICA_KM] float NOT NULL,
        [DB_DECLIVIDADE] float NOT NULL,
        [TXT_MUNICIPIO_NASCENTE_RIO] nvarchar(max) NOT NULL,
        [TXT_MUNICIPIO_FOZ] nvarchar(max) NOT NULL,
        [TXT_DEFINICAO_PADRAO_DRENAGEM] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_CARACTERISTICA_BACIA] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_CARACTERISTICA_BACIA_USO_SOLO_PREDOMINANTE_UsoSoloPredominanteId] FOREIGN KEY ([UsoSoloPredominanteId]) REFERENCES [USO_SOLO_PREDOMINANTE] ([ID]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230606012927_CaracteristicaBacia2')
BEGIN
    CREATE INDEX [IX_CARACTERISTICA_BACIA_UsoSoloPredominanteId] ON [CARACTERISTICA_BACIA] ([UsoSoloPredominanteId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230606012927_CaracteristicaBacia2')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230606012927_CaracteristicaBacia2', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230614223345_TempoConcentracao')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230614223345_TempoConcentracao', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230614232317_TCBarragemID')
BEGIN
    CREATE TABLE [TEMPO_CONCENTRACAO] (
        [ID] int NOT NULL IDENTITY,
        [DB_BARRAGEM_ID] int NOT NULL,
        [DB_COMPRIMENTO_RIO_PRINCIPAL] float NULL,
        [DB_DECLIVIDADE_BACIA] float NULL,
        [DB_AREA_DRENAGEM] float NULL,
        [DB_RESULTADO_KIRPICH] float NULL,
        [DB_RESULTADO_CORPS_ENGINEERS] float NULL,
        [DB_RESULTADO_CARTER] float NULL,
        [DB_RESULTADO_DOOGE] float NULL,
        [DB_RESULTADO_VEN_TE_CHOW] float NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_TEMPO_CONCENTRACAO] PRIMARY KEY ([ID])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230614232317_TCBarragemID')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230614232317_TCBarragemID', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230617032151_indicecaracterizacao')
BEGIN
    DECLARE @var2 sysname;
    SELECT @var2 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TEMPO_CONCENTRACAO]') AND [c].[name] = N'DB_RESULTADO_VEN_TE_CHOW');
    IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [TEMPO_CONCENTRACAO] DROP CONSTRAINT [' + @var2 + '];');
    EXEC(N'UPDATE [TEMPO_CONCENTRACAO] SET [DB_RESULTADO_VEN_TE_CHOW] = 0.0E0 WHERE [DB_RESULTADO_VEN_TE_CHOW] IS NULL');
    ALTER TABLE [TEMPO_CONCENTRACAO] ALTER COLUMN [DB_RESULTADO_VEN_TE_CHOW] float NOT NULL;
    ALTER TABLE [TEMPO_CONCENTRACAO] ADD DEFAULT 0.0E0 FOR [DB_RESULTADO_VEN_TE_CHOW];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230617032151_indicecaracterizacao')
BEGIN
    DECLARE @var3 sysname;
    SELECT @var3 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TEMPO_CONCENTRACAO]') AND [c].[name] = N'DB_RESULTADO_KIRPICH');
    IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [TEMPO_CONCENTRACAO] DROP CONSTRAINT [' + @var3 + '];');
    EXEC(N'UPDATE [TEMPO_CONCENTRACAO] SET [DB_RESULTADO_KIRPICH] = 0.0E0 WHERE [DB_RESULTADO_KIRPICH] IS NULL');
    ALTER TABLE [TEMPO_CONCENTRACAO] ALTER COLUMN [DB_RESULTADO_KIRPICH] float NOT NULL;
    ALTER TABLE [TEMPO_CONCENTRACAO] ADD DEFAULT 0.0E0 FOR [DB_RESULTADO_KIRPICH];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230617032151_indicecaracterizacao')
BEGIN
    DECLARE @var4 sysname;
    SELECT @var4 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TEMPO_CONCENTRACAO]') AND [c].[name] = N'DB_RESULTADO_DOOGE');
    IF @var4 IS NOT NULL EXEC(N'ALTER TABLE [TEMPO_CONCENTRACAO] DROP CONSTRAINT [' + @var4 + '];');
    EXEC(N'UPDATE [TEMPO_CONCENTRACAO] SET [DB_RESULTADO_DOOGE] = 0.0E0 WHERE [DB_RESULTADO_DOOGE] IS NULL');
    ALTER TABLE [TEMPO_CONCENTRACAO] ALTER COLUMN [DB_RESULTADO_DOOGE] float NOT NULL;
    ALTER TABLE [TEMPO_CONCENTRACAO] ADD DEFAULT 0.0E0 FOR [DB_RESULTADO_DOOGE];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230617032151_indicecaracterizacao')
BEGIN
    DECLARE @var5 sysname;
    SELECT @var5 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TEMPO_CONCENTRACAO]') AND [c].[name] = N'DB_RESULTADO_CORPS_ENGINEERS');
    IF @var5 IS NOT NULL EXEC(N'ALTER TABLE [TEMPO_CONCENTRACAO] DROP CONSTRAINT [' + @var5 + '];');
    EXEC(N'UPDATE [TEMPO_CONCENTRACAO] SET [DB_RESULTADO_CORPS_ENGINEERS] = 0.0E0 WHERE [DB_RESULTADO_CORPS_ENGINEERS] IS NULL');
    ALTER TABLE [TEMPO_CONCENTRACAO] ALTER COLUMN [DB_RESULTADO_CORPS_ENGINEERS] float NOT NULL;
    ALTER TABLE [TEMPO_CONCENTRACAO] ADD DEFAULT 0.0E0 FOR [DB_RESULTADO_CORPS_ENGINEERS];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230617032151_indicecaracterizacao')
BEGIN
    DECLARE @var6 sysname;
    SELECT @var6 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TEMPO_CONCENTRACAO]') AND [c].[name] = N'DB_RESULTADO_CARTER');
    IF @var6 IS NOT NULL EXEC(N'ALTER TABLE [TEMPO_CONCENTRACAO] DROP CONSTRAINT [' + @var6 + '];');
    EXEC(N'UPDATE [TEMPO_CONCENTRACAO] SET [DB_RESULTADO_CARTER] = 0.0E0 WHERE [DB_RESULTADO_CARTER] IS NULL');
    ALTER TABLE [TEMPO_CONCENTRACAO] ALTER COLUMN [DB_RESULTADO_CARTER] float NOT NULL;
    ALTER TABLE [TEMPO_CONCENTRACAO] ADD DEFAULT 0.0E0 FOR [DB_RESULTADO_CARTER];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230617032151_indicecaracterizacao')
BEGIN
    DECLARE @var7 sysname;
    SELECT @var7 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TEMPO_CONCENTRACAO]') AND [c].[name] = N'DB_DECLIVIDADE_BACIA');
    IF @var7 IS NOT NULL EXEC(N'ALTER TABLE [TEMPO_CONCENTRACAO] DROP CONSTRAINT [' + @var7 + '];');
    EXEC(N'UPDATE [TEMPO_CONCENTRACAO] SET [DB_DECLIVIDADE_BACIA] = 0.0E0 WHERE [DB_DECLIVIDADE_BACIA] IS NULL');
    ALTER TABLE [TEMPO_CONCENTRACAO] ALTER COLUMN [DB_DECLIVIDADE_BACIA] float NOT NULL;
    ALTER TABLE [TEMPO_CONCENTRACAO] ADD DEFAULT 0.0E0 FOR [DB_DECLIVIDADE_BACIA];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230617032151_indicecaracterizacao')
BEGIN
    DECLARE @var8 sysname;
    SELECT @var8 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TEMPO_CONCENTRACAO]') AND [c].[name] = N'DB_COMPRIMENTO_RIO_PRINCIPAL');
    IF @var8 IS NOT NULL EXEC(N'ALTER TABLE [TEMPO_CONCENTRACAO] DROP CONSTRAINT [' + @var8 + '];');
    EXEC(N'UPDATE [TEMPO_CONCENTRACAO] SET [DB_COMPRIMENTO_RIO_PRINCIPAL] = 0.0E0 WHERE [DB_COMPRIMENTO_RIO_PRINCIPAL] IS NULL');
    ALTER TABLE [TEMPO_CONCENTRACAO] ALTER COLUMN [DB_COMPRIMENTO_RIO_PRINCIPAL] float NOT NULL;
    ALTER TABLE [TEMPO_CONCENTRACAO] ADD DEFAULT 0.0E0 FOR [DB_COMPRIMENTO_RIO_PRINCIPAL];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230617032151_indicecaracterizacao')
BEGIN
    DECLARE @var9 sysname;
    SELECT @var9 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TEMPO_CONCENTRACAO]') AND [c].[name] = N'DB_AREA_DRENAGEM');
    IF @var9 IS NOT NULL EXEC(N'ALTER TABLE [TEMPO_CONCENTRACAO] DROP CONSTRAINT [' + @var9 + '];');
    EXEC(N'UPDATE [TEMPO_CONCENTRACAO] SET [DB_AREA_DRENAGEM] = 0.0E0 WHERE [DB_AREA_DRENAGEM] IS NULL');
    ALTER TABLE [TEMPO_CONCENTRACAO] ALTER COLUMN [DB_AREA_DRENAGEM] float NOT NULL;
    ALTER TABLE [TEMPO_CONCENTRACAO] ADD DEFAULT 0.0E0 FOR [DB_AREA_DRENAGEM];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230617032151_indicecaracterizacao')
BEGIN
    CREATE TABLE [INDICE_CARACTERIZACAO_BH] (
        [ID] int NOT NULL IDENTITY,
        [DB_AREA_BACIA_HIDROGRAFICA] float NOT NULL,
        [DB_PERIMETRO] float NOT NULL,
        [DB_COMPRIMENTO_RIO_PRINCIPAL] float NOT NULL,
        [DB_COMPRIMENTO_VETORIAL] float NOT NULL,
        [DB_ALTITUDE_VETORIAL] float NOT NULL,
        [DB_ALTITUDE_MAXIMA_BACIA] float NOT NULL,
        [DB_ALTITUDE_ALTIMETRICA_BACIA_M] float NOT NULL,
        [DB_ALTITUDE_ALTIMETRICA_BACIA_KM] float NOT NULL,
        [DB_COMPRIMENTO_AXIAL_BACIA] float NOT NULL,
        [DB_RESULTADO_INDICE_CIRCULARIDADE] float NOT NULL,
        [DB_FATOR_FORMA] float NOT NULL,
        [DB_COEFICIENTE_COMPACIDADE] float NOT NULL,
        [DB_DENSIDADE_DRENAGEM] float NOT NULL,
        [DB_COEFICIENTE_MANUTENCAO] float NOT NULL,
        [DB_GRADIENTE_CANAIS] float NOT NULL,
        [DB_RELACAO_RELEVO] float NOT NULL,
        [DB_INDICE_RUGOSIDADE] float NOT NULL,
        [DB_SINUOSIDADE_CURSO_DAGUA] float NOT NULL,
        [INT_BARRAGEM_ID] int NOT NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_INDICE_CARACTERIZACAO_BH] PRIMARY KEY ([ID])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230617032151_indicecaracterizacao')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230617032151_indicecaracterizacao', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230812040241_CriacaoHidrologia')
BEGIN
    ALTER TABLE [INDICE_CARACTERIZACAO_BH] ADD [DB_ALTITUDE_MINIMA_BACIA] float NOT NULL DEFAULT 0.0E0;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230812040241_CriacaoHidrologia')
BEGIN
    ALTER TABLE [INDICE_CARACTERIZACAO_BH] ADD [DB_COMPRIMENTO_TOTAL_RIO] float NOT NULL DEFAULT 0.0E0;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230812040241_CriacaoHidrologia')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230812040241_CriacaoHidrologia', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230815185047_IncluirLarguraBarragem')
BEGIN
    CREATE TABLE [VAZAO_PICO] (
        [BarragemId] int NOT NULL,
        [ID] int NOT NULL IDENTITY,
        [DB_VHID] float NULL,
        [DB_HHID] float NULL,
        [DB_YMED] float NULL,
        [DB_AS] float NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_VAZAO_PICO] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_VAZAO_PICO_Barragem_BarragemId] FOREIGN KEY ([BarragemId]) REFERENCES [Barragem] ([ID]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230815185047_IncluirLarguraBarragem')
BEGIN
    CREATE INDEX [IX_VAZAO_PICO_BarragemId] ON [VAZAO_PICO] ([BarragemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230815185047_IncluirLarguraBarragem')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230815185047_IncluirLarguraBarragem', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230827192241_VolumeReservatorio')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230827192241_VolumeReservatorio', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230827192611_VolumeReservatorio2')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230827192611_VolumeReservatorio2', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230901001522_ContextoLatitudeLongitude')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230901001522_ContextoLatitudeLongitude', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230901005829_ContextoLatitudeLongitude2')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230901005829_ContextoLatitudeLongitude2', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230901011101_ContextoLatitudeLongitude3')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230901011101_ContextoLatitudeLongitude3', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230901011419_ContextoLatitudeLongitude4')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230901011419_ContextoLatitudeLongitude4', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230901012345_ContextoLatitudeLongitude5')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230901012345_ContextoLatitudeLongitude5', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230901013307_ContextoLatitudeLongitude6')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230901013307_ContextoLatitudeLongitude6', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230901013724_ContextoLatitudeLongitude7')
BEGIN
    ALTER TABLE [Barragem] ADD [STR_LATITUDE] nvarchar(50) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230901013724_ContextoLatitudeLongitude7')
BEGIN
    ALTER TABLE [Barragem] ADD [STR_LONGITUDE] nvarchar(50) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230901013724_ContextoLatitudeLongitude7')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230901013724_ContextoLatitudeLongitude7', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230904225443_Criacao2')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230904225443_Criacao2', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230904225604_Criacao3')
BEGIN
    DECLARE @var10 sysname;
    SELECT @var10 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AspNetUsers]') AND [c].[name] = N'USR_IDADE');
    IF @var10 IS NOT NULL EXEC(N'ALTER TABLE [AspNetUsers] DROP CONSTRAINT [' + @var10 + '];');
    ALTER TABLE [AspNetUsers] ALTER COLUMN [USR_IDADE] int NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230904225604_Criacao3')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230904225604_Criacao3', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230911012144_CategoriaRisco')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230911012144_CategoriaRisco', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230911012641_CategoriaRisco2')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230911012641_CategoriaRisco2', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230911015921_CategoriaRisco3')
BEGIN
    CREATE TABLE [CATEGORIA_RISCO] (
        [BarragemId] int NOT NULL,
        [ID] int NOT NULL IDENTITY,
        [INT_CT_A] int NOT NULL,
        [INT_CT_B] int NOT NULL,
        [INT_CT_C] int NOT NULL,
        [INT_CT_D] int NOT NULL,
        [INT_CT_E] int NOT NULL,
        [INT_EC_H] int NOT NULL,
        [INT_EC_I] int NOT NULL,
        [INT_EC_J] int NOT NULL,
        [INT_EC_L] int NOT NULL,
        [INT_PS_N] int NOT NULL,
        [INT_PS_O] int NOT NULL,
        [INT_PS_P] int NOT NULL,
        [INT_PS_Q] int NOT NULL,
        [INT_PS_R] int NOT NULL,
        [INT_VALOR_TOTAL] int NOT NULL,
        [INT_VALOR_TOTAL_EC] int NOT NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_CATEGORIA_RISCO] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_CATEGORIA_RISCO_Barragem_BarragemId] FOREIGN KEY ([BarragemId]) REFERENCES [Barragem] ([ID]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230911015921_CategoriaRisco3')
BEGIN
    CREATE INDEX [IX_CATEGORIA_RISCO_BarragemId] ON [CATEGORIA_RISCO] ([BarragemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230911015921_CategoriaRisco3')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230911015921_CategoriaRisco3', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230916224343_Hidrograma')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230916224343_Hidrograma', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230917003703_Hidrograma2')
BEGIN
    CREATE TABLE [HIDROGRAMA_PARABOLICO] (
        [BarragemId] int NOT NULL,
        [ID] int NOT NULL IDENTITY,
        [DB_VALOR_VAZAO] float NULL,
        [DB_QP] float NULL,
        [DB_TEMPO_HORA] float NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_HIDROGRAMA_PARABOLICO] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_HIDROGRAMA_PARABOLICO_Barragem_BarragemId] FOREIGN KEY ([BarragemId]) REFERENCES [Barragem] ([ID]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230917003703_Hidrograma2')
BEGIN
    CREATE TABLE [HIDROGRAMA_TRIANGULAR] (
        [BarragemId] int NOT NULL,
        [ID] int NOT NULL IDENTITY,
        [DB_VOLUMES_RESERVATORIO] float NULL,
        [DB_QP] float NULL,
        [DB_TEMPO_PICO] float NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_HIDROGRAMA_TRIANGULAR] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_HIDROGRAMA_TRIANGULAR_Barragem_BarragemId] FOREIGN KEY ([BarragemId]) REFERENCES [Barragem] ([ID]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230917003703_Hidrograma2')
BEGIN
    CREATE TABLE [TEMPO_RUPTURA] (
        [BarragemId] int NOT NULL,
        [ID] int NOT NULL IDENTITY,
        [DB_VALOR_TEMPO_RUPTURA] float NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_TEMPO_RUPTURA] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_TEMPO_RUPTURA_Barragem_BarragemId] FOREIGN KEY ([BarragemId]) REFERENCES [Barragem] ([ID]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230917003703_Hidrograma2')
BEGIN
    CREATE INDEX [IX_HIDROGRAMA_PARABOLICO_BarragemId] ON [HIDROGRAMA_PARABOLICO] ([BarragemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230917003703_Hidrograma2')
BEGIN
    CREATE INDEX [IX_HIDROGRAMA_TRIANGULAR_BarragemId] ON [HIDROGRAMA_TRIANGULAR] ([BarragemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230917003703_Hidrograma2')
BEGIN
    CREATE INDEX [IX_TEMPO_RUPTURA_BarragemId] ON [TEMPO_RUPTURA] ([BarragemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230917003703_Hidrograma2')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230917003703_Hidrograma2', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230922014758_BarragemIdRelation')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230922014758_BarragemIdRelation', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230922015620_BarragemIdRelation2')
BEGIN
    ALTER TABLE [VERTEDOURO] ADD [BarragemId] int NOT NULL DEFAULT 0;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230922015620_BarragemIdRelation2')
BEGIN
    ALTER TABLE [USO_BARRAGEM] ADD [BarragemId] int NOT NULL DEFAULT 0;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230922015620_BarragemIdRelation2')
BEGIN
    ALTER TABLE [TOMADA_DAGUA] ADD [BarragemId] int NOT NULL DEFAULT 0;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230922015620_BarragemIdRelation2')
BEGIN
    ALTER TABLE [TALUDE] ADD [BarragemId] int NOT NULL DEFAULT 0;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230922015620_BarragemIdRelation2')
BEGIN
    ALTER TABLE [SISTEMA_DRENAGEM] ADD [BarragemId] int NOT NULL DEFAULT 0;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230922015620_BarragemIdRelation2')
BEGIN
    ALTER TABLE [RESERVATORIO] ADD [BarragemId] int NOT NULL DEFAULT 0;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230922015620_BarragemIdRelation2')
BEGIN
    ALTER TABLE [INSTRUMENTOS] ADD [BarragemId] int NOT NULL DEFAULT 0;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230922015620_BarragemIdRelation2')
BEGIN
    ALTER TABLE [DESCARREGADOR_FUNDO] ADD [BarragemId] int NOT NULL DEFAULT 0;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230922015620_BarragemIdRelation2')
BEGIN
    ALTER TABLE [DADOS_GERAl] ADD [BarragemId] int NOT NULL DEFAULT 0;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230922015620_BarragemIdRelation2')
BEGIN
    ALTER TABLE [COTA_AREA_VOLUME] ADD [BarragemId] int NOT NULL DEFAULT 0;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230922015620_BarragemIdRelation2')
BEGIN
    ALTER TABLE [CARACTERIZACAO_AREA_JUSANTE] ADD [BarragemId] int NOT NULL DEFAULT 0;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230922015620_BarragemIdRelation2')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230922015620_BarragemIdRelation2', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230925023533_BarragemIdTipoEdificacao')
BEGIN
    ALTER TABLE [TIPO_EDIFICACAO] ADD [BarragemId] int NOT NULL DEFAULT 0;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230925023533_BarragemIdTipoEdificacao')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230925023533_BarragemIdTipoEdificacao', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230929013753_RotaFUga')
BEGIN
    CREATE TABLE [ROTA_FUGA] (
        [BarragemId] int NOT NULL,
        [ID] int NOT NULL IDENTITY,
        [STR_NOME] nvarchar(255) NULL,
        [STR_LATITUDE] nvarchar(50) NULL,
        [STR_LONGITUDE] nvarchar(50) NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_ROTA_FUGA] PRIMARY KEY ([ID])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230929013753_RotaFUga')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230929013753_RotaFUga', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231002023155_Ticket')
BEGIN
    CREATE TABLE [TICKET] (
        [ID] int NOT NULL IDENTITY,
        [STR_CODIDO] nvarchar(255) NULL,
        [STR_TITULO] nvarchar(255) NULL,
        [STR_DESCRICAO] nvarchar(255) NULL,
        [INT_STATUS] int NOT NULL,
        [INT_ID_USUARIO] int NOT NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_TICKET] PRIMARY KEY ([ID])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231002023155_Ticket')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231002023155_Ticket', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231005005647_PontoEncontro')
BEGIN
    CREATE TABLE [PONTO_ENCONTRO] (
        [BarragemId] int NOT NULL,
        [ID] int NOT NULL IDENTITY,
        [STR_NOME] nvarchar(255) NULL,
        [STR_LATITUDE] float NOT NULL,
        [STR_LONGITUDE] float NOT NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_PONTO_ENCONTRO] PRIMARY KEY ([ID])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231005005647_PontoEncontro')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231005005647_PontoEncontro', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231014042125_Tipo')
BEGIN
    CREATE TABLE [TIPO_EDIFICACAO_BARRAGEM] (
        [ID] int NOT NULL IDENTITY,
        [TipoEdificacaoId] int NOT NULL,
        [BarragemId] int NOT NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_TIPO_EDIFICACAO_BARRAGEM] PRIMARY KEY ([ID]),
        CONSTRAINT [FK_TIPO_EDIFICACAO_BARRAGEM_Barragem_BarragemId] FOREIGN KEY ([BarragemId]) REFERENCES [Barragem] ([ID]) ON DELETE CASCADE,
        CONSTRAINT [FK_TIPO_EDIFICACAO_BARRAGEM_TIPO_EDIFICACAO_TipoEdificacaoId] FOREIGN KEY ([TipoEdificacaoId]) REFERENCES [TIPO_EDIFICACAO] ([ID]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231014042125_Tipo')
BEGIN
    CREATE INDEX [IX_TIPO_EDIFICACAO_BARRAGEM_BarragemId] ON [TIPO_EDIFICACAO_BARRAGEM] ([BarragemId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231014042125_Tipo')
BEGIN
    CREATE INDEX [IX_TIPO_EDIFICACAO_BARRAGEM_TipoEdificacaoId] ON [TIPO_EDIFICACAO_BARRAGEM] ([TipoEdificacaoId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231014042125_Tipo')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231014042125_Tipo', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231016005005_NomeBarragem')
BEGIN
    ALTER TABLE [Barragem] ADD [STR_Nome] nvarchar(255) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231016005005_NomeBarragem')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231016005005_NomeBarragem', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231016193035_BarragemKml')
BEGIN
    CREATE TABLE [BARRAGEM_KML] (
        [BarragemId] int NOT NULL,
        [ID] int NOT NULL IDENTITY,
        [STR_COORDENADAS] nvarchar(max) NULL,
        [DT_DATA_CADASTRO] datetime2 NOT NULL,
        [DT_DATA_ALTERACAO] datetime2 NOT NULL,
        CONSTRAINT [PK_BARRAGEM_KML] PRIMARY KEY ([ID])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231016193035_BarragemKml')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231016193035_BarragemKml', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231105144247_CaracterizacaoUpdate')
BEGIN
    ALTER TABLE [CARACTERIZACAO_AREA_JUSANTE] DROP CONSTRAINT [FK_CARACTERIZACAO_AREA_JUSANTE_TIPO_EDIFICACAO_TipoEdificacaoId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231105144247_CaracterizacaoUpdate')
BEGIN
    DECLARE @var11 sysname;
    SELECT @var11 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CARACTERIZACAO_AREA_JUSANTE]') AND [c].[name] = N'TipoEdificacaoId');
    IF @var11 IS NOT NULL EXEC(N'ALTER TABLE [CARACTERIZACAO_AREA_JUSANTE] DROP CONSTRAINT [' + @var11 + '];');
    ALTER TABLE [CARACTERIZACAO_AREA_JUSANTE] ALTER COLUMN [TipoEdificacaoId] int NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231105144247_CaracterizacaoUpdate')
BEGIN
    DECLARE @var12 sysname;
    SELECT @var12 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CARACTERIZACAO_AREA_JUSANTE]') AND [c].[name] = N'INT_DISTANCIA');
    IF @var12 IS NOT NULL EXEC(N'ALTER TABLE [CARACTERIZACAO_AREA_JUSANTE] DROP CONSTRAINT [' + @var12 + '];');
    ALTER TABLE [CARACTERIZACAO_AREA_JUSANTE] ALTER COLUMN [INT_DISTANCIA] int NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231105144247_CaracterizacaoUpdate')
BEGIN
    DECLARE @var13 sysname;
    SELECT @var13 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CARACTERIZACAO_AREA_JUSANTE]') AND [c].[name] = N'DT_DATA_CADASTRO');
    IF @var13 IS NOT NULL EXEC(N'ALTER TABLE [CARACTERIZACAO_AREA_JUSANTE] DROP CONSTRAINT [' + @var13 + '];');
    ALTER TABLE [CARACTERIZACAO_AREA_JUSANTE] ALTER COLUMN [DT_DATA_CADASTRO] datetime2 NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231105144247_CaracterizacaoUpdate')
BEGIN
    DECLARE @var14 sysname;
    SELECT @var14 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CARACTERIZACAO_AREA_JUSANTE]') AND [c].[name] = N'DT_DATA_ALTERACAO');
    IF @var14 IS NOT NULL EXEC(N'ALTER TABLE [CARACTERIZACAO_AREA_JUSANTE] DROP CONSTRAINT [' + @var14 + '];');
    ALTER TABLE [CARACTERIZACAO_AREA_JUSANTE] ALTER COLUMN [DT_DATA_ALTERACAO] datetime2 NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231105144247_CaracterizacaoUpdate')
BEGIN
    DECLARE @var15 sysname;
    SELECT @var15 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CARACTERIZACAO_AREA_JUSANTE]') AND [c].[name] = N'BarragemId');
    IF @var15 IS NOT NULL EXEC(N'ALTER TABLE [CARACTERIZACAO_AREA_JUSANTE] DROP CONSTRAINT [' + @var15 + '];');
    ALTER TABLE [CARACTERIZACAO_AREA_JUSANTE] ALTER COLUMN [BarragemId] int NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231105144247_CaracterizacaoUpdate')
BEGIN
    ALTER TABLE [CARACTERIZACAO_AREA_JUSANTE] ADD CONSTRAINT [FK_CARACTERIZACAO_AREA_JUSANTE_TIPO_EDIFICACAO_TipoEdificacaoId] FOREIGN KEY ([TipoEdificacaoId]) REFERENCES [TIPO_EDIFICACAO] ([ID]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231105144247_CaracterizacaoUpdate')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231105144247_CaracterizacaoUpdate', N'7.0.4');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231216033055_ADDZONA')
BEGIN
    CREATE TABLE [ZONA] (
        [ID] int NOT NULL IDENTITY,
        [STR_ID_ZONA_NOME] nvarchar(255) NOT NULL,
        [STR_CPF] nvarchar(255) NOT NULL,
        [STR_ENDERECO] nvarchar(255) NOT NULL,
        [STR_NOME_CIDADAO] nvarchar(255) NOT NULL,
        [STR_NUMERO_TELEFONE] nvarchar(255) NOT NULL,
        [STR_NUMERO_PESSOAS] int NOT NULL,
        [STR_OBSERVACAO] nvarchar(255) NOT NULL,
        [STR_USUARIO] nvarchar(255) NOT NULL,
        [STR_RENDA] nvarchar(255) NOT NULL,
        [STR_AREA] nvarchar(255) NOT NULL,
        [dataNascimento] datetime2 NOT NULL,
        CONSTRAINT [PK_ZONA] PRIMARY KEY ([ID])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231216033055_ADDZONA')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231216033055_ADDZONA', N'7.0.4');
END;
GO

COMMIT;
GO

