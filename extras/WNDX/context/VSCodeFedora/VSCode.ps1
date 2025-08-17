$SHELL_PATH = "Registry::HKEY_CLASSES_ROOT\Directory\Background\shell"

$VSC = Get-ChildItem $SHELL_PATH |
    Where-Object { $_.PSChildName -match "Code" -and (Test-Path "$($_.PSPath)\command") } |
    Select-Object -First 1

if ($VSC) {
    $Props = Get-ItemProperty $VSC.PSPath
    $NAME_KEY = $VSC.PSChildName
    $ACTION_KEY = $Props."(default)"
    $ACTION_ICON = $Props.Icon
} else {
    $NAME_KEY = "VSCode"
    $ACTION_KEY = "Open with Code"
    $ACTION_ICON = $null
}

$TARGET_NAME_KEY = "$NAME_KEY Fedora"
$TARGET_ACTION_KEY = "$ACTION_KEY Fedora"

$NEW_MENU_PATH = "$SHELL_PATH\$TARGET_NAME_KEY"
$NEW_CMD_PATH = "$NEW_MENU_PATH\command"

function Install-Menu {
    Write-Host "VSCode context menu as '$TARGET_NAME_KEY'..." -ForegroundColor Cyan

    if (Test-Path $NEW_MENU_PATH) {
        Remove-Item -Path $NEW_MENU_PATH -Recurse -Force
    }

    New-Item -Path $NEW_MENU_PATH -Force | Out-Null
    Set-ItemProperty -Path $NEW_MENU_PATH -Name "(default)" -Value $TARGET_ACTION_KEY

    if ($ACTION_ICON) {
        Set-ItemProperty -Path $NEW_MENU_PATH -Name "Icon" -Value $ACTION_ICON
    }

    New-Item -Path $NEW_CMD_PATH -Force | Out-Null
    Set-ItemProperty -Path $NEW_CMD_PATH -Name "(default)" -Value 'wscript.exe "C:\WNDX\context\VSCodeFedora\VSCode.vbs"'

    Write-Host "Menu '$TARGET_NAME_KEY' installed successfully." -ForegroundColor Green
}

function Uninstall-Menu {
    if (Test-Path $NEW_MENU_PATH) {
        Write-Host "Uninstalling context menu: '$TARGET_NAME_KEY'..." -ForegroundColor Yellow
        Remove-Item -Path $NEW_MENU_PATH -Recurse -Force
        Write-Host "Menu '$TARGET_NAME_KEY' uninstalled." -ForegroundColor Green
    } else {
        Write-Host "Menu '$TARGET_NAME_KEY' is not installed." -ForegroundColor Gray
    }
}

if (Test-Path $NEW_MENU_PATH) {
    Write-Host "The context menu '$TARGET_NAME_KEY' is already installed." -ForegroundColor Cyan
    $Choice = Read-Host "What do you want to do? [R]einstall / [D]einstall / [E]xit"

    switch ($Choice.ToUpper()) {
        "R" { Install-Menu }
        "D" { Uninstall-Menu }
        default { Write-Host "Exiting without changes." -ForegroundColor Gray }
    }
} else {
    $Install = Read-Host "No installed menu detected for '$TARGET_NAME_KEY'. Do you want to install it? (Y/N)"
    if ($Install.ToUpper() -eq "Y") {
        Install-Menu
    } else {
        Write-Host "No action taken." -ForegroundColor Gray
    }
}
