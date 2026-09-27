@echo off
setlocal EnableDelayedExpansion

set "series=%~1"
set "sliceLength=%~2"
set "result="

if %sliceLength% LSS 0 goto negativeLength
if %sliceLength% EQU 0 goto zeroLength

set /a "length=0"
:countLength
if not "!series:~%length%,1!"=="" (
  set /a "length+=1"
  goto countLength
)
if %sliceLength% GTR %length% goto tooLarge

set /a "lastStart=length-sliceLength, start=0"
:makeSlices
if %start% GTR %lastStart% goto done
set "slice=!series:~%start%,%sliceLength%!"
if defined result (
  set "result=!result! !slice!"
) else (
  set "result=!slice!"
)
set /a "start+=1"
goto makeSlices

:negativeLength
echo slice length cannot be negative
goto :eof

:zeroLength
echo slice length cannot be zero
goto :eof

:tooLarge
echo slice length cannot be greater than series length
goto :eof

:done
echo(!result!
