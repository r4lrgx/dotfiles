Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "wsl.exe -d FedoraLinux-42 -e codex .", 0, False
