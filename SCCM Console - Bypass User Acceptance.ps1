$RegPath = "HKLM:\SOFTWARE\Microsoft\SMS\Client\Client Components\Remote Control"

Set-ItemProperty -Path $RegPath -Name "Permission Required" -Value "0"
