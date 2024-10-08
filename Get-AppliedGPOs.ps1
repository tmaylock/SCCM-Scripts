$appliedpolicies = @()
$policies = Get-WmiObject -Namespace "Root\rsop\computer" -Class RSOP_GPO  -Filter "accessdenied=False and enabled=True and filterAllowed=True"
foreach ($policy in $policies){
$linkenabled = (Get-WmiObject -Namespace "Root\rsop\computer" -Class RSOP_GPLink  -Filter "GPO = 'RSOP_GPO.id=`"$($policy.id)`"'").enabled 
if ($linkenabled -eq $true){$appliedpolicies += $policy}
}
$appliedpolicies.name | Sort-Object
