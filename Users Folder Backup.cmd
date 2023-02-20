cls
@pushd %~dp0
@echo	--------------------------------------------------------------------------
@echo	--------------------------------------------------------------------------
@echo	---        			Users Robocopy			       ---
@echo	---          			 (Ver. 1.9.4)			       ---
@echo	--------------------------------------------------------------------------
@echo	--------------------------------------------------------------------------
@echo   ---   This software is licensed under the Mozilla Public License 2.0   ---
@echo	--------------------------------------------------------------------------
@echo.
@echo off

:: Get Administrator Rights
set _Args=%*
if "%~1" NEQ "" (
  set _Args=%_Args:"=%
)
fltmc 1>nul 2>nul || (
  cd /d "%~dp0"
  cmd /u /c echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~dp0"" && ""%~dpnx0"" ""%_Args%""", "", "runas", 1 > "%temp%\GetAdmin.vbs"
  "%temp%\GetAdmin.vbs"
  del /f /q "%temp%\GetAdmin.vbs" 1>nul 2>nul
  exit
)

:NextStep
goto date

:: Gets current date to inject into destination folder name
:date
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

set "datestamp=%MM%.%DD%.%YY%" & set "timestamp=%HH%%Min%%Sec%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"
echo.
echo Date: "%datestamp%"
set destDir=GeekSquadBackup_%datestamp%
@echo.

:: Prompts user for Service Order number. Will restart if user rejects inputs
:begin
:serviceOrderCapture
@echo.
set /p serviceOrder=Enter the Service Order number (including the dash): 
set /p serviceOrderConfirm=Re-enter the Service Order number (including the dash): 
if NOT %serviceOrder% == %serviceOrderConfirm% (
	@echo Error: Service Order numbers do not match.
	goto serviceOrderCapture
)

:: Prompts user for source and destination drive letters. Will restart if user rejects inputs
:volumeSelection
@echo.
set /p sourceVol=Please specify the SOURCE volume drive letter: 
set /p destVol=Please specify the TARGET volume drive letter: 
CALL :UpCase sourceVol
CALL :UpCase destVol

set /p confirm=Confirm backup of Users folder from %sourceVol%: to %destVol%: (Y/N) 

if NOT %confirm% == Y (
	if NOT %confirm% == y goto volumeSelection
)

:: Echos not necessary but makes the program more satisfying
@echo.
@echo Preparing backup...
@echo Creating destination folders...
timeout /nobreak 2 > NUL
mkdir %destVol%:\%serviceOrder%\%destDir%\Users
@echo Destination folder created at %destVol%:\%serviceOrder%\%destDir%
@echo.

@echo Generating log file...
timeout /nobreak 2 > NUL

:: See readme for details on robocopy options
robocopy /e /b /sl /xj /MT /r:1 /w:1 /log:%destVol%:\%serviceOrder%\%destDir%\log.txt /tee %sourceVol%:\Users %destVol%:\%serviceOrder%\%destDir%\Users
@popd
@echo	--------------------------------------------------------------------------
@echo.
@echo Completed! See log file output for result data.
pause

:: For standardizing drive letter format
:UpCase
if not defined %~1 exit /b
for %%a in ("a=A" "b=B" "c=C" "d=D" "e=E" "f=F" "g=G" "h=H" "i=I" "j=J" "k=K" "l=L" "m=M" "n=N" "o=O" "p=P" "q=Q" "r=R" "s=S" "t=T" "u=U" "v=V" "w=W" "x=X" "y=Y" "z=Z" "ä=Ä" "ö=Ö" "ü=Ü") do (
call set %~1=%%%~1:%%~a%%
)
goto :eof