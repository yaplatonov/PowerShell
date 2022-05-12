$Source = "C:\1C\MSSQL_backup"
$Destination = "\\nas\1c-backup$\MSSQL"
Get-ChildItem $Source -Recurse | ForEach {
    $ModifiedDestination = $($_.FullName).Replace("$Source","$Destination")
    If ((Test-Path $ModifiedDestination) -eq $False) {
        Copy-Item $_.FullName $ModifiedDestination
        }
    }