Get-LocalUser | Where-Object { $_.SID -like 'S-1-5-21-*-500' } | Enable-LocalUser -Confirm:$false
