:Initialization
REM VERY IMPORTANT: The two lines ensure that the script is executed in the current directy (ARE), also when called
REM as administrator
@setlocal enableextensions
@cd /d "%~dp0"

CLS
set JAVA_BIN=javaw

if exist java\bin\java.exe (
	set JAVA_BIN=java\bin\javaw.exe
)

%JAVA_BIN% -version 2>&1  | jtester.exe

@ECHO OFF
IF ERRORLEVEL 1 GOTO QuitError

IF EXIST asterics.ARE.jar GOTO Continue
ECHO ARE jar files not found, please unzip ARE.zip or copy jar files into this folder !
GOTO QuitError

:Continue
ECHO Starting AsTeRICS Runtime Environment ...
ECHO error_level:WARNING>.logger

start %JAVA_BIN% -splash:images/asterics_startup.png -Djava.util.logging.config.file=logging.properties -Dosgi.clean=true -Dorg.osgi.framework.bootdelegation=* -Deu.asterics.ARE.startModel=%1 -Deu.asterics.ARE.ServicesFiles="services.ini;services-windows.ini" -jar org.eclipse.osgi_3.6.0.v20100517.jar -configuration profile -console
REM %JAVA_BIN% -Djava.util.logging.config.file=logging.properties -Dorg.osgi.framework.bootdelegation=* -Deu.asterics.ARE.startModel=%1 -jar org.eclipse.osgi_3.6.0.v20100517.jar -configuration profile -console
GOTO Quit

:QuitError
pause
:Quit