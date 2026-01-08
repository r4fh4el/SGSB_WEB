-- ============================================================================
-- SCRIPT DE SEED - DADOS DE TESTE PARA SGSB-WEB
-- Insere 4 barragens (mesmos nomes do SGSB_INSP + Agua Fria II)
-- e 4 registros em cada tabela principal
-- ============================================================================

USE sgsb;
GO

PRINT '';
PRINT '========================================';
PRINT 'Inserindo dados de teste no SGSB-WEB...';
PRINT '========================================';
PRINT '';

-- ============================================================================
-- BARRAGENS (4 registros + Agua Fria II = 5 total)
-- ============================================================================
IF NOT EXISTS (SELECT 1 FROM Barragem WHERE STR_Nome IN ('Barragem do Rio Verde', 'Barragem São Francisco', 'Barragem do Peixe', 'Barragem Nova Esperança', 'Agua Fria II'))
BEGIN
    DECLARE @TipoMaterialId INT = (SELECT TOP 1 ID FROM TIPO_MATERIAL_BARRAGEM);
    DECLARE @TipoEstruturaId INT = (SELECT TOP 1 ID FROM TIPO_ESTRUTURA_BARRAGEM);
    DECLARE @CondicaoFundacaoId INT = (SELECT TOP 1 ID FROM CONDICAO_FUNDACAO);
    
    -- Se não existirem os tipos, criar
    IF @TipoMaterialId IS NULL
    BEGIN
        INSERT INTO TIPO_MATERIAL_BARRAGEM (STR_NOME, DT_DATA_CADASTRO, DT_DATA_ALTERACAO)
        VALUES ('Terra/Enrocamento', GETDATE(), GETDATE());
        SET @TipoMaterialId = SCOPE_IDENTITY();
    END
    
    IF @TipoEstruturaId IS NULL
    BEGIN
        INSERT INTO TIPO_ESTRUTURA_BARRAGEM (STR_NOME, DT_DATA_CADASTRO, DT_DATA_ALTERACAO)
        VALUES ('Terra', GETDATE(), GETDATE());
        SET @TipoEstruturaId = SCOPE_IDENTITY();
    END
    
    IF @CondicaoFundacaoId IS NULL
    BEGIN
        INSERT INTO CONDICAO_FUNDACAO (STR_NOME, DT_DATA_CADASTRO, DT_DATA_ALTERACAO)
        VALUES ('Rocha Sã', GETDATE(), GETDATE());
        SET @CondicaoFundacaoId = SCOPE_IDENTITY();
    END
    
    INSERT INTO Barragem (
        STR_Nome,
        STR_LATITUDE,
        STR_LONGITUDE,
        STR_BACIA_HIDROGRAFICA_ABRANGENCIA,
        STR_CURSO_DAGUA_BARRADO,
        STR_ANO_CONCLUSAO,
        STR_IDADE_BARRAGEM,
        STR_TIPO_FUNDACAO,
        DB_ALTURA_MAXIMA,
        DB_COMPRIMENTO_COROAMENTO,
        DB_LARGURA_COROAMENTO_BARRAGEM,
        DB_COTA_COROAMENTO_BARRAGEM,
        Tipo_Material_Id,
        Tipo_Estrutura_Id,
        CondicaoFundacaoId,
        DT_DATA_CADASTRO,
        DT_DATA_ALTERACAO
    )
    VALUES
        ('Barragem do Rio Verde', '-18.5786', '-46.5181', 'Bacia do Alto Paranaíba', 'Rio Verde', '1990', '34', 'Rocha Sã', 45.0, 350.0, 10.0, 850.0, @TipoMaterialId, @TipoEstruturaId, @CondicaoFundacaoId, GETDATE(), GETDATE()),
        ('Barragem São Francisco', '-18.2075', '-45.2344', 'Bacia do São Francisco', 'Rio São Francisco', '1979', '45', 'Rocha Sã', 75.0, 2700.0, 15.0, 745.0, @TipoMaterialId, @TipoEstruturaId, @CondicaoFundacaoId, GETDATE(), GETDATE()),
        ('Barragem do Peixe', '-19.5933', '-46.9403', 'Bacia do Paraná', 'Rio do Peixe', '2008', '16', 'Rocha Alterada', 38.0, 180.0, 8.0, 720.0, @TipoMaterialId, @TipoEstruturaId, @CondicaoFundacaoId, GETDATE(), GETDATE()),
        ('Barragem Nova Esperança', '-20.1433', '-44.1997', 'Bacia do Paraopeba', 'Córrego Esperança', '2012', '12', 'Solo Residual', 28.0, 120.0, 6.0, 680.0, @TipoMaterialId, @TipoEstruturaId, @CondicaoFundacaoId, GETDATE(), GETDATE()),
        ('Agua Fria II', '-19.8500', '-47.2000', 'Bacia do Paranaíba', 'Rio Água Fria', '2015', '9', 'Rocha Sã', 42.0, 200.0, 9.0, 750.0, @TipoMaterialId, @TipoEstruturaId, @CondicaoFundacaoId, GETDATE(), GETDATE());
    
    PRINT '✓ 5 barragens inseridas.';
