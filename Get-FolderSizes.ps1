

param(
    [Parameter(Mandatory = $true)]
    [string]
    $FolderPath
)


$Folders = Get-ChildItem -Force $FolderPath -ErrorAction SilentlyContinue -Directory | Where-Object {$_.FullName -notin ("$env:SystemRoot","$env:SystemDrive\System Volume Information")} | ForEach-Object {
    $files = Get-ChildItem $_.FullName -Recurse -Force -ErrorAction SilentlyContinue | Select-Object @{Name = 'Size'; Expression = { $_.Length } }
    if ($files) {
        $FolderSize = [Linq.Enumerable]::Sum([Int64[]] $files.Size) / 1GB
    }
    [PSCustomObject]@{
        Folder     = $_.FullName
        "Size(GB)" = $FolderSize
    }
}

$Folders

