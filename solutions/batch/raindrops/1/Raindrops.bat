@echo off
SETLOCAL EnableDelayedExpansion

set "input=%~1"
set "result="

set /a "remainder3=input %% 3"
set /a "remainder5=input %% 5"
set /a "remainder7=input %% 7"
if "!remainder3!"=="0" set "result=!result!Pling"
if "!remainder5!"=="0" set "result=!result!Plang"
if "!remainder7!"=="0" set "result=!result!Plong"
if not defined result set "result=!input!"

echo !result!
