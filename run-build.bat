@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"
title MeowCulator build

rem Gradle 8.9 does not understand Java 25, and Android Studio ships JBR 25.
rem So we pick a JDK 21 (or 17) explicitly and ignore the bundled one.
set "JAVA_HOME="
for %%V in (21 17) do (
  if not defined JAVA_HOME (
    for /d %%D in ("%USERPROFILE%\.jdks\*%%V*") do (
      if exist "%%D\bin\java.exe" set "JAVA_HOME=%%D"
    )
  )
)
if not defined JAVA_HOME (
  for /d %%D in ("C:\Program Files\Java\*21*" "C:\Program Files\Eclipse Adoptium\*21*") do (
    if exist "%%D\bin\java.exe" set "JAVA_HOME=%%D"
  )
)

echo === MeowCulator build ===> build-log.txt
if not defined JAVA_HOME (
  echo No JDK 21 or 17 found in "%USERPROFILE%\.jdks">> build-log.txt
  echo No JDK 21 found. See build-log.txt
  pause
  exit /b 1
)

echo JAVA_HOME=!JAVA_HOME!>> build-log.txt
"!JAVA_HOME!\bin\java.exe" -version >> build-log.txt 2>&1

echo Building with !JAVA_HOME!
echo Output goes to build-log.txt -- this window will look idle meanwhile.
call gradlew.bat --console=plain --stacktrace --continue testDebugUnitTest assembleDebug >> build-log.txt 2>&1
echo GRADLE_EXIT=!ERRORLEVEL!>> build-log.txt

echo.
echo Done. Result is in build-log.txt
pause
