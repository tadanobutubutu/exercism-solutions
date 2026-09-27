@echo off
setlocal enabledelayedexpansion

set "year=%~1"
set "result=0"

set /a "remainder4=year %% 4"
set /a "remainder100=year %% 100"
set /a "remainder400=year %% 400"
if "!remainder4!"=="0" (
    if not "!remainder100!"=="0" set "result=1"
    if "!remainder400!"=="0" set "result=1"
)

echo %result%
