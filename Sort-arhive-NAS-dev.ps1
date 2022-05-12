# Old limit
$limit = (Get-Date).AddDays(-31)
# Folders to search
$listsfolders = @(
    '\\nas\1c-backup$\MSSQL\pegas-erp'
    '\\nas\1c-backup$\MSSQL\ka'
    '\\nas\1c-backup$\MSSQL\1c-docs'
    )

$files = Get-ChildItem $listsfolders | Where-Object {!$_.PsIsContainer -and $_.LastWriteTime  -lt $limit }
 
# List Files which will be moved
### $files | Sort-Object

foreach ($file in $files)
{
# Get year and Month of the file
# I used LastWriteTime since this are synced files and the creation day will be the date when it was synced
$year = $file.LastWriteTime.Year.ToString()
$month = $file.LastWriteTime.Month.ToString()
 
# Set Directory Path
$Directory = $file.DirectoryName + "\" + $year + "\" + $month
###$Directory
# Create directory if it doesn't exsist
if (!(Test-Path $Directory))
{
 New-Item $directory -type directory
}
 
# Move File to new location
 $file | Move-Item -Destination $Directory
}