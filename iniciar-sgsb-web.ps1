# Script para iniciar o SGSB-WEB (WebAPI + SGSB.Web)
# Este script inicia ambos os projetos em processos separados

$ErrorActionPreference = "Continue"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Iniciando SGSB-WEB" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Obter o caminho base do script
$basePath = Split-Path -Parent $MyInvocation.MyCommand.Path
$webApiPath = Join-Path $basePath "WebAPI"
$sgsbWebPath = Join-Path $basePath "SGSB.Web"

Write-Host "Caminho base: $basePath" -ForegroundColor Gray
Write-Host "WebAPI: $webApiPath" -ForegroundColor Gray
Write-Host "SGSB.Web: $sgsbWebPath" -ForegroundColor Gray
Write-Host ""

# Verificar se os diretorios existem
if (-not (Test-Path $webApiPath)) {
    Write-Host "ERRO: Diretorio WebAPI nao encontrado: $webApiPath" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $sgsbWebPath)) {
    Write-Host "ERRO: Diretorio SGSB.Web nao encontrado: $sgsbWebPath" -ForegroundColor Red
    exit 1
}

# Verificar se o .NET SDK esta instalado
try {
    $dotnetVersion = dotnet --version
    Write-Host "✓ .NET SDK encontrado: $dotnetVersion" -ForegroundColor Green
}
catch {
    Write-Host "ERRO: .NET SDK nao encontrado. Instale o .NET SDK para continuar." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "1. Iniciando WebAPI na porta 5204..." -ForegroundColor Yellow
Write-Host "   Swagger: http://localhost:5204/swagger" -ForegroundColor Gray

# Iniciar WebAPI em background
$webApiCommand = "cd '$webApiPath'; Write-Host '========================================' -ForegroundColor Cyan; Write-Host 'SGSB-WEB - WebAPI' -ForegroundColor Cyan; Write-Host '========================================' -ForegroundColor Cyan; Write-Host ''; Write-Host 'Iniciando WebAPI...' -ForegroundColor Yellow; Write-Host 'Swagger: http://localhost:5204/swagger' -ForegroundColor Green; Write-Host 'API Base: http://localhost:5204/api' -ForegroundColor Green; Write-Host ''; dotnet run --urls 'http://localhost:5204'"

$webApiProcess = Start-Process powershell -ArgumentList @(
    "-NoExit",
    "-Command",
    $webApiCommand
) -PassThru

Write-Host "   ✓ WebAPI iniciando (PID: $($webApiProcess.Id))" -ForegroundColor Green

# Aguardar alguns segundos para a API iniciar
Write-Host ""
Write-Host "Aguardando API iniciar..." -ForegroundColor Yellow
Start-Sleep -Seconds 8

# Verificar se a API esta respondendo
$maxAttempts = 15
$attempt = 0
$apiReady = $false

while ($attempt -lt $maxAttempts -and -not $apiReady) {
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:5204/swagger" -UseBasicParsing -TimeoutSec 2 -ErrorAction SilentlyContinue
        if ($response.StatusCode -eq 200) {
            $apiReady = $true
            Write-Host "   ✓ WebAPI esta respondendo!" -ForegroundColor Green
        }
    }
    catch {
        $attempt++
        if ($attempt -lt $maxAttempts) {
            Write-Host "   Aguardando... ($attempt/$maxAttempts)" -ForegroundColor Gray
            Start-Sleep -Seconds 2
        }
    }
}

if (-not $apiReady) {
    Write-Host "   ⚠ Aviso: WebAPI pode nao estar pronta ainda. Continuando..." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "2. Iniciando SGSB.Web na porta 5000..." -ForegroundColor Yellow
Write-Host "   URL: http://localhost:5000" -ForegroundColor Gray

# Iniciar SGSB.Web em background
$sgsbWebCommand = "cd '$sgsbWebPath'; Write-Host '========================================' -ForegroundColor Cyan; Write-Host 'SGSB-WEB - Web Application' -ForegroundColor Cyan; Write-Host '========================================' -ForegroundColor Cyan; Write-Host ''; Write-Host 'Iniciando SGSB.Web...' -ForegroundColor Yellow; Write-Host 'URL: http://localhost:5000' -ForegroundColor Green; Write-Host 'API: http://localhost:5204' -ForegroundColor Green; Write-Host ''; dotnet run --urls 'http://localhost:5000'"

$sgsbWebProcess = Start-Process powershell -ArgumentList @(
    "-NoExit",
    "-Command",
    $sgsbWebCommand
) -PassThru

Write-Host "   ✓ SGSB.Web iniciando (PID: $($sgsbWebProcess.Id))" -ForegroundColor Green

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "SGSB-WEB iniciado com sucesso!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Aplicacao Web: http://localhost:5000" -ForegroundColor Green
Write-Host "API REST:      http://localhost:5204" -ForegroundColor Green
Write-Host "Swagger:       http://localhost:5204/swagger" -ForegroundColor Green
Write-Host ""
Write-Host "PIDs:" -ForegroundColor Yellow
Write-Host "  WebAPI:   $($webApiProcess.Id)" -ForegroundColor Gray
Write-Host "  SGSB.Web: $($sgsbWebProcess.Id)" -ForegroundColor Gray
Write-Host ""
Write-Host "=== Endpoints Importantes ===" -ForegroundColor Cyan
Write-Host "  Calculos Automaticos:" -ForegroundColor Yellow
Write-Host "    http://localhost:5204/API/BuscarCalculosAutomaticosPorBarragem?barragemId=1" -ForegroundColor Gray
Write-Host "  Tempo Concentracao:" -ForegroundColor Yellow
Write-Host "    http://localhost:5204/API/TempoConcentracao" -ForegroundColor Gray
Write-Host "  Indice Caracterizacao:" -ForegroundColor Yellow
Write-Host "    http://localhost:5204/API/IndiceCaracterizacaoBH" -ForegroundColor Gray
Write-Host "  Vazao Pico:" -ForegroundColor Yellow
Write-Host "    http://localhost:5204/API/VazaPico" -ForegroundColor Gray
Write-Host ""
Write-Host "Para parar os servicos, feche as janelas do PowerShell ou use:" -ForegroundColor Yellow
Write-Host "  Stop-Process -Id $($webApiProcess.Id),$($sgsbWebProcess.Id)" -ForegroundColor Gray
Write-Host ""

