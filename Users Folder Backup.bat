cls
@pushd %~dp0
@echo	--------------------------------------------------------------------------
@echo	--------------------------------------------------------------------------
@echo	---        			Users Robocopy			       ---
@echo	---          			   (Ver. 1.6)           	       ---
@echo	---    			   Made by Sebastian Jones     		       ---
@echo	--------------------------------------------------------------------------
@echo	--- 			Utilizing the Robocopy command 		       ---
@echo	--------------------------------------------------------------------------
@echo	--------------------------------------------------------------------------
@echo.
@echo.
@echo off
:isAdmin
fsutil dirty query %systemdrive% >nul
if %errorlevel% == 0 goto :NextStep
@echo	You must run this tool as Administrator. Press any key to exit...
pause > nul
exit
:NextStep
goto date

:: Gets current date to inject into destination folder name
:date
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

set "datestamp=%MM%.%DD%.%YY%" & set "timestamp=%HH%%Min%%Sec%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"
echo Date: "%datestamp%"
set destDir=UserBackup_%datestamp%
@echo.

:: Prompts user for source and destination drive letters. Will restart if user rejects inputs
:begin
@echo.
set /p sourceVol=Please specify the SOURCE volume drive letter: 
set /p destVol=Please specify the TARGET volume drive letter: 

CALL :UpCase sourceVol
CALL :UpCase destVol

set /p confirm=Confirm transfer of Users folder from %sourceVol%: to %destVol%: (Y/N) 


if NOT %confirm% == Y (
	if NOT %confirm% == y goto begin
)

:: Echos not necessary but makes the program more satisfying
@echo.
@echo Preparing destination...
@echo Creating destination folder...
timeout /nobreak 2 > NUL
mkdir %destVol%:\%destDir%\Users
@echo Destination folder created at %destVol%:\%destDir%
@echo.

@echo Generating log file...
timeout /nobreak 2 > NUL

:: See readme for details on robocopy options
robocopy /e /b /MT /r:1 /w:1 /log:%destVol%:\%destDir%\log.txt /tee %sourceVol%:\Users %destVol%:\%destDir%\Users
@popd
pause

:UpCase
if not defined %~1 exit /b
for %%a in ("a=A" "b=B" "c=C" "d=D" "e=E" "f=F" "g=G" "h=H" "i=I" "j=J" "k=K" "l=L" "m=M" "n=N" "o=O" "p=P" "q=Q" "r=R" "s=S" "t=T" "u=U" "v=V" "w=W" "x=X" "y=Y" "z=Z" "ä=Ä" "ö=Ö" "ü=Ü") do (
call set %~1=%%%~1:%%~a%%
)
goto :eof
