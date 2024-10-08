Param(
  [Parameter(Mandatory=$True)]
  [int]$port
)
Get-NetFirewallPortFilter | Where-Object {$_.localport -eq $port} | ForEach-Object {
  $_ | Get-NetFirewallRule | Select Displayname,Direction,Action
}