END
ELSE
BEGIN
    PRINT '⚠ Barragens já existem.';
END
GO

-- ============================================================================
-- INDICE_CARACTERIZACAO_BH (4 registros - 1 para cada uma das 4 primeiras barragens)
-- ============================================================================
IF NOT EXISTS (SELECT 1 FROM INDICE_CARACTERIZACAO_BH)
BEGIN
    INSERT INTO INDICE_CARACTERIZACAO_BH (
        INT_BARRAGEM_ID,
        DB_AREA_BACIA_HIDROGRAFICA,
        DB_PERIMETRO,
        DB_COMPRIMENTO_RIO_PRINCIPAL,
        DB_COMPRIMENTO_VETORIAL,
        DB_ALTITUDE_VETORIAL,
        DB_ALTITUDE_MINIMA_BACIA,
        DB_ALTITUDE_MAXIMA_BACIA,
        DB_ALTITUDE_ALTIMETRICA_BACIA_M,
        DB_ALTITUDE_ALTIMETRICA_BACIA_KM,
        DB_COMPRIMENTO_AXIAL_BACIA,
        DB_COMPRIMENTO_TOTAL_RIO,
        DB_RESULTADO_INDICE_CIRCULARIDADE,
        DB_FATOR_FORMA,
        DB_COEFICIENTE_COMPACIDADE,
        DB_DENSIDADE_DRENAGEM,
        DB_COEFICIENTE_MANUTENCAO,
        DB_GRADIENTE_CANAIS,
        DB_RELACAO_RELEVO,
        DB_INDICE_RUGOSIDADE,
        DB_SINUOSIDADE_CURSO_DAGUA,
        DT_DATA_CADASTRO,
        DT_DATA_ALTERACAO
    )
    SELECT 
        ID,
        1250.5,  -- Área da bacia
        180.2,   -- Perímetro
        45.8,    -- Comprimento rio principal
        38.5,    -- Comprimento vetorial
        120.0,   -- Altitude vetorial
        650.0,   -- Altitude mínima
        850.0,   -- Altitude máxima
        200.0,   -- Altitude altimétrica (m)
        0.2,     -- Altitude altimétrica (km)
        42.3,    -- Comprimento axial
        125.6,   -- Comprimento total rio
        0.48,    -- Índice circularidade
        0.65,    -- Fator forma
        1.35,    -- Coeficiente compacidade
        0.10,    -- Densidade drenagem
        2.5,     -- Coeficiente manutenção
        4.36,    -- Gradiente canais
        0.15,    -- Relação relevo
        0.25,    -- Índice rugosidade
        1.19,    -- Sinuosidade curso d'água
        GETDATE(),
        GETDATE()
    FROM Barragem
    WHERE STR_Nome IN ('Barragem do Rio Verde', 'Barragem São Francisco', 'Barragem do Peixe', 'Barragem Nova Esperança')
    AND ID NOT IN (SELECT INT_BARRAGEM_ID FROM INDICE_CARACTERIZACAO_BH);
    
    PRINT '✓ 4 registros de Índice de Caracterização inseridos.';
