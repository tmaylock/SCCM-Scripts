
Start-Process -FilePath "cscript" -ArgumentList "c:\windows\system32\slmgr.vbs /ipk keyhere" -NoNewWindow -Wait
Start-Process -FilePath "cscript" -ArgumentList "c:\windows\system32\slmgr.vbs /ato" -NoNewWindow -Wait

