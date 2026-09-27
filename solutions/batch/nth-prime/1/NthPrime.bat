@echo off
setlocal enabledelayedexpansion

set /a "target=%~1, found=0, candidate=1"
if %target% LSS 1 (
  echo there is no zeroth prime
  exit /b 0
)

:nextCandidate
set /a "candidate+=1, divisor=2"
:testDivisor
set /a "remainder=candidate %% divisor"
if !remainder! EQU 0 if !divisor! LSS !candidate! goto nextCandidate
set /a "divisor+=1, divisorSquared=divisor*divisor"
if !divisorSquared! LEQ !candidate! goto testDivisor

set /a "found+=1"
if !found! GEQ %target% goto foundPrime
goto nextCandidate

:foundPrime
echo !candidate!
