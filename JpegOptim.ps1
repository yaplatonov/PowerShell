$path = "D:\Shared folders\Work\vles\Белолипецкая\КОМПЬЮТЕР ДО 01.09.2019 ГОДА\фото охрана\"

# Delete files older than the $limit.
Get-ChildItem -Path $path -Recurse -Force -Include *.jpg |
     ForEach-Object { D:\temp\jpegoptim.exe -p  --strip-all --all-progressive -m85 -t $_.FullName }


