
param(
    [Parameter(Mandatory = $true)]
    [string]
    $DomainController
)


$service = Get-Service -Name W32Time
$date = "{0:u}" -f $(Get-date).ToUniversalTime()
if ($Service.StartType -notin ("Manual","Automatic")){
    Set-Service -Name W32Time -StartupType Manual
    $newservice = Get-Service -Name W32Time
}

$source = w32tm /query /source

if ($source -notlike "*$DomainController*"){
    $config = w32tm /config /syncfromflags:domhier /update
    Start-Sleep -Seconds 10
    $newsource = w32tm /query /source
    $newdate = "{0:u}" -f $(Get-date).ToUniversalTime()

}

$timeconfig = [PSCustomObject]@{
    StartType = $Service.StartType
    Source = $Source
    Date = $date
    NewStartType = $newservice.StartType
    NewSource = $newsource
    NewDate = $newdate
    Config = $config
    
}

return $timeconfig
