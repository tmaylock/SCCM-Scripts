Get-ChildItem "C:\Users\*\AppData\Local\Microsoft\Teams\previous\*" -Force -Recurse -ErrorAction SilentlyContinue | ForEach{Remove-Item $_.FullName -Recurse -Force}
