@echo off
setlocal enabledelayedexpansion

set "row1=%~1"
set "row2=%~2"
set "result=0"
:CompareBases
if not defined row1 goto CheckRight
if not defined row2 goto DifferentLength
set "base1=!row1:~0,1!"
set "base2=!row2:~0,1!"
set "row1=!row1:~1!"
set "row2=!row2:~1!"
if not "!base1!"=="!base2!" set /a result+=1
goto CompareBases
:CheckRight
if defined row2 goto DifferentLength
goto Done
:DifferentLength
echo left and right strands must be of equal length
exit /b 0
:Done


echo %result%
