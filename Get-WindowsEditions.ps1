$current = dism /online /get-currentedition
$target = Get-WindowsEdition -Target -Online

[PSCustomObject]@{
    Current = $current[-2]
    Target = ($target |ConvertTo-Json |ConvertFrom-Json).Edition
}
