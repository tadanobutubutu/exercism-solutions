@echo off
setlocal EnableDelayedExpansion

set "input=%~1"
set "result="

REM Newton's method, seeded and iterated as provided by the track starter.
set "Sqrt(N)=( x=(N)/(11*1024)+40, x=((N)/x+x)/2, x=((N)/x+x)/2, x=((N)/x+x)/2, x=((N)/x+x)/2, x=((N)/x+x)/2, x=((N)/x+x)/2 )"
set /a "result=Sqrt(n):n=%input%"

echo %result%
