@echo off
setlocal

set /a "n=%~1, sum=0, sumSquares=0"
for /L %%i in (1,1,%n%) do (
  set /a "sum+=%%i, square=%%i*%%i, sumSquares+=square"
)
set /a "difference=sum*sum-sumSquares"
echo %difference%
