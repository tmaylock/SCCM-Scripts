Stop-Service wuauserv -Force -Confirm:$false
Stop-Service BITS -Force -Confirm:$false

Remove-Item C:\Windows\SoftwareDistribution\DataStore -Recurse -Force -Confirm:$false
Remove-Item C:\Windows\SoftwareDistribution\Download -Recurse -Force -Confirm:$false

cmd /c "sc.exe sdset bits D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)"
cmd /c "sc.exe sdset wuauserv D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)"

regsvr32.exe /s C:\Windows\system32\atl.dll
regsvr32.exe /s C:\Windows\system32\urlmon.dll
regsvr32.exe /s C:\Windows\system32\mshtml.dll
regsvr32.exe /s C:\Windows\system32\shdocvw.dll
regsvr32.exe /s C:\Windows\system32\browseui.dll
regsvr32.exe /s C:\Windows\system32\jscript.dll
regsvr32.exe /s C:\Windows\system32\vbscript.dll
regsvr32.exe /s C:\Windows\system32\scrrun.dll
regsvr32.exe /s C:\Windows\system32\msxml.dll
regsvr32.exe /s C:\Windows\system32\msxml3.dll
regsvr32.exe /s C:\Windows\system32\msxml6.dll
regsvr32.exe /s C:\Windows\system32\actxprxy.dll
regsvr32.exe /s C:\Windows\system32\softpub.dll
regsvr32.exe /s C:\Windows\system32\wintrust.dll
regsvr32.exe /s C:\Windows\system32\dssenh.dll
regsvr32.exe /s C:\Windows\system32\rsaenh.dll
regsvr32.exe /s C:\Windows\system32\gpkcsp.dll
regsvr32.exe /s C:\Windows\system32\sccbase.dll
regsvr32.exe /s C:\Windows\system32\slbcsp.dll
regsvr32.exe /s C:\Windows\system32\cryptdlg.dll
regsvr32.exe /s C:\Windows\system32\oleaut32.dll
regsvr32.exe /s C:\Windows\system32\ole32.dll
regsvr32.exe /s C:\Windows\system32\shell32.dll
regsvr32.exe /s C:\Windows\system32\initpki.dll
regsvr32.exe /s C:\Windows\system32\wuapi.dll
regsvr32.exe /s C:\Windows\system32\wuaueng.dll
regsvr32.exe /s C:\Windows\system32\wuaueng1.dll
regsvr32.exe /s C:\Windows\system32\wucltui.dll
regsvr32.exe /s C:\Windows\system32\wups.dll
regsvr32.exe /s C:\Windows\system32\wups2.dll
regsvr32.exe /s C:\Windows\system32\wuweb.dll
regsvr32.exe /s C:\Windows\system32\qmgr.dll
regsvr32.exe /s C:\Windows\system32\qmgrprxy.dll
regsvr32.exe /s C:\Windows\system32\wucltux.dll
regsvr32.exe /s C:\Windows\system32\muweb.dll
regsvr32.exe /s C:\Windows\system32\wuwebv.dll

Start-Service BITS
Start-Service wuauserv
