# Speed up powershell
# Run as admin

$Env:PATH = [Runtime.InteropServices.RuntimeEnvironment]::GetRuntimeDirectory()
[AppDomain]::CurrentDomain.GetAssemblies() | % {
  $pt = $_.Location
  if (! $pt) {continue}
  if ($cn++) {''}
  $na = Split-Path -Leaf $pt
  Write-Host -ForegroundColor Yellow "NGENing $na"
  ngen install $pt
}

# Install Scoop

$ set-executionpolicy unrestricted -s cu
$ iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
$ scoop install 7zip coreutils curl git grep openssh sed wget vim grep ffmpeg
$ scoop install concfg
$ concfg import mountain
$ scoop install pshazz
$ pshazz use tonic

# Update all package

$ scoop update
$ scoop update *

# Start powershell with UTF-8 support
powershell.exe -NoExit /c "chcp.com 65001"