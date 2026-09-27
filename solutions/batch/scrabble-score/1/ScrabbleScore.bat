@echo off
setlocal enabledelayedexpansion

set "word=%~1"
set /a "length=0, result=0"

:countLength
if not "!word:~%length%,1!"=="" (
  set /a "length+=1"
  goto countLength
)

set /a "lastIndex=length-1"
for /L %%i in (0,1,%lastIndex%) do (
  set "letter=!word:~%%i,1!"
  if /I "!letter!"=="A" set /a "result+=1"
  if /I "!letter!"=="E" set /a "result+=1"
  if /I "!letter!"=="I" set /a "result+=1"
  if /I "!letter!"=="O" set /a "result+=1"
  if /I "!letter!"=="U" set /a "result+=1"
  if /I "!letter!"=="L" set /a "result+=1"
  if /I "!letter!"=="N" set /a "result+=1"
  if /I "!letter!"=="R" set /a "result+=1"
  if /I "!letter!"=="S" set /a "result+=1"
  if /I "!letter!"=="T" set /a "result+=1"
  if /I "!letter!"=="D" set /a "result+=2"
  if /I "!letter!"=="G" set /a "result+=2"
  if /I "!letter!"=="B" set /a "result+=3"
  if /I "!letter!"=="C" set /a "result+=3"
  if /I "!letter!"=="M" set /a "result+=3"
  if /I "!letter!"=="P" set /a "result+=3"
  if /I "!letter!"=="F" set /a "result+=4"
  if /I "!letter!"=="H" set /a "result+=4"
  if /I "!letter!"=="V" set /a "result+=4"
  if /I "!letter!"=="W" set /a "result+=4"
  if /I "!letter!"=="Y" set /a "result+=4"
  if /I "!letter!"=="K" set /a "result+=5"
  if /I "!letter!"=="J" set /a "result+=8"
  if /I "!letter!"=="X" set /a "result+=8"
  if /I "!letter!"=="Q" set /a "result+=10"
  if /I "!letter!"=="Z" set /a "result+=10"
)

echo %result%
