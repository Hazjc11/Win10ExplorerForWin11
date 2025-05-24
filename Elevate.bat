::::::::::::::::::::::::::::::::::::::::::::
:: Elevate.cmd - Version 5
:: Automatically check & get admin rights
:: see "https://stackoverflow.com/a/12264592/1016343" for description
::::::::::::::::::::::::::::::::::::::::::::
title Command Mode Launcher
 @echo off
 CLS
 ECHO.
 ECHO =============================
 ECHO Command Mode Launcher
 ECHO =============================
 ECHO Credit for Elevate script: https://stackoverflow.com/a/12264592/1016343

:init
 setlocal DisableDelayedExpansion
 set cmdInvoke=1
 set winSysFolder=System32
 set "batchPath=%~dpnx0"
 rem this works also from cmd shell, other than %~0
 for %%k in (%0) do set batchName=%%~nk
 set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
 setlocal EnableDelayedExpansion

:checkPrivileges
  NET FILE 1>NUL 2>NUL
  if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
  if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
  ECHO Invoking UAC for Privilege Escalation

  ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
  ECHO args = "ELEV " >> "%vbsGetPrivileges%"
  ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
  ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
  ECHO Next >> "%vbsGetPrivileges%"
  
  if '%cmdInvoke%'=='1' goto InvokeCmd 

  ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
  goto ExecElevation

:InvokeCmd
  ECHO args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
  ECHO UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"

:ExecElevation
 "%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
 exit /B

:gotPrivileges
 setlocal & cd /d %~dp0
 if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

 ::::::::::::::::::::::::::::
 ::START
 ::::::::::::::::::::::::::::
 REM Run shell as admin (example) - put here code as you like
@echo off
setlocal

:: Show the message box
echo Set objShell = CreateObject("WScript.Shell") > %temp%\msgbox.vbs
echo intMsgBox = objShell.Popup("Are you sure you want to restart into command mode?", 0, "Command Mode Launcher", 1 + 48) >> %temp%\msgbox.vbs
echo WScript.Quit(intMsgBox) >> %temp%\msgbox.vbs

:: Run the VBScript and capture the return code
cscript /nologo %temp%\msgbox.vbs
set returnCode=%errorlevel%
del %temp%\msgbox.vbs

:: Check if OK was pressed (OK returns 1)
if %returnCode% equ 1 (
    :: Start the application (replace with your application's path)
    cd "C:\Program Files (x86)\CmdMode"
    CmdModeLauncher.bat
)

endlocal
exit