END
ELSE
BEGIN
    PRINT '⚠ Índice de Caracterização já existe.';
END
GO

-- ============================================================================
-- TEMPO_CONCENTRACAO (4 registros)
-- ============================================================================
IF NOT EXISTS (SELECT 1 FROM TEMPO_CONCENTRACAO)
BEGIN
    INSERT INTO TEMPO_CONCENTRACAO (
        DB_BARRAGEM_ID,
        DB_COMPRIMENTO_RIO_PRINCIPAL,
        DB_DECLIVIDADE_BACIA,
        DB_AREA_DRENAGEM,
        DB_RESULTADO_KIRPICH,
        DB_RESULTADO_CORPS_ENGINEERS,
        DB_RESULTADO_CARTER,
        DB_RESULTADO_DOOGE,
        DB_RESULTADO_VEN_TE_CHOW,
        DT_DATA_CADASTRO,
        DT_DATA_ALTERACAO
    )
    SELECT 
        ID,
        45.8,    -- Comprimento rio principal
        0.025,   -- Declividade bacia
        1250.5,  -- Área drenagem
        2.35,    -- Resultado Kirpich
        2.18,    -- Resultado Corps Engineers
        1.95,    -- Resultado Carter
        3.42,    -- Resultado Dooge
        2.10,    -- Resultado Ven te Chow
        GETDATE(),
        GETDATE()
    FROM Barragem
    WHERE STR_Nome IN ('Barragem do Rio Verde', 'Barragem São Francisco', 'Barragem do Peixe', 'Barragem Nova Esperança')
    AND ID NOT IN (SELECT DB_BARRAGEM_ID FROM TEMPO_CONCENTRACAO);
    
    PRINT '✓ 4 registros de Tempo de Concentração inseridos.';
END
ELSE
BEGIN
    PRINT '⚠ Tempo de Concentração já existe.';
END
GO

-- ============================================================================
-- VAZAO_PICO (4 registros)
-- ============================================================================
IF NOT EXISTS (SELECT 1 FROM VAZAO_PICO)
BEGIN
    INSERT INTO VAZAO_PICO (
        BarragemId,
        DB_VHID,
        DB_HHID,
        DB_YMED,
        DB_AS,
        DT_DATA_CADASTRO,
        DT_DATA_ALTERACAO
    )
    SELECT 
        ID,
        25000000.0,  -- Volume hidráulico (Vhid)
        45.0,        -- Carga hidráulica máxima (Hhid)
        12.5,        -- Profundidade média (Ymed)
        120.0,       -- Área do reservatório (As)
        GETDATE(),
        GETDATE()
    FROM Barragem
    WHERE STR_Nome IN ('Barragem do Rio Verde', 'Barragem São Francisco', 'Barragem do Peixe', 'Barragem Nova Esperança')
    AND ID NOT IN (SELECT BarragemId FROM VAZAO_PICO);
    
    PRINT '✓ 4 registros de Vazão de Pico inseridos.';
END
ELSE
BEGIN
    PRINT '⚠ Vazão de Pico já existe.';
END
GO

-- ============================================================================
-- RESERVATORIO (4 registros)
-- ============================================================================
IF NOT EXISTS (SELECT 1 FROM RESERVATORIO WHERE BarragemId IN (SELECT ID FROM Barragem WHERE STR_Nome IN ('Barragem do Rio Verde', 'Barragem São Francisco', 'Barragem do Peixe', 'Barragem Nova Esperança')))
BEGIN
    INSERT INTO RESERVATORIO (
        BarragemId,
        DB_CAPACIDADE_TOTAL_RESERVATORIO,
        DB_VOLUME_UTIL_RESERVATORIO,
        DB_BORDA_LIVRE,
        DB_MAXIMO_MAXIMORUM,
        DB_MAXIMO_NORMAL,
        DB_MINIMO_OPERACIONAL,
        DB_VOLUME_MORTO,
        DT_DATA_CADASTRO,
        DT_DATA_ALTERACAO
    )
    SELECT 
        ID,
        25000000.0,  -- Capacidade total
        22000000.0,  -- Volume útil
        2.0,         -- Borda livre
        850.0,       -- Máximo maximorum
        845.0,       -- Máximo normal
        650.0,       -- Mínimo operacional
        3000000.0,   -- Volume morto
        GETDATE(),
        GETDATE()
    FROM Barragem
    WHERE STR_Nome IN ('Barragem do Rio Verde', 'Barragem São Francisco', 'Barragem do Peixe', 'Barragem Nova Esperança')
    AND ID NOT IN (SELECT BarragemId FROM RESERVATORIO);
    
    PRINT '✓ 4 registros de Reservatório inseridos.';
