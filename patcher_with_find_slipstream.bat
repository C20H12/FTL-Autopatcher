@echo off

set "addon=transfusion-remaster"

set "pathToFolder=%userprofile%\Desktop\mv addons\%addon%"

set "mods=%userprofile%\Downloads\SlipstreamModManager_1.9.1-Win\SlipstreamModManager_1.9.1-Win\mods"

for /f "usebackq skip=2 tokens=1,2*" %%A in (`
  reg query "HKCU\SOFTWARE\FTL_autopatcher" /v pathToModman 
`) do (
  set reg_pathToModman=%%C
)

if not "%reg_pathToModman%"=="" goto found_in_reg

REM start section not found in reg
echo Modman not found
echo.
echo Attempting to find Modman...
echo.

for /f "usebackq delims=" %%i in (`
  powershell -command "gci -path C:\ -recurse -filter modman.exe -erroraction silentlycontinue | select -f 1 | select -expand Fullname"
`) do set found_pathToModman=%%i
REM end section not found in reg

if not "%found_pathToModman%"=="" goto found_in_disk

REM start section not found in disk
echo Modman not found on disk
echo.
echo Please enter the path to Modman:
echo.
set /p prompted_pathToModman=">>>"
echo.

reg add "HKCU\SOFTWARE\FTL_autopatcher" /v pathToModman /t REG_SZ /d "%prompted_pathToModman%" /f

powershell -command "Compress-Archive -Path '%pathToFolder%\data', '%pathToFolder%\img' -DestinationPath '%mods%\%addon%.zip' -Force"
"%prompted_pathToModman%" --patch hyperspace.zip %addon%.zip --runftl

goto end
REM end section not found in disk



REM start section found in reg
:found_in_reg
echo modman found in registry: %reg_pathToModman%
echo.
echo continuing with script...
echo.

powershell -command "Compress-Archive -Path '%pathToFolder%\data', '%pathToFolder%\img' -DestinationPath '%mods%\%addon%.zip' -Force"

"%reg_pathToModman%" --patch hyperspace.zip %addon%.zip --runftl

goto end
REM end section found in reg



REM start section found in disk
:found_in_disk
echo modman found at: %found_pathToModman%
echo.
echo Setting registry key...
echo.

reg add "HKCU\SOFTWARE\FTL_autopatcher" /v pathToModman /t REG_SZ /d "%found_pathToModman%" /f

powershell -command "Compress-Archive -Path '%pathToFolder%\data', '%pathToFolder%\img' -DestinationPath '%mods%\%addon%.zip' -Force"

"%found_pathToModman%" --patch hyperspace.zip %addon%.zip --runftl

goto end
REM end section found in disk





:end
pause