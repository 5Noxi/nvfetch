$dir = "$env:localappdata\Noverse"
$dest = "$env:localappdata\Noverse\NVFetch.ps1"

if (!(Test-Path $dir)) { ni -ItemType Directory -Path $dir -Force | Out-Null }
mv "$home\Downloads\NVFetch.ps1" -Destination $dest -Force

if (!(Test-Path $profile)) { ni -ItemType File -Path $profile -Force | Out-Null }
ac $profile -Value "`nfunction nvfetch { & `"$dest`" @args }"

. $profile