$path = "F:\Архив\Новости\Новости 2018\Январь\10\"
$ffmpeg_exe = "F:\ffmpeg\ffmpeg.exe"
$ffmpeg_params = " -vf bwdif -c:v libx264 -preset fast -crf 17 -c:a aac -b:a 160k -r 25 "

# Get recursive files from folder in $path
Get-ChildItem -Path $path -Recurse -Force -Include *.avi - |
     ForEach-Object {
       $log_file = $_.DirectoryName + "\logfile.txt"
       #Write-Output "Files are successfully created in $env:computername" >> $log_file
       $out_file = $_.DirectoryName + "\" + $_.BaseName + ".mp4"
       #Write-Output $log_file
       #Write-Output $out
        ### Обычный путь без пробелов и киррилицы
        #$ffmpeg_cmd = $ffmpeg_exe + " -i " + $_.FullName + $ffmpeg_params + $out_file
       ### Экранирование кавычек для путей с пробелами
       $ffmpeg_cmd = $ffmpeg_exe + " -i " + '"' + $_.FullName + '"'  + $ffmpeg_params + '"' + $out_file + '"'
       #If outfile is already exists, delete
       If ((Test-Path $out_file) -eq $True) {
        Remove-Item $out_file -Force
        }
       #Write-Output $ffmpeg_cmd
       cmd /c $ffmpeg_cmd
       #Write-Output $_.FullName
       Remove-Item $_.FullName -Force -Verbose
     }
