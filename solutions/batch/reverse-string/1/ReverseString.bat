@echo off
setlocal enabledelayedexpansion

set "str=%~1"
set "rev="

set /a "length=0"
:countLength
if not "!str:~%length%,1!"=="" (
  set /a "length+=1"
  goto countLength
)

:reverseLoop
if !length! LEQ 0 goto reversed
set /a "length-=1"
set "rev=!rev!!str:~%length%,1!"
goto reverseLoop

:reversed
echo(!rev!
