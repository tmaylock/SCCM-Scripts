[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $DriveLetter
)


Resume-BitLocker -MountPoint "$DriveLetter`:" -Confirm:$false
