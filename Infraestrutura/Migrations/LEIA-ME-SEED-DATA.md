# Script de Seed de Dados para SGSB-WEB

## Descrição

Este script insere dados de teste no banco de dados do SGSB-WEB, incluindo:

- **5 Barragens** (4 com os mesmos nomes do SGSB_INSP + Agua Fria II):
  1. Barragem do Rio Verde
  2. Barragem São Francisco
  3. Barragem do Peixe
  4. Barragem Nova Esperança
  5. Agua Fria II

- **4 registros em cada tabela principal**:
  - `INDICE_CARACTERIZACAO_BH` - Índice de Caracterização de Bacia Hidrográfica
  - `TEMPO_CONCENTRACAO` - Tempo de Concentração
  - `VAZAO_PICO` - Vazão de Pico
  - `RESERVATORIO` - Dados do Reservatório
  - `VERTEDOURO` - Dados do Vertedouro
  - `INSPECOES` - Dados de Inspeções
  - `INFORMACOES_COMPLEMENTARES` - Informações Complementares

## Como Executar

### Opção 1: Via SQL Server Management Studio (SSMS)

1. Abra o SQL Server Management Studio
2. Conecte-se ao servidor SQL Server onde está o banco `sgsb`
3. Abra o arquivo `SeedDataBarragens.sql`
4. Execute o script (F5)

### Opção 2: Via sqlcmd (Linha de Comando)

```powershell
# No diretório do SGSB-WEB
sqlcmd -S seu_servidor -d sgsb -i "SIstemaGestaoSegurancaBarragem-master\Infraestrutura\Migrations\SeedDataBarragens.sql"
```

### Opção 3: Via PowerShell (se configurado)

```powershell
# No diretório do SGSB-WEB
$connectionString = "Server=seu_servidor;Database=sgsb;Integrated Security=True;"
$script = Get-Content "SIstemaGestaoSegurancaBarragem-master\Infraestrutura\Migrations\SeedDataBarragens.sql" -Raw
Invoke-Sqlcmd -ConnectionString $connectionString -Query $script
```

## Verificação

Após executar o script, você pode verificar os dados inseridos:

```sql
-- Verificar barragens
SELECT ID, STR_Nome, STR_BACIA_HIDROGRAFICA_ABRANGENCIA, STR_CURSO_DAGUA_BARRADO 
FROM Barragem 
ORDER BY ID;

-- Verificar índices de caracterização
SELECT COUNT(*) as Total FROM INDICE_CARACTERIZACAO_BH;

-- Verificar tempo de concentração
SELECT COUNT(*) as Total FROM TEMPO_CONCENTRACAO;

-- Verificar vazão de pico
SELECT COUNT(*) as Total FROM VAZAO_PICO;
```

## Observações

- O script verifica se os dados já existem antes de inserir, evitando duplicações
- Se os tipos de material, estrutura ou fundação não existirem, eles serão criados automaticamente
- Os dados são vinculados às barragens através do `BarragemId` ou `INT_BARRAGEM_ID`
- As coordenadas (latitude/longitude) são baseadas nas localizações reais das barragens

## Estrutura dos Dados

### Barragens
- **Barragem do Rio Verde**: Patos de Minas, MG
- **Barragem São Francisco**: Três Marias, MG
- **Barragem do Peixe**: Araxá, MG
- **Barragem Nova Esperança**: Brumadinho, MG
- **Agua Fria II**: Nova localização

### Dados Hidrológicos
- Valores realistas para cálculos hidrológicos
- Áreas de bacia, perímetros, comprimentos de rios
- Altitudes mínimas e máximas
- Declividades e áreas de drenagem

## Próximos Passos

Após executar o script:
1. Verifique se todas as barragens aparecem no sistema
2. Teste os cálculos automáticos de caracterização
3. Verifique se os dados estão sendo exibidos corretamente nas telas
4. Teste a integração com o SGSB_INSP

