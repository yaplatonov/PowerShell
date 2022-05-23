$path = "D:\_Downloads\_del\"
$ffmpeg_exe = "D:\ffmpeg\ffmpeg.exe"
### Scale to 480p , Height -2 (on -1 got error "height not divisible by 2")
### Нужно максимально быстро и в плохом качестве сделать видео, что бы не воровали.
$ffmpeg_params = " -vf scale=-2:480 -c:v libx264 -preset ultrafast -crf 28 -c:a aac -b:a 128k  "

$types = @("*.avi","*.mkv","*.mp4")


$log_file = $path + "logfile.txt"
If ((Test-Path $log_file) -eq $False) { New-Item -Path $log_file -ItemType "file" -Force }

#Get files in folder path
Get-ChildItem -Path $path -Recurse -Force -Include $types |
  ForEach-Object {

    $out_file = $_.DirectoryName + "\общая\" + $_.BaseName + ".mp4"
       
    ### Обычный путь без пробелов и киррилицы
    #$ffmpeg_cmd = $ffmpeg_exe + " -i " + $_.FullName + $ffmpeg_params + $out_file
    ### Экранирование кавычек для путей с пробелами
    $ffmpeg_cmd = $ffmpeg_exe + " -i " + '"' + $_.FullName + '"'  + $ffmpeg_params + '"' + $out_file + '"'
    ## If outfile is already exists, delete
    If ((Test-Path $out_file) -eq $True) { Remove-Item $out_file -Force }
    #Write-Output $ffmpeg_cmd
    cmd /c $ffmpeg_cmd
    
    If ((Test-Path $out_file) -eq $True) {
        Remove-Item $_.FullName -Force -Verbose
        ### Write some logs
        $log = (Get-Date -Format "dd/MM/yyyy HH:mm") + " " + $_.FullName + " : converted."
        Write-Output $log >> $log_file
      }
    }