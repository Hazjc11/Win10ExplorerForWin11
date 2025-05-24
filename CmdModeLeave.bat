@echo off
title Command Mode - Leaving and restarting
echo Please Wait...
::Sets everything back to normal
Reg Add HKEY_LOCAL_MACHINE\SYSTEM\Setup /v OOBEInProgress /t REG_DWORD /d 0 /f
Reg Add HKEY_LOCAL_MACHINE\SYSTEM\Setup /v SetupPhase /t REG_DWORD /d 0 /f
Reg Add HKEY_LOCAL_MACHINE\SYSTEM\Setup /v SetupType /t REG_DWORD /d 0 /f
rename C:\Windows\System32\oobe1 oobe
::Restart
echo Restarting windows...
shutdown -r -t 0
::stops the user from entering commands whilst waiting for system restart
:loop
set /p input=
goto loop