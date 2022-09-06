@echo off

for /f "usebackq delims=" %%i in (`
  powershell -command "(Get-Date -UFormat '%%T-%%a-%%D') -replace ':', '.'"
`) do set _timestamp=%%i

robocopy "%USERPROFILE%\Documents\My Games\FasterThanLight" "%USERPROFILE%\Documents\My Games\FTL_Save_Backups\%_timestamp%" /NFL /NDL /NJH /NJS /nc /ns /np

echo "Save Files Copied at %_timestamp%"

pause