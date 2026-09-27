@echo off
setlocal enabledelayedexpansion

set /a n=%~1
set /a result=0
:CountBits
if !n! leq 0 goto Done
set /a "bit=n %% 2"
set /a result+=bit
set /a n/=2
goto CountBits
:Done


echo %result%
