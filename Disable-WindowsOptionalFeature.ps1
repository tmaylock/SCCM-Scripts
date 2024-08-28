param(
    [Parameter(Mandatory=$true)]
    [string]
    $FeatureName
)

Disable-WindowsOptionalFeature -Online -NoRestart -FeatureName $FeatureName
