Start-Process "C:\Program Files\Windows Defender\MpCmdRun.exe" -ArgumentList "-wdenable" -Wait

Update-MpSignature -UpdateSource MMPC
