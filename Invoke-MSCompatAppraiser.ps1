Start-ScheduledTask -TaskPath "\Microsoft\Windows\Application Experience"-TaskName "Microsoft Compatibility Appraiser" 
Get-Process CompatTelRunner | Wait-Process
Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000001}"
