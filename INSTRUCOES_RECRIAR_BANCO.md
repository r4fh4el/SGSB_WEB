# Instruções para Recriar o Banco de Dados

## ⚠️ IMPORTANTE: Pare a API antes de executar os comandos

A API precisa estar **PARADA** para que as migrations possam ser aplicadas.

## Passo a Passo

### 1. Parar a API WebAPI
- Feche a aplicação WebAPI se estiver rodando
- Verifique no Gerenciador de Tarefas se há processos "WebAPI" ou "dotnet" rodando
- Encerre esses processos se necessário

### 2. Verificar a String de Conexão

A string de conexão atual está configurada em:
- `WebAPI/appsettings.json` (DefaultConnection)
- `Infraestrutura/Configuracoes/Contexto.cs` (hardcoded)

**String de Conexão Atual:**
```
Data Source=108.181.193.92,15000;Initial Catalog=sgsb;Persist Security Info=True;User ID=sa;Password=SenhaNova@123;TrustServerCertificate=true;MultipleActiveResultSets=True;Application Name=EntityFramework
```

### 3. Aplicar as Migrations

Abra o PowerShell ou Terminal e execute:

```powershell
cd "E:\Downloads\SGSB-FINAL\SIstemaGestaoSegurancaBarragem-master\WebAPI"
dotnet ef database update --project ..\Infraestrutura\Infraestrutura.csproj --startup-project WebAPI.csproj --context Infraestrutura.Configuracoes.Contexto
```

**OU** execute o script PowerShell criado:

```powershell
cd "E:\Downloads\SGSB-FINAL\SIstemaGestaoSegurancaBarragem-master"
.\RecriarBancoDados.ps1
```

### 4. Verificar se as Tabelas Foram Criadas

Após executar o comando, verifique no SQL Server Management Studio se as tabelas foram criadas:

```sql
USE sgsb;
GO

SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;
```

### 5. Reiniciar a API

Após aplicar as migrations com sucesso, você pode reiniciar a API.

## Alternativa: Recriar o Banco do Zero

Se você quiser **recriar o banco do zero** (apagando todas as tabelas existentes):

```powershell
cd "E:\Downloads\SGSB-FINAL\SIstemaGestaoSegurancaBarragem-master\WebAPI"

# Primeiro, apagar o banco (CUIDADO: isso apaga todos os dados!)
dotnet ef database drop --project ..\Infraestrutura\Infraestrutura.csproj --startup-project WebAPI.csproj --context Infraestrutura.Configuracoes.Contexto --force

# Depois, recriar o banco
dotnet ef database update --project ..\Infraestrutura\Infraestrutura.csproj --startup-project WebAPI.csproj --context Infraestrutura.Configuracoes.Contexto
```

## Solução de Problemas

### Erro: "Build failed"
- **Causa**: A API está rodando e bloqueando os arquivos DLL
- **Solução**: Pare a API completamente antes de executar os comandos

### Erro: "Cannot open database"
- **Causa**: O servidor SQL Server não está acessível ou a string de conexão está incorreta
- **Solução**: Verifique se o servidor está rodando e se a string de conexão está correta

### Erro: "Login failed"
- **Causa**: Credenciais incorretas ou usuário sem permissões
- **Solução**: Verifique o usuário e senha na string de conexão

## Tabelas Esperadas

O banco de dados deve conter as seguintes tabelas principais:
- AspNetUsers
- Barragem
- DanoPotencialAssociado
- TipoEstruturaBarragem
- DocumentacaoPerguntas
- TipoEmpreendedor
- CondicaoFundacao
- TipoMaterialBarragem
- TipoEdificacao
- E muitas outras...

Para ver todas as tabelas, consulte o arquivo `Infraestrutura/Configuracoes/Contexto.cs` onde estão definidos todos os `DbSet`.

