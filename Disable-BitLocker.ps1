$sysvolume =  Get-BitLockerVolume | Where-Object {$_.MountPoint -eq $env:SystemDrive}

Disable-BitLocker -MountPoint $sysvolume.MountPoint
