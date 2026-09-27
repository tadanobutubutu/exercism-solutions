@echo off
setlocal enabledelayedexpansion

set "hours=%~1"
set "minutes=%~2"

set /a "total=hours*60+minutes"
set /a "total=(total %% 1440 + 1440) %% 1440"
set /a "hours=total/60, minutes=total %% 60"

if %hours% LSS 10 set "hours=0%hours%"
if %minutes% LSS 10 set "minutes=0%minutes%"

echo %hours%:%minutes%
