Set-Service -Name CmRcService -StartupType Automatic -Force -Confirm:$false
Restart-Service -Name CmRcService -Force -Confirm:$false
