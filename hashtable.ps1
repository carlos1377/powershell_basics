# Hash Table
#[ordered] ordena a matriz
$servidores = [ordered]@{Server1 = "127.0.0.1"; Server2 = "127.0.0.2";Server3 = "127.0.0.3"}

#Adicionar
$servidores["Server4"] = "127.0.0.4"

#Remover
$servidores.Remove("Server4")

$servidores.Server1
$servidores

# Test-Connection $servidores - pinga pros servers

$servidores.Values