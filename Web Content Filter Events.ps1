(Get-WinEvent -FilterHashtable @{logname='security'; id=4673} -MaxEvents 10).Message
(Get-WinEvent -FilterHashtable @{logname='Microsoft-Windows-Windows Defender/Operational'; id=1126} -MaxEvents 10).Message
