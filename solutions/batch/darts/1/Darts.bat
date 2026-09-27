@echo off
setlocal enabledelayedexpansion

set "x=%~1"
set "y=%~2"
set "result="

REM Usage:  set /a "value=sqrt(n):n=100"
REM         echo %value%
REM '100' is the number to find the square root of '10'
set "Sqrt(N)=( x=(N)/(11*1024)+40, x=((N)/x+x)/2, x=((N)/x+x)/2, x=((N)/x+x)/2, x=((N)/x+x)/2, x=((N)/x+x)/2 )"

set /a "distanceSquared=x*x+y*y"
if %distanceSquared% LEQ 100 set "result=1"
if %distanceSquared% LEQ 25 set "result=5"
if %distanceSquared% LEQ 1 set "result=10"
if not defined result set "result=0"

echo %result%
