# Alias
Set-Alias vim nvim
Set-Alias grep findstr
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'

#Install-Module -Name Terminal-Icons -Repository PSGallery -Force
Import-Module Terminal-Icons

#Install-Module -Name z -Force

$Env:LANG = 'ja_JP.UTF-8'

function openVS([string] $vs, [string] $sln)
{
  if (!$sln.EndsWith(".sln"))
  {
    Write-Output 'Please open a .sln file!!!'
    return
  }
  start $vs $sln
}
Set-Variable -Name "VS2022EXE" -Option Constant `
  -Value "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\devenv.exe"
function vs2022([string] $sln)
{
  openVS $VS2022EXE $sln
}

