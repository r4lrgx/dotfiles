$BaseShellPath = "Registry::HKEY_CLASSES_ROOT\Directory\Background\shell"
$TargetKeyName = "VSCode Fedora"

$ExistingVSCodeMenu = Get-ChildItem $BaseShellPath |
    Where-Object { $_.PSChildName -match "Code" -and (Test-Path "$($_.PSPath)\command") } |
    Select-Object -First 1

if ($ExistingVSCodeMenu) {
    $Props = Get-ItemProperty $ExistingVSCodeMenu.PSPath
    $OriginalName = $Props."(default)"
    if (-not $OriginalName) { $OriginalName = $ExistingVSCodeMenu.PSChildName }
    $OriginalIcon = $Props.Icon
} else {
    $OriginalName = "Open with Code"
    $OriginalIcon = $null
}

$NewName = "$OriginalName Fedora"

$NewMenuPath = "$BaseShellPath\$TargetKeyName"
$NewCommandPath = "$NewMenuPath\command"

function Install-Menu {
    Write-Host "VSCode context menu as '$TargetKeyName'..." -ForegroundColor Cyan

    if (Test-Path $NewMenuPath) {
        Remove-Item -Path $NewMenuPath -Recurse -Force
    }

    New-Item -Path $NewMenuPath -Force | Out-Null
    Set-ItemProperty -Path $NewMenuPath -Name "(default)" -Value $NewName

    if ($OriginalIcon) {
        Set-ItemProperty -Path $NewMenuPath -Name "Icon" -Value $OriginalIcon
    }

    New-Item -Path $NewCommandPath -Force | Out-Null
    Set-ItemProperty -Path $NewCommandPath -Name "(default)" -Value 'wscript.exe "C:\___windows\context\VSCodeFedora\VSCode.vbs"'

    Write-Host "Menu '$TargetKeyName' installed successfully." -ForegroundColor Green
}

function Uninstall-Menu {
    if (Test-Path $NewMenuPath) {
        Write-Host "Uninstalling context menu: '$TargetKeyName'..." -ForegroundColor Yellow
        Remove-Item -Path $NewMenuPath -Recurse -Force
        Write-Host "Menu '$TargetKeyName' uninstalled." -ForegroundColor Green
    } else {
        Write-Host "Menu '$TargetKeyName' is not installed." -ForegroundColor Gray
    }
}

if (Test-Path $NewMenuPath) {
    Write-Host "The context menu '$TargetKeyName' is already installed." -ForegroundColor Cyan
    $Choice = Read-Host "What do you want to do? [R]einstall / [D]einstall / [E]xit"

    switch ($Choice.ToUpper()) {
        "R" { Install-Menu }
        "D" { Uninstall-Menu }
        default { Write-Host "Exiting without changes." -ForegroundColor Gray }
    }
} else {
    $Install = Read-Host "No installed menu detected for '$TargetKeyName'. Do you want to install it? (Y/N)"
    if ($Install.ToUpper() -eq "Y") {
        Install-Menu
    } else {
        Write-Host "No action taken." -ForegroundColor Gray
    }
}
