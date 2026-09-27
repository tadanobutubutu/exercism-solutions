@echo off
setlocal enabledelayedexpansion

set "phrase=%~1 %~2 %~3 %~4 %~5 %~6 %~7 %~8 %~9"
set "acronym="

set "phrase=!phrase:-= !"
set "phrase=!phrase:_=!"
set "phrase=!phrase:,=!"
set "phrase=!phrase:.=!"
set "phrase=!phrase:'=!"
for %%W in (!phrase!) do (
    set "first=%%W"
    set "first=!first:~0,1!"
    for %%P in (a=A b=B c=C d=D e=E f=F g=G h=H i=I j=J k=K l=L m=M n=N o=O p=P q=Q r=R s=S t=T u=U v=V w=W x=X y=Y z=Z) do (
        for /f "tokens=1,2 delims==" %%a in ("%%P") do (
            if /i "!first!"=="%%a" set "first=%%b"
        )
    )
    set "acronym=!acronym!!first!"
)


echo !acronym!
