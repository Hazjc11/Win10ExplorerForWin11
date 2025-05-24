@echo off
::Applies required registry changes
Reg Add HKEY_LOCAL_MACHINE\SYSTEM\Setup /v OOBEInProgress /t REG_DWORD /d 1 /f
Reg Add HKEY_LOCAL_MACHINE\SYSTEM\Setup /v SetupPhase /t REG_DWORD /d 4 /f
Reg Add HKEY_LOCAL_MACHINE\SYSTEM\Setup /v SetupType /t REG_DWORD /d 2 /f
Reg Add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableCursorSuppression /t REG_DWORD /d 0 /f
Reg Add "HKEY_LOCAL_MACHINE\SYSTEM\Setup" /v CmdLine /t REG_SZ /d "C:\Program Files (x86)\CmdMode\CmdMode.bat" /f
::Removes annoying fake loading screen in the background
cd C:\Windows\System32
rename oobe oobe1
::Restart
shutdown -r -t 0
exit