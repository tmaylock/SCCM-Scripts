param (
[Parameter(Mandatory = $true)]
[ValidateSet("DomainAuthenticated","Private","Public")]
[string]
$NetworkCategory,
[Parameter(Mandatory = $true)]
[string]
$InterfaceAlias
)

Set-NetConnectionProfile -InterfaceAlias $InterfaceAlias -NetworkCategory $NetworkCategory
