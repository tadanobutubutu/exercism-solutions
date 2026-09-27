@echo off

set "name=%~1"

if "%name%"=="" set "name=you"
echo One for %name%, one for me.
