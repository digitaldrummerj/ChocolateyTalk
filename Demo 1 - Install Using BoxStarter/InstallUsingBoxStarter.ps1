$cred = Get-Credential amr\jpjames
Install-BoxstarterPackage -PackageName .\PackageInstallGist.ps1 -Credential $cred