END
ELSE
BEGIN
    PRINT '⚠ Reservatório já existe.';
END
GO

-- ============================================================================
-- VERTEDOURO (4 registros)
-- ============================================================================
IF NOT EXISTS (SELECT 1 FROM VERTEDOURO WHERE BarragemId IN (SELECT ID FROM Barragem WHERE STR_Nome IN ('Barragem do Rio Verde', 'Barragem São Francisco', 'Barragem do Peixe', 'Barragem Nova Esperança')))
BEGIN
    INSERT INTO VERTEDOURO (
        BarragemId,
        STR_TIPO_ESTRUTURA_EXTRAVASORA,
        BOOL_VERTEDOURO_CONTROLE,
        INT_QUANTIDADE_COMPORTA,
        BOOL_TIPO_ACIONAMENTO_COMPORTAS,
        STR_LOCALIZACAO,
        DB_COMPRIMENTO_TOTAL_VERTEDOURO,
        DB_LARGURA_TOTAL_VERTEDOURO,
        DB_ALTURA,
        DB_COTA_SOLEIRO,
        BOOL_VETEDOURO_AUXILIAR,
        DB_TEMPO_RETORNO_VAZAO,
        DB_VAZAO,
        STR_MODALIDADE_DISSIPACAO_ENERGIA,
        DT_DATA_CADASTRO,
        DT_DATA_ALTERACAO
    )
    SELECT 
        ID,
        'Livre',     -- Tipo estrutura extravasora
        0,           -- Vertedouro controle
        0,           -- Quantidade comporta
        0,           -- Tipo acionamento comportas
        'Lado direito',  -- Localização
        50.0,        -- Comprimento total
        10.0,        -- Largura total
        5.0,         -- Altura
        845.0,       -- Cota soleiro
        0,           -- Vertedouro auxiliar
        1000,        -- Tempo retorno vazão
        1500.0,      -- Vazão
        'Bacia de dissipação',  -- Modalidade dissipação energia
        GETDATE(),
        GETDATE()
    FROM Barragem
    WHERE STR_Nome IN ('Barragem do Rio Verde', 'Barragem São Francisco', 'Barragem do Peixe', 'Barragem Nova Esperança')
    AND ID NOT IN (SELECT BarragemId FROM VERTEDOURO);
    
    PRINT '✓ 4 registros de Vertedouro inseridos.';
END
ELSE
BEGIN
    PRINT '⚠ Vertedouro já existe.';
END
GO

