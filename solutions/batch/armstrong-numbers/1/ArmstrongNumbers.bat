@echo off
setlocal enabledelayedexpansion

set "numbers=%1"
set "remaining=%numbers%"
set /a digits=0
:CountDigits
if not defined remaining goto DigitsCounted
set "remaining=!remaining:~1!"
set /a digits+=1
goto CountDigits
:DigitsCounted
if !digits! equ 0 set "digits=1"
set "remaining=%numbers%"
set /a total=0
:AddDigitPower
if not defined remaining goto CompareTotal
set "digit=!remaining:~0,1!"
set "remaining=!remaining:~1!"
set /a power=1
for /l %%I in (1,1,!digits!) do set /a power*=digit
set /a total+=power
goto AddDigitPower
:CompareTotal
set "result=false"
if !total! equ %numbers% set "result=true"


echo %result%
