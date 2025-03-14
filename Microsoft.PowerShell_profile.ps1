Invoke-Expression (& { (zoxide init powershell | Out-String) })

$env:PYTHONIOENCODING="utf-8"

Set-Alias -Name env -Value ./.venv/scripts/activate.ps1

function api()
{
    z api
    env
    nodemon --ext yml, py, json, .env --exec py server.py
}

function fe()
{
    z rep
    npm run start:devwin
}

function pystart()
{
    nodemon --exec py server.py
}

function vimapi()
{
    z api
    env
    lvim
}

function vimfe()
{
    z rep
    lvim
}

function dnvgit()
{
    z C:/repos/DnvPerformancePusher
    lazygit
}

function notes()
{
    z "c:/work notes"
    lvim To-do.md
}

function vo()
{
    param (
        [string]$inputText
    )
    if ($inputText)
    {
        $file = fzf -q $inputText
    }
    else
    {
        $file = fzf
    }
    if ($file) {
        lvim $file
    }
    else
    {
        Write-Warning "No file selected, aborting"
    }
}

function vd()
{
    param (
        [string]$dir,
        [string]$fileName,
        [switch]$o
    )

    # Capture all additional arguments
    $extraArgs = $args | Where-Object { $_ -match '^-' }

    # Check for any unexpected hyphen arguments
    foreach ($arg in $extraArgs) {
        if ($arg -ne '-d') {
            Write-Error "Invalid parameter: $arg. Only '-o' is allowed."
            return
        }
    }

    if ([string]::IsNullOrEmpty($dir))
    {
        Write-Host "No directory specified, aborting"
        return
    }

    if (Test-Path $dir)
    {
        Set-Location $dir
    }
    else
    {
        $output = z $dir -- $query 2>&1 
        if ($output -like "*No match found*")
        {
            Write-Warning "No directory found, aborting"
            return
        }
    }

    if ($o -and $fileName)
    {
        $path = Get-Location
        $windowsPath = $fileName -replace '/', '\'
        $fullPath = Join-Path $path $windowsPath
        if (-not (Test-Path $fullPath))
        {
            Write-Warning "File not found, aborting"
            return
        }
        lvim $fileName
    }
    elseif ($o -and -not $fileName)
    {
        lvim
    }
    else
    {
        vo($fileName)
    }
}

function mkdir()
{
    param (
        [string]$path
    )

    New-Item -ItemType Directory -Path $path
}

oh-my-posh init pwsh --config "C:\Users\Andrew Radcliffe\OneDrive - Voyager Worldwide (UK) Limited\Documents\clean-detailed.omp.json" | Invoke-Expression

Set-Alias lvim 'C:\Users\Andrew Radcliffe\.local\bin\lvim.ps1'

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

fastfetch
