# Script para parar o SGSB-FINAL
# Encerra os processos do WebAPI e SGSB.Web

Write-Host "Parando serviços do SGSB-FINAL..." -ForegroundColor Yellow

# Encontrar processos do dotnet que estão rodando os projetos
$webApiProcess = Get-Process | Where-Object { 
    $_.CommandLine -like "*WebAPI*" -and $_.CommandLine -like "*dotnet*" 
} | Select-Object -First 1

$sgsbWebProcess = Get-Process | Where-Object { 
    $_.CommandLine -like "*SGSB.Web*" -and $_.CommandLine -like "*dotnet*" 
} | Select-Object -First 1

# Tentar parar por porta (mais confiável)
$port5204 = Get-NetTCPConnection -LocalPort 5204 -ErrorAction SilentlyContinue | Select-Object -ExpandProperty OwningProcess -Unique
$port5000 = Get-NetTCPConnection -LocalPort 5000 -ErrorAction SilentlyContinue | Select-Object -ExpandProperty OwningProcess -Unique

$processesToStop = @()

if ($port5204) {
    $processesToStop += $port5204
    Write-Host "Encontrado processo na porta 5204 (WebAPI): PID $port5204" -ForegroundColor Gray
}

if ($port5000) {
    $processesToStop += $port5000
    Write-Host "Encontrado processo na porta 5000 (SGSB.Web): PID $port5000" -ForegroundColor Gray
}

if ($processesToStop.Count -gt 0) {
    Write-Host ""
    Write-Host "Parando processos..." -ForegroundColor Yellow
    foreach ($pid in $processesToStop) {
        try {
            Stop-Process -Id $pid -Force -ErrorAction SilentlyContinue
            Write-Host "  ✓ Processo $pid parado" -ForegroundColor Green
        } catch {
            Write-Host "  ⚠ Não foi possível parar o processo $pid" -ForegroundColor Yellow
        }
    }
    Write-Host ""
    Write-Host "Serviços parados!" -ForegroundColor Green
} else {
    Write-Host "Nenhum processo do SGSB-FINAL encontrado rodando." -ForegroundColor Yellow
}




