@echo off
title Command Mode - Shutdown
echo Please Wait...
::Makes sure all the registry values stay the same
Reg Add HKEY_LOCAL_MACHINE\SYSTEM\Setup /v OOBEInProgress /t REG_DWORD /d 1 /f
Reg Add HKEY_LOCAL_MACHINE\SYSTEM\Setup /v SetupPhase /t REG_DWORD /d 4 /f
Reg Add HKEY_LOCAL_MACHINE\SYSTEM\Setup /v SetupType /t REG_DWORD /d 2 /f
::Shutdown
echo Shutting down windows...
shutdown -s -t 0
::stops the user from entering commands whilst waiting for system shutdown
:loop
set /p input=
goto loop