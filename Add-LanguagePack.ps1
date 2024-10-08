param(
    # Language Code (en-US, zh-CN)
    [Parameter(Mandatory=$true)]
    [string]
    $Language
)

if (!(Test-Path "C:\windows\Temp\22621.1.220506-1250.ni_release_amd64fre_CLIENT_LOF_PACKAGES_OEM.iso")){
Copy-Item "\\dfs\share\ISO\SCCM\22621.1.220506-1250.ni_release_amd64fre_CLIENT_LOF_PACKAGES_OEM.iso" -Destination C:\windows\Temp -Force
}
$imagepath = "C:\windows\Temp\22621.1.220506-1250.ni_release_amd64fre_CLIENT_LOF_PACKAGES_OEM.iso"
$driveletter = (Mount-DiskImage -ImagePath $imagepath -StorageType ISO -PassThru | Get-Volume).DriveLetter

Add-WindowsPackage -Online -PackagePath "$($driveletter):\LanguagesAndOptionalFeatures\Microsoft-Windows-Client-Language-Pack_x64_$language.cab"

Add-WindowsCapability -Online -Name Language.Basic~~~$language~0.0.1.0 -Source "$($driveletter):\LanguagesAndOptionalFeatures"
Add-WindowsCapability -Online -Name Language.Handwriting~~~$language~0.0.1.0 -Source "$($driveletter):\LanguagesAndOptionalFeatures"
Add-WindowsCapability -Online -Name Language.OCR~~~$language~0.0.1.0 -Source "$($driveletter):\LanguagesAndOptionalFeatures"
Add-WindowsCapability -Online -Name Language.Speech~~~$language~0.0.1.0 -Source "$($driveletter):\LanguagesAndOptionalFeatures"
Add-WindowsCapability -Online -Name Language.TextToSpeech~~~$language~0.0.1.0 -Source "$($driveletter):\LanguagesAndOptionalFeatures"

Dismount-DiskImage -ImagePath $imagepath -Confirm:$false

Remove-Item "C:\windows\Temp\22621.1.220506-1250.ni_release_amd64fre_CLIENT_LOF_PACKAGES_OEM.iso" -Force


