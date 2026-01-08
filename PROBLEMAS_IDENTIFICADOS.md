# Problemas Identificados na Recriação do Banco de Dados

## ⚠️ PROBLEMA PRINCIPAL: API em Execução

**Erro:** A API WebAPI está rodando (processo PID 10496) e está bloqueando os arquivos DLL, impedindo que o build e as migrations sejam executadas.

**Mensagem de Erro:**
```
The process cannot access the file '...\WebAPI\bin\Debug\net7.0\Infraestrutura.dll' 
because it is being used by another process. O arquivo é bloqueado por: "WebAPI (10496)"
```

### Solução Imediata:

1. **Parar a API WebAPI:**
   - Feche a aplicação WebAPI se estiver rodando no Visual Studio ou outro IDE
   - Verifique no Gerenciador de Tarefas (Ctrl+Shift+Esc) se há processos "WebAPI" ou "dotnet" rodando
   - Encerre esses processos se necessário

2. **Ou use o PowerShell para parar o processo:**
   ```powershell
   Stop-Process -Id 10496 -Force
   ```

3. **Ou pare todos os processos WebAPI:**
   ```powershell
   Get-Process -Name "WebAPI" -ErrorAction SilentlyContinue | Stop-Process -Force
   Get-Process -Name "dotnet" -ErrorAction SilentlyContinue | Where-Object {$_.Path -like "*WebAPI*"} | Stop-Process -Force
   ```

## ⚠️ PROBLEMA SECUNDÁRIO: Configuração de Serviços no Program.cs

**Problema:** Os repositórios estão registrados como `AddSingleton`, mas o `DbContext` está registrado como `AddDbContext` (que é Scoped por padrão). Isso pode causar problemas porque:

- `DbContext` deve ter escopo de requisição (Scoped)
- Singletons não podem injetar serviços Scoped diretamente
- Isso pode causar problemas de concorrência e vazamento de conexões

**Localização:** `WebAPI/Program.cs` linha 25 e linhas 46-88

**Solução Recomendada:**
Alterar os repositórios de `AddSingleton` para `AddScoped`:

```csharp
// ANTES (INCORRETO):
builder.Services.AddSingleton(typeof(IGenericos<>), typeof(RepositorioGenerico<>));
builder.Services.AddSingleton<IBarragem, RepositorioBarragem>();
// ... etc

// DEPOIS (CORRETO):
builder.Services.AddScoped(typeof(IGenericos<>), typeof(RepositorioGenerico<>));
builder.Services.AddScoped<IBarragem, RepositorioBarragem>();
// ... etc
```

## Passos para Recriar o Banco de Dados:

### 1. Parar a API
```powershell
# Verificar processos
Get-Process -Name "WebAPI","dotnet" -ErrorAction SilentlyContinue

# Parar processos WebAPI
Get-Process -Name "WebAPI" -ErrorAction SilentlyContinue | Stop-Process -Force
```

### 2. Aplicar as Migrations
```powershell
cd "E:\Downloads\SGSB-FINAL\SIstemaGestaoSegurancaBarragem-master\WebAPI"
dotnet ef database update --project ..\Infraestrutura\Infraestrutura.csproj --startup-project WebAPI.csproj --context Infraestrutura.Configuracoes.Contexto
```

### 3. Verificar se Funcionou
Após aplicar as migrations, você pode verificar se as tabelas foram criadas no SQL Server.

## String de Conexão Atual:

```
Data Source=108.181.193.92,15000;Initial Catalog=sgsb;Persist Security Info=True;User ID=sa;Password=SenhaNova@123;TrustServerCertificate=true;MultipleActiveResultSets=True;Application Name=EntityFramework
```

**Verifique:**
- Se o servidor SQL Server está acessível (108.181.193.92:15000)
- Se as credenciais estão corretas
- Se o banco de dados "sgsb" existe ou será criado automaticamente

