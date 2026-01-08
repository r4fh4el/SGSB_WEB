-- Script para inserir dados iniciais necessários para o sistema
-- Execute este script após aplicar as migrations

USE sgsb;
GO

-- Inserir TipoMaterialBarragem se não existir
IF NOT EXISTS (SELECT 1 FROM TIPO_MATERIAL_BARRAGEM)
BEGIN
    INSERT INTO TIPO_MATERIAL_BARRAGEM (STR_NOME, DT_DATA_CADASTRO, DT_DATA_ALTERACAO)
    VALUES 
        ('Concreto', GETDATE(), GETDATE()),
        ('Terra/Enrocamento', GETDATE(), GETDATE()),
        ('Mista', GETDATE(), GETDATE());
END
GO

-- Inserir TipoEstruturaBarragem se não existir
IF NOT EXISTS (SELECT 1 FROM TIPO_ESTRUTURA_BARRAGEM)
BEGIN
    INSERT INTO TIPO_ESTRUTURA_BARRAGEM (STR_NOME, DT_DATA_CADASTRO, DT_DATA_ALTERACAO)
    VALUES 
        ('Gravidade', GETDATE(), GETDATE()),
        ('Contenção', GETDATE(), GETDATE()),
        ('Enrocamento', GETDATE(), GETDATE()),
        ('Terra', GETDATE(), GETDATE());
END
GO

-- Inserir CondicaoFundacao se não existir
IF NOT EXISTS (SELECT 1 FROM CONDICAO_FUNDACAO)
BEGIN
    INSERT INTO CONDICAO_FUNDACAO (STR_NOME, DT_DATA_CADASTRO, DT_DATA_ALTERACAO)
    VALUES 
        ('Rocha Sã', GETDATE(), GETDATE()),
        ('Rocha Alterada', GETDATE(), GETDATE()),
        ('Solo Residual', GETDATE(), GETDATE()),
        ('Solo Transportado', GETDATE(), GETDATE());
END
GO

-- Inserir uma barragem de exemplo se não existir
IF NOT EXISTS (SELECT 1 FROM BARRAGEM)
BEGIN
    DECLARE @TipoMaterialId INT = (SELECT TOP 1 ID FROM TIPO_MATERIAL_BARRAGEM);
    DECLARE @TipoEstruturaId INT = (SELECT TOP 1 ID FROM TIPO_ESTRUTURA_BARRAGEM);
    DECLARE @CondicaoFundacaoId INT = (SELECT TOP 1 ID FROM CONDICAO_FUNDACAO);
    
    INSERT INTO BARRAGEM (
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
        TIPO_MATERIAL_ID,
        TIPO_ESTRUTURA_ID,
        CONDICAO_FUNDACAO_ID,
        DT_DATA_CADASTRO,
        DT_DATA_ALTERACAO
    )
    VALUES (
        'Barragem Exemplo',
        '-14.91049614092632',
        '-40.57034143018902',
        'Bacia do Rio São Francisco',
        'Rio Exemplo',
        '2020',
        '4',
        'Rocha Sã',
        50.0,
        200.0,
        10.0,
        500.0,
        @TipoMaterialId,
        @TipoEstruturaId,
        @CondicaoFundacaoId,
        GETDATE(),
        GETDATE()
    );
END
GO

PRINT 'Dados iniciais inseridos com sucesso!';
GO

