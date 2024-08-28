Set-ItemProperty HKLM:\SOFTWARE\Policies\Microsoft\office\16.0\common\officeupdate -Name updatebranch -Value 'Current'
Set-ItemProperty HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Updates -Name UpdateDetectionLastRunTime -Value $null
Start-ScheduledTask -TaskPath Microsoft\Office -TaskName "Office Automatic Updates 2.0"
Start-Sleep -Seconds 10
Invoke-CimMethod -Namespace root\ccm -ClassName SMS_Client -Name TriggerSchedule -Arguments @{sScheduleID = '{00000000-0000-0000-0000-000000000114}'}
