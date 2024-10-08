

param(
    [Parameter(Mandatory = $true)]
    [string]
    $RuleName,
    [Parameter(Mandatory = $true)]
    [string]
    $ProgramPath,
    [Parameter(Mandatory = $true)]
    [ValidateSet('Inbound', 'Outbound')]
    [string]
    $Direction = 'Inbound',
    [Parameter(Mandatory = $true)]
    [ValidateSet('Allow', 'Block')]
    [string]
    $Action = 'Allow'
)

$output = @()

'UDP', 'TCP' | ForEach-Object { 
    
    try {
        $rule = New-NetFirewallRule -DisplayName $RuleName -Direction $Direction -Profile Any -Program $ProgramPath -Action $Action -Protocol $_
        $status = 'Success'
    }
    catch {
        $status = 'Failure'

    }

    $output += [PSCustomObject]@{
        RuleName  = $RuleName
        Direction = $Direction
        Program   = $ProgramPath
        Protocol  = $_
        Status    = $Status
        Rule      = $rule
    }

}

return $output


