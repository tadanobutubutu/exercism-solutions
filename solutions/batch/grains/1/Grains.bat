@echo off
setlocal EnableDelayedExpansion

set "input=%~1"
set "grains=1"

if %input% LSS 1 goto invalidSquare
if %input% GTR 31 goto invalidSquare

set /a "doublings=input-1"
for /L %%i in (1,1,%doublings%) do set /a "grains*=2"
echo %grains%
goto :eof

:invalidSquare
echo square must be between 1 and 31
