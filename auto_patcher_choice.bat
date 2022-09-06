@echo off
echo.

echo ZIP UP FOLDER? (y/n)
set /p shouldZip=">>>"

REM put any addons that you want always patched after multiverse here (NOTE: rename multiverse's files so that they don't contain spaces
set "addons=Multiverse-Assets.zip Multiverse-Data.zip"

REM chain up any amounts of IF statements here, for conditional patching (remove these if you don't want to choose addons to patch)
echo PATCH INFINITE MODE? (y/n)
set /p input=">>>"
if /i "%input%"=="y" set "addons=%addons% infinite_enabler.zip"

echo PATCH TESTING MODE? (y/n)
set /p input2=">>>"
if /i "%input2%"=="y" set "addons=%addons% testing.zip"
REM end conditionals

if /i not "%shouldZip%"=="y" goto patch

echo.
echo RUNNING ZIP
echo.

REM These are the variables for folder paths

REM this is the name of the addon in development, and/or your development folder's name
set "devAddon=something"

REM this is the path to your slipstream mods folder
set "mods=%USERPROFILE%\Downloads\SlipstreamModManager_1.9.1-Win\SlipstreamModManager_1.9.1-Win\mods"

REM this is the your development folder's path, replace the %mods% to whatever path of your folder, if your development folder is not within "mods"
set "addon=%mods%\%devAddon%"


REM here is the command to output the zip
set "pscmd=compress-archive -path '%addon%\data', '%addon%\img', '%addon%\audio', '%addon%\mod-appendix' -destinationPath '%mods%\%devAddon%.zip' -force"
%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe %pscmd%

REM here is the lable for skipping the zipping
:patch
echo RUNNING PATCH
echo.

modman.exe --patch %addons%

REM use the following command instead of the above one if you want slipstream to run FTL for you
REM modman.exe --patch %addons% --runftl

REM If you have to use a shortcut in order to run FTL, place the shortcut in the same folder as this script, then uncomment the below lines
REM start "" "FTL_shortcut.lnk"
REM pause
