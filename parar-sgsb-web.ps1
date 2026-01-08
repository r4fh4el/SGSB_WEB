# Script para parar o SGSB-WEB (WebAPI + SGSB.Web)
# Este script para os processos que estao rodando nas portas 5204 e 5000

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Parando SGSB-WEB" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Encontrar processos na porta 5204 (WebAPI)
$port5204 = Get-NetTCPConnection -LocalPort 5204 -ErrorAction SilentlyContinue
if ($port5204) {
    $pid5204 = $port5204.OwningProcess
    Write-Host "Encontrado processo na porta 5204 (PID: $pid5204)" -ForegroundColor Yellow
    try {
        Stop-Process -Id $pid5204 -Force -ErrorAction Stop
        Write-Host "✓ Processo WebAPI (PID: $pid5204) parado" -ForegroundColor Green
    }
    catch {
        Write-Host "⚠ Erro ao parar processo WebAPI: $_" -ForegroundColor Yellow
    }
}
else {
    Write-Host "Nenhum processo encontrado na porta 5204" -ForegroundColor Gray
}

# Encontrar processos na porta 5000 (SGSB.Web)
$port5000 = Get-NetTCPConnection -LocalPort 5000 -ErrorAction SilentlyContinue
if ($port5000) {
    $pid5000 = $port5000.OwningProcess
    Write-Host "Encontrado processo na porta 5000 (PID: $pid5000)" -ForegroundColor Yellow
    try {
        Stop-Process -Id $pid5000 -Force -ErrorAction Stop
        Write-Host "✓ Processo SGSB.Web (PID: $pid5000) parado" -ForegroundColor Green
    }
    catch {
        Write-Host "⚠ Erro ao parar processo SGSB.Web: $_" -ForegroundColor Yellow
    }
}
else {
    Write-Host "Nenhum processo encontrado na porta 5000" -ForegroundColor Gray
}

# Tambem tentar parar processos dotnet que possam estar rodando
Write-Host ""
Write-Host "Procurando processos dotnet relacionados..." -ForegroundColor Yellow
$dotnetProcesses = Get-Process -Name "dotnet" -ErrorAction SilentlyContinue | Where-Object {
    $_.CommandLine -like "*WebAPI*" -or 
    $_.CommandLine -like "*SGSB.Web*" -or
    $_.CommandLine -like "*5204*" -or
    $_.CommandLine -like "*5000*"
}

if ($dotnetProcesses) {
    foreach ($proc in $dotnetProcesses) {
        Write-Host "Parando processo dotnet (PID: $($proc.Id))" -ForegroundColor Yellow
        try {
            Stop-Process -Id $proc.Id -Force -ErrorAction Stop
            Write-Host "✓ Processo dotnet (PID: $($proc.Id)) parado" -ForegroundColor Green
        }
        catch {
            Write-Host "⚠ Erro ao parar processo: $_" -ForegroundColor Yellow
        }
    }
}
else {
    Write-Host "Nenhum processo dotnet relacionado encontrado" -ForegroundColor Gray
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "SGSB-WEB parado" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

