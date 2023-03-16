get-command -CommandType Cmdlet # cmdlets
get-command -CommandType function # funções
get-command -CommandType alias # aliases

Get-Command -CommandType Cmdlet | more # espera outro comando do usuário
Get-Command -CommandType Cmdlet *log* #especifica o comando pesquisado


set-alias limpar Clear-Host #cria um alias para o comando