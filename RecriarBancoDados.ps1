# Script para recriar o banco de dados e aplicar todas as migrations
# Este script aplica todas as migrations do Entity Framework para recriar as tabelas

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  Script de Recriação do Banco de Dados" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# String de conexão
$connectionString = "Data Source=108.181.193.92,15000;Initial Catalog=sgsb;Persist Security Info=True;User ID=sa;Password=SenhaNova@123;TrustServerCertificate=true;MultipleActiveResultSets=True;Application Name=EntityFramework"

Write-Host "String de Conexão:" -ForegroundColor Yellow
Write-Host $connectionString -ForegroundColor Gray
Write-Host ""

# Verificar e parar processos que podem estar bloqueando os arquivos
Write-Host "Verificando processos que podem estar bloqueando os arquivos..." -ForegroundColor Yellow

$processesToStop = @()
$webApiProcesses = Get-Process -Name "WebAPI" -ErrorAction SilentlyContinue
if ($webApiProcesses) {
    $processesToStop += $webApiProcesses
    Write-Host "Processos WebAPI encontrados:" -ForegroundColor Yellow
    $webApiProcesses | ForEach-Object { Write-Host "  - PID: $($_.Id) - Nome: $($_.ProcessName)" -ForegroundColor Gray }
}

# Verificar processos dotnet que podem estar rodando a API
$dotnetProcesses = Get-Process -Name "dotnet" -ErrorAction SilentlyContinue | Where-Object {
    $_.Path -like "*WebAPI*" -or 
    (Get-WmiObject Win32_Process -Filter "ProcessId = $($_.Id)").CommandLine -like "*WebAPI*"
}
if ($dotnetProcesses) {
    $processesToStop += $dotnetProcesses
    Write-Host "Processos dotnet relacionados à WebAPI encontrados:" -ForegroundColor Yellow
    $dotnetProcesses | ForEach-Object { Write-Host "  - PID: $($_.Id) - Nome: $($_.ProcessName)" -ForegroundColor Gray }
}

if ($processesToStop.Count -gt 0) {
    Write-Host ""
    Write-Host "ATENÇÃO: Processos encontrados que podem bloquear os arquivos." -ForegroundColor Red
    Write-Host "Estes processos serão PARADOS automaticamente para permitir a aplicação das migrations." -ForegroundColor Yellow
    Write-Host ""
    
    foreach ($proc in $processesToStop) {
        try {
            Write-Host "Parando processo PID: $($proc.Id) - $($proc.ProcessName)..." -ForegroundColor Yellow
            Stop-Process -Id $proc.Id -Force -ErrorAction Stop
            Write-Host "  ✓ Processo parado com sucesso" -ForegroundColor Green
        } catch {
            Write-Host "  ✗ Erro ao parar processo: $_" -ForegroundColor Red
        }
    }
    
    Write-Host ""
    Write-Host "Aguardando 2 segundos para garantir que os arquivos foram liberados..." -ForegroundColor Yellow
    Start-Sleep -Seconds 2
    Write-Host ""
} else {
    Write-Host "Nenhum processo bloqueando encontrado. Prosseguindo..." -ForegroundColor Green
}

Write-Host ""

# Navegar para o diretório do projeto WebAPI
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$webApiPath = Join-Path $scriptPath "WebAPI"
$infraPath = Join-Path $scriptPath "Infraestrutura"

if (-not (Test-Path $webApiPath)) {
    Write-Host "ERRO: Diretório WebAPI não encontrado em: $webApiPath" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $infraPath)) {
    Write-Host "ERRO: Diretório Infraestrutura não encontrado em: $infraPath" -ForegroundColor Red
    exit 1
}

Set-Location $webApiPath
Write-Host "Diretório atual: $(Get-Location)" -ForegroundColor Gray
Write-Host ""

# Aplicar migrações usando Entity Framework
Write-Host "Aplicando migrações ao banco de dados..." -ForegroundColor Green
Write-Host "Isso pode levar alguns minutos..." -ForegroundColor Yellow
Write-Host ""

$infraProject = Join-Path $infraPath "Infraestrutura.csproj"
$webApiProject = "WebAPI.csproj"

try {
    dotnet ef database update --project $infraProject --startup-project $webApiProject --context Infraestrutura.Configuracoes.Contexto --verbose
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "================================================" -ForegroundColor Green
        Write-Host "  Migrações aplicadas com SUCESSO!" -ForegroundColor Green
        Write-Host "================================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "O banco de dados foi atualizado com todas as tabelas necessárias." -ForegroundColor Green
    } else {
        Write-Host ""
        Write-Host "================================================" -ForegroundColor Red
        Write-Host "  ERRO ao aplicar migrações" -ForegroundColor Red
        Write-Host "================================================" -ForegroundColor Red
        Write-Host ""
        Write-Host "Verifique os erros acima e tente novamente." -ForegroundColor Yellow
        Write-Host "Certifique-se de que:" -ForegroundColor Yellow
        Write-Host "  1. O servidor SQL Server está acessível" -ForegroundColor Yellow
        Write-Host "  2. A string de conexão está correta" -ForegroundColor Yellow
        Write-Host "  3. O usuário tem permissões para criar/alterar tabelas" -ForegroundColor Yellow
        exit 1
    }
} catch {
    Write-Host ""
    Write-Host "ERRO ao executar o comando: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""

