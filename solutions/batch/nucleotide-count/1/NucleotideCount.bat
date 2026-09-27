@echo off
SETLOCAL EnableDelayedExpansion

set "nucleotide=%~1"
set "strand=!nucleotide!"
set "countA=0"
set "countC=0"
set "countG=0"
set "countT=0"

:CountNext
if not defined strand goto CountDone
set "base=!strand:~0,1!"
set "strand=!strand:~1!"
if "!base!"=="A" (
    set /a countA+=1
    goto CountNext
)
if "!base!"=="C" (
    set /a countC+=1
    goto CountNext
)
if "!base!"=="G" (
    set /a countG+=1
    goto CountNext
)
if "!base!"=="T" (
    set /a countT+=1
    goto CountNext
)
echo Invalid nucleotide in strand
exit /b 0

:CountDone
set "nucleotide[A]=!countA!"
set "nucleotide[C]=!countC!"
set "nucleotide[G]=!countG!"
set "nucleotide[T]=!countT!"
echo !nucleotide[A]!,!nucleotide[C]!,!nucleotide[G]!,!nucleotide[T]!
