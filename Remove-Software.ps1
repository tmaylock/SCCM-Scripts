

[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $SoftwareCode
)


Start-Process MsiExec -ArgumentList "/x $softwarecode /qn /norestart /L*V `"C:\Windows\Temp\$($SoftwareCode)_uninstall.log`"" -Wait -NoNewWindow


