@echo off

REM the addon's name
set "addon=transfusion-remaster"

REM path to the development folder
set "pathToFolder=C:\Users\me\Desktop\mv addons\%addon%"

REM path to slipstream's mods folder
set "mods=C:\Users\me\Downloads\SlipstreamModManager_1.9.1-Win\SlipstreamModManager_1.9.1-Win\mods"

set "pscmd=compress-archive -path '%pathToFolder%\data', '%pathToFolder%\img' -destinationPath '%mods%\%addon%.zip' -force"
%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe %pscmd%

REM patches mods; mods are separated by a space, and mod names must not contain any spaces
modman.exe --patch hyperspace.zip %addon%.zip --runftl