@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"
title MewCalc diag
set "JAVA_HOME="
for %%V in (21 17) do (
  if not defined JAVA_HOME (
    for /d %%D in ("%USERPROFILE%\.jdks\*%%V*") do (
      if exist "%%D\bin\java.exe" set "JAVA_HOME=%%D"
    )
  )
)
echo === diag ===> diag-log.txt
echo JAVA_HOME=!JAVA_HOME!>> diag-log.txt
call gradlew.bat -q --console=plain printTestCp >> diag-log.txt 2>&1
echo EXIT=!ERRORLEVEL!>> diag-log.txt
echo Done.
