@echo off 
setlocal enabledelayedexpansion

set "limit=%~1"
set "result="

for /L %%i in (2,1,%limit%) do set "prime_%%i=1"

set /a "candidate=2"
:findPrime
set /a "square=candidate*candidate"
if %square% GTR %limit% goto collectPrimes
if not defined prime_!candidate! goto nextCandidate

set /a "multiple=square"
:markMultiples
if %multiple% GTR %limit% goto nextCandidate
set "prime_!multiple!="
set /a "multiple+=candidate"
goto markMultiples

:nextCandidate
set /a "candidate+=1"
goto findPrime

:collectPrimes
for /L %%i in (2,1,%limit%) do if defined prime_%%i (
  if defined result (
    set "result=!result! %%i"
  ) else (
    set "result=%%i"
  )
)

echo(!result!
