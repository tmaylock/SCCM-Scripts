ForEach ($r in (Get-ChildItem "REGISTRY::HKEY_USERS" | Where-Object { $_.Name -match "S-1-5-21" -and $_.Name -notmatch "_Classes" }))

{Get-ItemProperty "REGISTRY::$r\volatile Environment" -ErrorAction SilentlyContinue | select username,logonserver}
