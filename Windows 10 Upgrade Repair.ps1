Invoke-WmiMethod -Namespace root\CCM -Class SMS_Client -Name SetClientProvisioningMode -ArgumentList $False

Set-Service smstsmgr -StartupType Manual -Confirm:$false
