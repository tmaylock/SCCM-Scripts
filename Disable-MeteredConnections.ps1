$properties = Get-ChildItem HKLM:\SOFTWARE\Microsoft\DusmSvc\Profiles -Recurse
$usercost = $Properties | Where-Object {$_.Property -eq "UserCost"}


foreach ($key in $usercost){

    $usercostkey = $key | Get-ItemProperty

    if ($usercostkey.UserCost -eq 2){
        Set-ItemProperty $usercostkey.pspath -Value 0 -Force -Name UserCost
        Get-Service DusmSvc | Restart-Service -Force -Confirm:$fase
    }
    
}
