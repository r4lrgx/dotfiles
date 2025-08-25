Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "wsl.exe -d FedoraLinux-42 bash -ic ""code .""", 0, False
WScript.Quit
