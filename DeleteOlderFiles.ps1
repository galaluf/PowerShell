#################################################################################################################################
# DeleteOlderFiles.ps1 - V_1.0 - 16/11/2017
# El siguente script busca archivos con mas de 30 días (CreationTime) en la ruta indicada y los elimina.
#################################################################################################################################

$servidor = 'BCBASV1128'

Invoke-Command -ComputerName $servidor {
    $historial = (Get-Date).AddDays(-30)
    $ruta = 'E:\Webciudad\Backup_Firewalls'

    # Eliminar archivos mas antiguos (fecha de creación) que $limit
    Get-ChildItem -Path $ruta -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $historial } | Remove-Item -Force
    # Eliminar carpetas vacías luego de haber eliminado archivos antiguos.
    Get-ChildItem -Path $ruta -Recurse -Force | Where-Object { $_.PSIsContainer -and (Get-ChildItem -Path $_.FullName -Recurse -Force | Where-Object { !$_.PSIsContainer }) -eq $null } | Remove-Item -Force -Recurse }

    Write-Host '0'

