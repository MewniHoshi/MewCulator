@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"
title MewCalc diag2
set "JAVA_HOME="
for %%V in (21 17) do (
  if not defined JAVA_HOME (
    for /d %%D in ("%USERPROFILE%\.jdks\*%%V*") do (
      if exist "%%D\bin\java.exe" set "JAVA_HOME=%%D"
    )
  )
)
call gradlew.bat --info --console=plain testDebugUnitTest > diag2-log.txt 2>&1
echo EXIT=!ERRORLEVEL!>> diag2-log.txt
echo Done.