-- ============================================================================
-- INSPECOES (4 registros)
-- ============================================================================
IF NOT EXISTS (SELECT 1 FROM INSPECOES WHERE BarragemId IN (SELECT ID FROM Barragem WHERE STR_Nome IN ('Barragem do Rio Verde', 'Barragem São Francisco', 'Barragem do Peixe', 'Barragem Nova Esperança')))
BEGIN
    INSERT INTO INSPECOES (
        BarragemId,
        STR_NOME_SETOR,
        STR_FREQUENCIA,
        DT_DATA_ULTIMA_INSPECAO_ESPECIAL,
        DT_DATA_REVISAO_PERIODICA_RECENTE,
        BOOL_POSSUI_PAE,
        DT_DATA_PLANO_ACAO_EMERGENCIA,
        BOOL_POSSUI_ESTUDO_ROMPIMENTO,
        DT_DATA__ESTUDO_ROMPIMENTO,
        DT_DATA_CADASTRO,
        DT_DATA_ALTERACAO
    )
    SELECT 
        ID,
        'Setor de Segurança',  -- Nome setor
        'Mensal',              -- Frequência
        DATEADD(MONTH, -3, GETDATE()),  -- Data última inspeção especial
        DATEADD(MONTH, -1, GETDATE()),   -- Data revisão periódica recente
        1,                     -- Possui PAE
        DATEADD(YEAR, -1, GETDATE()),    -- Data plano ação emergência
        1,                     -- Possui estudo rompimento
        DATEADD(YEAR, -2, GETDATE()),    -- Data estudo rompimento
        GETDATE(),
        GETDATE()
    FROM Barragem
    WHERE STR_Nome IN ('Barragem do Rio Verde', 'Barragem São Francisco', 'Barragem do Peixe', 'Barragem Nova Esperança')
    AND ID NOT IN (SELECT BarragemId FROM INSPECOES);
    
    PRINT '✓ 4 registros de Inspeções inseridos.';
END
ELSE
BEGIN
    PRINT '⚠ Inspeções já existem.';
END
GO

-- ============================================================================
-- INFORMACOES_COMPLEMENTARES (4 registros)
-- ============================================================================
IF NOT EXISTS (SELECT 1 FROM INFORMACOES_COMPLEMENTARES WHERE BarragemId IN (SELECT ID FROM Barragem WHERE STR_Nome IN ('Barragem do Rio Verde', 'Barragem São Francisco', 'Barragem do Peixe', 'Barragem Nova Esperança')))
BEGIN
    INSERT INTO INFORMACOES_COMPLEMENTARES (
        BarragemId,
        STR_NOME_SETOR,
        BOOL_TEM_OUTORGA_CONSTRUCAO,
        STR_NUMERO_PORTARIA_OUTORGA,
        BOOL_TEM_LICENCA_OPERACAO,
        STR_NUMERO_PORTARIA_LICENCA_OPERACAO,
        STR_VAZAO_MINIMA_RESTITUICAO_ANO,
        BOOL_TEM_VIGIA,
        BOOL_TEM_OPERADOR24,
        BOOL_TEM_EQUIPE_OPERACAO,
        BOOL_TEM_ESCRITORIO_LOCAL,
        BOOL_TEM_EDIFICACAO_LOCAL,
        BOOL_TEM_HISTORICO_INCIDENTE_ACIDENTE,
        STR_HISTORICO_INCIDENTE_ACIDENTE,
        INT_ANO_ULTIMA_REFORMA,
        DT_DATA_CADASTRO,
        DT_DATA_ALTERACAO
    )
    SELECT 
        ID,
        'Setor de Operação',
        1,                     -- Tem outorga construção
        'PORT-001/2020',       -- Número portaria outorga
        1,                     -- Tem licença operação
        'PORT-002/2021',       -- Número portaria licença
        '5.5',                 -- Vazão mínima restituição
        1,                     -- Tem vigia
        1,                     -- Tem operador 24h
        1,                     -- Tem equipe operação
        1,                     -- Tem escritório local
        1,                     -- Tem edificação local
        0,                     -- Tem histórico incidente
        NULL,                  -- Histórico incidente
        2020,                  -- Ano última reforma
        GETDATE(),
        GETDATE()
    FROM Barragem
    WHERE STR_Nome IN ('Barragem do Rio Verde', 'Barragem São Francisco', 'Barragem do Peixe', 'Barragem Nova Esperança')
    AND ID NOT IN (SELECT BarragemId FROM INFORMACOES_COMPLEMENTARES);
    
    PRINT '✓ 4 registros de Informações Complementares inseridos.';
END
ELSE
BEGIN
    PRINT '⚠ Informações Complementares já existem.';
END
GO

PRINT '';
PRINT '========================================';
PRINT 'Dados de teste inseridos com sucesso!';
PRINT '========================================';
PRINT '';

