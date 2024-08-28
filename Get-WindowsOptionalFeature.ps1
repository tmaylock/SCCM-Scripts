param(
    [string]
    $FeatureName
)

if ($FeatureName) {
    Get-WindowsOptionalFeature -Online -FeatureName $FeatureName
}
else {
    Get-WindowsOptionalFeature -Online
}
