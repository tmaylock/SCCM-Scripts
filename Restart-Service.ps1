[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $Service
)

Restart-Service -Name $Service -Force
