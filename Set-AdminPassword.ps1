param(
    [Parameter(Mandatory=$true)]
    [string]$Password
)


$adminSID = 'S-1-5-21-*-500'
$adminAccount = Get-LocalUser | Where-Object { $_.SID -like $adminSID }

if ($adminAccount) {
    try {
        $adminAccount | Set-LocalUser -Password ($Password | ConvertTo-SecureString -AsPlainText -Force)
        Write-Output "The password for $($adminaccount.name) has been set to '$Password'"
    }
    catch { $_.exception }
}
else {
    Write-Output 'The local administrator account could not be found.'
}

