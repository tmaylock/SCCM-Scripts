$sls = Get-WmiObject -Query 'SELECT * FROM SoftwareLicensingService' 
@($sls).foreach({
    $_.InstallProductKey('keyhere')
    $_.RefreshLicenseStatus()
})
