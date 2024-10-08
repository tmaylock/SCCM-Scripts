$Session = New-Object -ComObject Microsoft.Update.Session 
$Searcher = $Session.CreateUpdateSearcher()
$HistoryCount = $Searcher.GetTotalHistoryCount()
$list = $Searcher.QueryHistory(0, $HistoryCount)

$updateslist = $list | Where-Object { 
    $_.ClientApplicationID -ne 'Windows Defender' `
        -and $_.Title -notlike '*Defender Antivirus*' `
        -and $_.ResultCode -eq 2 `
        -and $_.Operation -eq 1 `
        -and $_.serverselection -eq 1 `
        -and $_.HResult -eq 0
}

$updateslist
