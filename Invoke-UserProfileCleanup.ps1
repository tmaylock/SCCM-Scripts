<#
.SYNOPSIS
    Cleans up user profiles
.DESCRIPTION
    Used to list and/or remove user profiles, either domain-based or orphaned and no longer on the domain. Can also list folder sizes, useful for cleaning up accounts no longer on the domain using disk space.

.EXAMPLE
    Invoke-UserProfileCleanup -Action List -UserType OrphanedDomain -GetFolderSize
    Invoke-UserProfileCleanup -Action Delete -UserType OrphanedDomain  
#>



param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('List', 'Delete')]
    [string]
    $Action,
    [Parameter()]
    [string]
    $sAMAccountName,
    [Parameter(Mandatory = $true)]
    [ValidateSet('Domain', 'OrphanedDomain', 'All')]
    [string]
    $UserType,
    [Parameter()]
    [bool]
    $GetFolderSize
)

#modify the first 3 * to match your domain sid
$domainsid = "S-1-5-21-*-*-*-*"
$output = @()
$domainusershash = @{}
$users = Get-CimInstance -Class Win32_UserProfile | Where-Object { $_.LocalPath -notlike "$($env:windir)\*" }
$domainusers = $users | Select-Object *, @{Name = 'sAMAccountName'; Expression = { ([ADSI]"LDAP://<SID=$($_.sid)>").sAMAccountName } } | Where-Object { $_.sAMAccountName }
$orphanedusers = $users | Select-Object *, @{Name = 'sAMAccountName'; Expression = { ([ADSI]"LDAP://<SID=$($_.sid)>").sAMAccountName } } | Where-Object { !$_.sAMAccountName -and ($_.sid -like "*$($domainusers[0].sid.split('-')[4])*" -or $_.sid -like $domainsid) }
$domainusers.foreach({ $domainusershash.Add($_.sid, $_.sAMAccountName) })

function Get-FolderSize {
    param(
        [Parameter()]
        $Account
    )
    $FolderSize = $null
    $files = Get-ChildItem $account.LocalPath -Recurse -Force -ErrorAction SilentlyContinue | Select-Object @{Name = 'Size'; Expression = { $_.Length } }
    if ($files) {
        $FolderSize = [Linq.Enumerable]::Sum([Int64[]] $files.Size) / 1GB
    }
    return $FolderSize
}

Function Get-Users {
    param(
        [Parameter()]
        $Users,
        [bool]$GetFolderSize
    )
    foreach ($user in $Users) {
        $account = $users | Where-Object { $_.sid -eq $user.sid }
        [PSCustomObject]@{
            LocalPath        = $account.LocalPath
            SID              = $account.SID
            "FolderSize(GB)" = if ($GetFolderSize) { Get-FolderSize -Account $account } 
        }
    }
}


switch ($Action) {
    "List" {     
        switch ($UserType) {
            "Domain" { 
                $output += Get-Users -Users $domainusers -GetFolderSize $GetFolderSize
                break
            }
            "OrphanedDomain" {
                $output += Get-Users -Users $orphanedusers -GetFolderSize $GetFolderSize
                break
            }
            "All" {
                $output += [PSCustomObject]@{
                    Domain         = Get-Users -Users $domainusers -GetFolderSize $GetFolderSize
                    OrphanedDomain = Get-Users -Users $orphanedusers -GetFolderSize $GetFolderSize
                }
            }
        }
        break 
    }
    "Delete" {
        switch ($UserType) {
            "Domain" {
                if ($sAMAccountName -eq '') {
                    Write-Output 'sAMAccountName(s) not specified for Domain User deletion'
                    break
                }
                foreach ($UserAccount in $sAMAccountName.Split(",")) {
                    $account = $users | Where-Object { $domainusershash["$($_.sid)"] -eq $UserAccount }
                    if ($account) {
                        if ($GetFolderSize) { $FolderSize = Get-FolderSize -Account $account }
                        try {
                            $account | Remove-CimInstance
                            $output += [PSCustomObject]@{
                                LocalPath        = $account.LocalPath
                                SID              = $account.SID
                                Status           = 'Success'
                                "FolderSize(GB)" = $FolderSize
                            }
                        }
                        catch {
                            $output += [PSCustomObject]@{
                                LocalPath        = $account.LocalPath
                                SID              = $account.SID
                                Status           = 'Failure'
                                "FolderSize(GB)" = $FolderSize
                            }
                        }
                    }
                }
                break
            }
            "OrphanedDomain" {
                if ($sAMAccountName) {
                    foreach ($UserAccount in $sAMAccountName.Split(",")) {
                        $account = $users | Where-Object { $_.localpath -eq "C:\Users\$UserAccount" }
                        if ($account) {
                            if ($GetFolderSize) { $FolderSize = Get-FolderSize -Account $account }
                            try {
                                $account | Remove-CimInstance
                                $output += [PSCustomObject]@{
                                    LocalPath        = $account.LocalPath
                                    SID              = $account.SID
                                    Status           = 'Success'
                                    "FolderSize(GB)" = $FolderSize 
                                }
                            }
                            catch {
                                $output += [PSCustomObject]@{
                                    LocalPath        = $account.LocalPath
                                    SID              = $account.SID
                                    Status           = 'Failure'
                                    "FolderSize(GB)" = $FolderSize 
                                }
                            }
                        }
                    }
                }
                else {
                    foreach ($user in $orphanedusers) {
                        $account = $users | Where-Object { $_.sid -eq $user.sid } 
                        if ($GetFolderSize) { $FolderSize = Get-FolderSize -Account $account }
                        try {
                            $account | Remove-CimInstance
                            $output += [PSCustomObject]@{
                                LocalPath        = $account.LocalPath
                                SID              = $account.SID
                                Status           = 'Success'
                                "FolderSize(GB)" = $FolderSize
                            }
                        }
                        catch {
                            $output += [PSCustomObject]@{
                                LocalPath        = $account.LocalPath
                                SID              = $account.SID
                                Status           = 'Failure'
                                "FolderSize(GB)" = $FolderSize
                            }
                        }
                    }
                }
            }
        }
    }
}

return $output



