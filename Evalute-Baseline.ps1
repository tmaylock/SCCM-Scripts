[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $displayname
)

$baseline = Get-WmiObject  -Namespace root\ccm\dcm -Class SMS_DesiredConfiguration | Where-Object {$_.displayname -eq "$displayname"}
$baseline  | ForEach-Object {([wmiclass]"root\ccm\dcm:SMS_DesiredConfiguration").TriggerEvaluation($_.Name, $_.Version)}

