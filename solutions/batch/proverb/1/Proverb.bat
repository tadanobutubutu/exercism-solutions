@echo off
setlocal enabledelayedexpansion

set "first="
set "previous="
for %%W in (%*) do (
  if not defined first set "first=%%~W"
  if defined previous echo For want of a !previous! the %%~W was lost.
  set "previous=%%~W"
)
if defined first echo And all for the want of a !first!.
