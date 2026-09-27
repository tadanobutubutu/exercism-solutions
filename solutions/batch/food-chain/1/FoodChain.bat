@echo off
setlocal enabledelayedexpansion

set startVerse=%~1
set endVerse=%~2
for /L %%I in (%startVerse%,1,%endVerse%) do call :verse %%I
goto :eof

:verse
set "verseNumber=%~1"
call :setAnimal %verseNumber%
echo I know an old lady who swallowed a %animal%.
if "%verseNumber%"=="2" echo It wriggled and jiggled and tickled inside her.
if "%verseNumber%"=="3" echo How absurd to swallow a bird!
if "%verseNumber%"=="4" echo Imagine that, to swallow a cat!
if "%verseNumber%"=="5" echo What a hog, to swallow a dog!
if "%verseNumber%"=="6" echo Just opened her throat and swallowed a goat!
if "%verseNumber%"=="7" echo I don't know how she swallowed a cow!
if "%verseNumber%"=="8" (
  echo She's dead, of course!
  goto :eof
)

set /a "current=verseNumber"
:catchLoop
if %current% LEQ 1 goto flyWarning
call :setAnimal %current%
set "swallowed=%animal%"
set /a "prey=current-1"
call :setAnimal %prey%
set "caught=%animal%"
if %prey% EQU 2 (
  echo She swallowed the %swallowed% to catch the %caught% that wriggled and jiggled and tickled inside her.
) else (
  echo She swallowed the %swallowed% to catch the %caught%.
)
set /a "current-=1"
goto catchLoop

:flyWarning
echo I don't know why she swallowed the fly. Perhaps she'll die.
goto :eof

:setAnimal
if "%~1"=="1" set "animal=fly"
if "%~1"=="2" set "animal=spider"
if "%~1"=="3" set "animal=bird"
if "%~1"=="4" set "animal=cat"
if "%~1"=="5" set "animal=dog"
if "%~1"=="6" set "animal=goat"
if "%~1"=="7" set "animal=cow"
if "%~1"=="8" set "animal=horse"
goto :eof
