$MachinePol = "$env:windir\system32\GroupPolicy\Machine"

$UserPol = "$env:windir\system32\GroupPolicy\User"

$RegPath = 'HKLM:\Software\Policies\Microsoft\Windows\BITS'


#Attempt to clear the local policy

Try
{

#delete the Machine (Computer) Policy folder
If (Test-Path $MachinePol) {Remove-Item -Path $MachinePol -Recurse -Confirm:$false -ErrorAction Stop}

#delete the User Policy folder
If (Test-Path $UserPol) {Remove-Item -Path $UserPol -Recurse -Confirm:$false -ErrorAction Stop} 

#Remove the BITS Policy reg key if it exists.
#If (Test-Path $RegPath) {Remove-Item -Path $RegPath -Recurse -Force -ErrorAction Stop -Confirm:$false}
& cmd /c "gpupdate /force"
}
#If anything went wrong - set the Exit code to 1
Catch {  EXIT 1}

Finally{}
