#!/bin/pwsh
# The script syncs 1password-stored config locally using op-cli
[CmdletBinding()]
param (
  [parameter(mandatory = $true)][ValidatePattern('environments')][string]$envPath,
  [parameter(mandatory = $true)][ValidateSet("tf","ansible")][string]$tool,
  [parameter(mandatory = $false)][string]$opVaultId = "2jfk34wggoygq5bt5ip2fzl6iq",
  [parameter(mandatory = $false)][string]$encoding = "utf8"
)

# making sure op cli is present
if (-not  $(op --version)) {
  Write-Error "1password 'op' cli not installed"
  Exit
}

# get environment name
$envFound = $false
foreach ($i in $($envPath -split '[\\/]')) {
  if ($envFound) {$env = $i; break}
  if (($i -eq 'environments') -and $(-not $envFound)) {$envFound = $true}
}

if ($env -ne "v_env") {
  # build op item name
  $opItemName = "cfg-env-$env-$tool"
}

# defile config file path
switch ($tool) {
  "tf" {$configFileName = "terraform.tfvars"}
  "ansible" {$configFileName = Join-Path -Path "vars" -ChildPath "main.yml"}
}
$configFilePath = Join-Path -Path $envPath -ChildPath $configFileName
 
# get the config
$config = (op item get $opItemName --vault $opVaultId --format json | ConvertFrom-Json).fields.value

# write the config to the file
$config | Out-File -Filepath $configFilePath -Encoding $encoding

if (Test-Path $configFilePath) {
  Write-Output "Successfully written: $configFilePath"
}
else {
  Write-Error "Failed to write: $configFilePath"
}