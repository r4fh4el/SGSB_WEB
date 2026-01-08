# Comandos para Testar a API

## 🚀 Serviços Rodando:
- **API WebAPI**: http://localhost:5204
- **Sistema Web**: http://localhost:5000 (ou porta configurada)
- **Swagger API**: http://localhost:5204/swagger

---

## 📋 TESTE 1: Listar Barragens (GET)

### Comando PowerShell:
```powershell
Invoke-RestMethod -Uri "http://localhost:5204/API/ListarBarragem" -Method Get -ContentType "application/json"
```

### Comando cURL (PowerShell):
```powershell
curl http://localhost:5204/API/ListarBarragem
```

### Comando cURL (Linux/Mac):
```bash
curl http://localhost:5204/API/ListarBarragem
```

### Resposta Esperada:
Lista de objetos Barragem em formato JSON

---

## 📋 TESTE 2: Listar Tipo Material Barragem (GET)

### Comando PowerShell:
```powershell
Invoke-RestMethod -Uri "http://localhost:5204/API/ListarTipoMaterialBarragem" -Method Get -ContentType "application/json"
```

### Comando cURL (PowerShell):
```powershell
curl http://localhost:5204/API/ListarTipoMaterialBarragem
```

### Comando cURL (Linux/Mac):
```bash
curl http://localhost:5204/API/ListarTipoMaterialBarragem
```

### Resposta Esperada:
Lista de tipos de material de barragem em formato JSON

---

## 📋 TESTE 3: Buscar Usuários (GET)

### Comando PowerShell:
```powershell
Invoke-RestMethod -Uri "http://localhost:5204/API/BuscarUsuarios" -Method Get -ContentType "application/json"
```

### Comando cURL (PowerShell):
```powershell
curl http://localhost:5204/API/BuscarUsuarios
```

### Comando cURL (Linux/Mac):
```bash
curl http://localhost:5204/API/BuscarUsuarios
```

### Resposta Esperada:
Lista de usuários (ApplicationUser) em formato JSON

---

## 🔍 TESTE BÔNUS: Verificar Swagger

Abra no navegador:
```
http://localhost:5204/swagger
```

---

## 📝 TESTE BÔNUS: Buscar Barragem por ID (GET)

### Comando PowerShell:
```powershell
# Substitua {id} pelo ID da barragem (exemplo: 1)
Invoke-RestMethod -Uri "http://localhost:5204/API/BuscarPorIdBarragem?id=1" -Method Get -ContentType "application/json"
```

### Comando cURL:
```powershell
curl "http://localhost:5204/API/BuscarPorIdBarragem?id=1"
```

---

## 🛠️ Comandos Úteis para Verificar Status

### Verificar se a API está rodando:
```powershell
Test-NetConnection -ComputerName localhost -Port 5204
```

### Ver processos dotnet rodando:
```powershell
Get-Process -Name "dotnet" | Where-Object {$_.Path -like "*WebAPI*" -or $_.Path -like "*SGSB.Web*"}
```

### Ver logs da API (se estiver rodando em terminal):
Os logs aparecerão no terminal onde você iniciou os serviços.

---

## ⚠️ Solução de Problemas

### Se os comandos retornarem erro de conexão:
1. Verifique se a API está rodando:
   ```powershell
   Get-Process -Name "dotnet" | Select-Object Id, ProcessName, Path
   ```

2. Verifique se a porta 5204 está em uso:
   ```powershell
   netstat -ano | findstr :5204
   ```

3. Reinicie a API se necessário:
   ```powershell
   # Pare os processos
   Get-Process -Name "dotnet" | Where-Object {$_.Path -like "*WebAPI*"} | Stop-Process -Force
   
   # Inicie novamente
   cd "E:\Downloads\SGSB-FINAL\SIstemaGestaoSegurancaBarragem-master\WebAPI"
   dotnet run
   ```

---

## 📚 Endpoints Disponíveis (Principais)

- `GET /API/ListarBarragem` - Lista todas as barragens
- `GET /API/BuscarPorIdBarragem?id={id}` - Busca barragem por ID
- `GET /API/ListarTipoMaterialBarragem` - Lista tipos de material
- `GET /API/BuscarUsuarios` - Lista usuários
- `POST /API/Logar?login={login}&senha={senha}` - Login de usuário
- `POST /API/CriarToken` - Criar token JWT

Para ver todos os endpoints, acesse: http://localhost:5204/swagger

