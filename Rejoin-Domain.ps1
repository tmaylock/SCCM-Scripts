$user = ""
$password = ""
$securepass = $password | ConvertTo-SecureString -AsPlainText -Force
$creds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ($User, $securepass)
Test-ComputerSecureChannel -Repair -Credential $creds
