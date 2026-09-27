@echo off
setlocal enabledelayedexpansion

set "colorCode=%~1"
set "result="

if not defined colorCode goto listColors
if /I "%colorCode%"=="black" set "result=0"
if /I "%colorCode%"=="brown" set "result=1"
if /I "%colorCode%"=="red" set "result=2"
if /I "%colorCode%"=="orange" set "result=3"
if /I "%colorCode%"=="yellow" set "result=4"
if /I "%colorCode%"=="green" set "result=5"
if /I "%colorCode%"=="blue" set "result=6"
if /I "%colorCode%"=="violet" set "result=7"
if /I "%colorCode%"=="gray" set "result=8"
if /I "%colorCode%"=="grey" set "result=8"
if /I "%colorCode%"=="white" set "result=9"
echo %result%
goto :eof

:listColors
echo black
echo brown
echo red
echo orange
echo yellow
echo green
echo blue
echo violet
echo gray
echo white
