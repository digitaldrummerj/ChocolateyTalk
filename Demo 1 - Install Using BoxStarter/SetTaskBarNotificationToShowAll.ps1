[cmdletbinding()]
param(
	[parameter(ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
	[ValidateScript({Test-Path $_})]
	[string]$OutFolder = ".\"
)

begin {
}

process {

        Write-Host "Setting Taskbar Notification Area to show all icons."
        Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer -Name EnableAutoTray -Value 0
        Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer -Name EnableAutoTray -Value -
        Write-Host "Restarting Explorer"
        try{Stop-Process -processname explorer -Force -ErrorAction Stop | Out-Null} catch {}

}

end {}