$limit = (Get-Date).AddDays(-31)
$path = "\\nas\scan"

# Delete files older than the $limit.
Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit } | ForEach-Object { Remove-Item $_.FullName -Force }

