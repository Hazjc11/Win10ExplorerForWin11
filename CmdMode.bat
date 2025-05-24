@echo off
title Command Mode - Loading...
::Adds the extra commands
doskey cmdrestart="C:\Program Files (x86)\CmdMode\CmdModeRestart.bat"
doskey cmdshutdown="C:\Program Files (x86)\CmdMode\CmdModeShutdown.bat"
doskey helpcmd="C:\Program Files (x86)\CmdMode\help.bat"
doskey winrestart="C:\Program Files (x86)\CmdMode\CmdModeLeave.bat"
doskey winshutdown="C:\Program Files (x86)\CmdMode\CmdModeLeaveShutdown.bat"
::say stuff
echo Command Mode ready
echo Enter the command "helpcmd" to view CmdMode commands
title Command Mode
::makes the window able to accept commands
cmd /k