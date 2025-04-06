::Created by
::Hazjc11 on github.com
::@HazPlays-13 on Youtube.com
::Licensing information is available on this projects github page
::https://github.com/Hazjc11/Win10ExplorerForWin11/blob/main/LICENSE

@echo off
echo Before you continue, make sure to save any unsaved data
echo and make sure this window is running with administrator privilages
echo Enter the number for the script you want to execute
echo 1. Change to Windows 10 File Explorer
echo 2. Revert back to Windows 11 File Explorer
:enter_command
set /p input=
if /i %input%==1 goto 1
if /i %input%==2 goto 2
echo incorrect syntax, please enter a valid number for the script you want to execute (1 or 2)
goto enter_command

:1
takeown /f "Windows.Ui.FileExplorer.dll"
icacls "Windows.Ui.FileExplorer.dll" /grant %username%:F
taskkill /f /im explorer.exe
ren Windows.Ui.FileExplorer.dll Windows.Ui.FileExplorer.dll_disabled
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v UseCompactMode /t REG_DWORD /d 1 /f
goto complete

:2
echo Also disable compact mode? (y/n)
:compact_check
set /p input=
if /i %input%==y goto correct_syntax_compact
if /i %input%==n goto correct_syntax_compact
echo Incorrect syntax, enter y for yes and n for no
goto compact_check
:correct_syntax_compact
if /i %input%==y reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v UseCompactMode /t REG_DWORD /d 0 /f
takeown /f "Windows.Ui.FileExplorer.dll_disabled"
icacls "Windows.Ui.FileExplorer.dll_disabled" /grant %username%:F
taskkill /f /im explorer.exe
ren Windows.Ui.FileExplorer.dll_disabled Windows.Ui.FileExplorer.dll
goto complete

:complete
explorer
echo ===================================================
echo The script has finished
echo If any bugs occur, try fully restarting your device
echo Made by @HazPlays-13 on Youtube / Hazjc11 on Github
timeout 10
exit

