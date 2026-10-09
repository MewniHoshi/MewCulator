@echo off
setlocal
cd /d "%~dp0"
title MeowCulator build

set "JAVA_HOME="
if exist "C:\Android Studio\jbr\bin\java.exe" set "JAVA_HOME=C:\Android Studio\jbr"
if not defined JAVA_HOME (
  for /d %%D in ("%USERPROFILE%\.jdks\*") do (
    if exist "%%D\bin\java.exe" set "JAVA_HOME=%%D"
  )
)

echo === MeowCulator build ===> build-log.txt
if not defined JAVA_HOME (
  echo JDK not found: looked in "C:\Android Studio\jbr" and "%USERPROFILE%\.jdks">> build-log.txt
  echo JDK not found. See build-log.txt
  pause
  exit /b 1
)

echo JAVA_HOME=%JAVA_HOME%>> build-log.txt
"%JAVA_HOME%\bin\java.exe" -version >> build-log.txt 2>&1

echo Building. This can take several minutes on the first run.
echo Output goes to build-log.txt -- this window will look idle meanwhile.
call gradlew.bat --console=plain --stacktrace --continue testDebugUnitTest assembleDebug >> build-log.txt 2>&1
echo GRADLE_EXIT=%ERRORLEVEL%>> build-log.txt

echo.
echo Done. Result is in build-log.txt
pause
