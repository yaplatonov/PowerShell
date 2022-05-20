$path = "F:\Архив\Новости\Новости 2018\Январь\10\"
$ffmpeg_exe = "F:\ffmpeg\ffmpeg.exe"
$ffmpeg_params = " -vf bwdif -c:v libx264 -preset fast -crf 17 -c:a aac -b:a 160k -r 25 "
$types = @("*.avi","*.m2p")

$log_file = $path + "logfile.txt"
If ((Test-Path $log_file) -eq $False) { New-Item -Path $log_file -ItemType "file" -Force }

### Get recursive files from folder in $path
Get-ChildItem -Path $path -Recurse -Force -Include $types |
     ForEach-Object {

       ### Обычный путь без пробелов и киррилицы
       #$ffmpeg_cmd = $ffmpeg_exe + " -i " + $_.FullName + $ffmpeg_params + $out_file
       ### Добавление кавычек для путей с пробелами
       $ffmpeg_cmd = $ffmpeg_exe + " -i " + '"' + $_.FullName + '"'  + $ffmpeg_params + '"' + $out_file + '"'
       #If outfile is already exists, delete
       If ((Test-Path $out_file) -eq $True) { Remove-Item $out_file -Force }
       
       ### Run
       cmd /c $ffmpeg_cmd
       

    ### Write some logs
    $log = (Get-Date -Format "MM/dd/yyyy HH:mm") + " " + $_.FullName + " converted."
    Write-Output $log >> $log_file
       Remove-Item $_.FullName -Force -Verbose
     }
