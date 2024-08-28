param(
[Parameter(Mandatory=$true)]
[ValidateSet("off","on")]
[string]
$Setting
)

Start-Process powercfg.exe -ArgumentList "/hibernate $Setting" -Wait -NoNewWindow

