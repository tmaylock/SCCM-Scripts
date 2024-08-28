$properties = Get-ChildItem HKLM:\SOFTWARE\Microsoft\DusmSvc\Profiles -Recurse
$usercost = $Properties | Where-Object {$_.Property -eq "UserCost"}


foreach ($key in $usercost){

    $usercostkey = $key | Get-ItemProperty
    $adapterguid = $usercostkey.PSParentPath.split("\")[-1]
    if ($usercostkey.UserCost -eq 2){
    Get-NetAdapter | Where-Object {$_.interfaceguid -eq $adapterguid} | Select-Object InterfaceDescription
    }

    #if ($usercostkey.UserCost -eq 2){Set-ItemProperty $usercostkey.pspath -Value 0 -Force -Name UserCost}
    
}
