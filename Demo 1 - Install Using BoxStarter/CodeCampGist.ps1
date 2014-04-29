$scriptDir = "c:\packages\" #$(Split-Path -parent $MyInvocation.MyCommand.Definition)

$showAllNotificationsInTaskBar = join-path -path "$scriptDir"  -childpath "SetTaskBarNotificationToShowAll.ps1"
& "$showAllNotificationsInTaskBar"


Enable-RemoteDesktop
Set-ExplorerOptions -showHidenFilesFoldersDrives -showProtectedOSFiles -showFileExtensions
Set-TaskbarSmall

cinst zoomit 
cinst notepadplusplus 
cinst NugetPackageExplorer 
cinst NuGet.CommandLine
cinst webpicommandline
# cinst TortoiseSVN 
# cinst GoogleChrome 

Install-ChocolateyPinnedTaskBarItem "$env:windir\system32\mstsc.exe"
Install-ChocolateyPinnedTaskBarItem "${env:SystemRoot}\system32\WindowsPowerShell\v1.0\powershell.exe"
Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe"
Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles(x86)}\Notepad++\notepad++.exe"
Install-ChocolateyPinnedTaskBarItem "${env:ChocolateyInstall}\lib\NugetPackageExplorer.3.8.0\NuGetPackageExplorer.exe"

#Install-ChocolateyVsixPackage LayoutsORama 'http://visualstudiogallery.msdn.microsoft.com/35966ad9-430f-4ad7-9186-4394b784e36c/file/53026/14/LayoutsORama.vsix'

#cinst MsSqlServer2012Express -source $scriptDir 

#cinst justin.vsextensions.2013 -source $scriptDir 

if ((test-path "HKLM:\Software\TortoiseSVN") -eq $false) {
 write-host -foregroundColor Red "Error: Could not find TortoiseProc.exe"
 return
}

$tortoiseKey = get-itemproperty "HKLM:\Software\TortoiseSVN"

if ($tortoiseKey -eq $null) {
 write-host -foregroundColor Red "Error: Could not find TortoiseProc.exe"
 return
}

$tortoise = join-path -path $tortoiseKey.Directory  -childpath "bin\svn.exe"



if ($tortoise -eq $null) {
 write-host -foregroundColor Red "Error: Could not find svn.exe"
 return
}

$commandLine = '$tortoise checkout http://svn.com/myrepo/myproject c:\projects --username justin'
Write-Host $commandLine
#iex "& $commandLine"


Write-Host "If you have made it here without errors, you should be setup and ready to hack on the apps."
Write-Warning "If you see any failures happen, you may want to reboot and continue to let installers catch up. This script is idempotent and will only apply changes that have not yet been applied."