@echo off
setlocal EnableExtensions
cd /d "%~dp0"
title VoidCore - Build

echo ========================================
echo   VoidCore Bedrock Server - Build
echo ========================================
echo.

if not exist "gradlew.bat" (
    echo ERROR: gradlew.bat was not found. Extract the complete source archive first.
    goto :failed
)

where java >nul 2>nul
if errorlevel 1 (
    echo ERROR: Java was not found in PATH.
    echo Install a JDK 25, then run this file again.
    goto :failed
)

where javac >nul 2>nul
if errorlevel 1 (
    echo ERROR: javac was not found. Install a full JDK 25, not only a JRE.
    goto :failed
)

set "JAVA_VERSION="
set "JAVA_MAJOR="
for /f "tokens=3" %%V in ('java -version 2^>^&1 ^| findstr /i /c:"version"') do set "JAVA_VERSION=%%~V"
for /f "tokens=1 delims=." %%M in ("%JAVA_VERSION%") do set "JAVA_MAJOR=%%M"
if not "%JAVA_MAJOR%"=="25" (
    echo ERROR: This build requires JDK 25. Detected Java version: %JAVA_VERSION%
    echo Install and select JDK 25 in PATH, then try again.
    goto :failed
)

set "JAVAC_VERSION="
set "JAVAC_MAJOR="
for /f "tokens=2" %%V in ('javac -version 2^>^&1') do set "JAVAC_VERSION=%%V"
for /f "tokens=1 delims=." %%M in ("%JAVAC_VERSION%") do set "JAVAC_MAJOR=%%M"
if not "%JAVAC_MAJOR%"=="25" (
    echo ERROR: javac must also be JDK 25. Detected compiler version: %JAVAC_VERSION%
    goto :failed
)

echo JDK 25 detected. Gradle will download the build tools and dependencies if needed.
echo This first build can take several minutes and requires internet access.
echo.
call gradlew.bat buildSkipChores --no-daemon
if errorlevel 1 goto :failed

if not exist "build\VoidCore.jar" (
    echo ERROR: Gradle completed but build\VoidCore.jar was not created.
    goto :failed
)
copy /y "build\VoidCore.jar" "VoidCore.jar" >nul
if errorlevel 1 (
    echo ERROR: Could not copy the built jar to the project root.
    goto :failed
)

echo.
echo BUILD SUCCESSFUL
echo Core: %~dp0VoidCore.jar
echo To run it, execute run-server.bat
echo.
pause
exit /b 0

:failed
echo.
echo BUILD FAILED. Read the error above, check JDK 25 and internet access, then retry.
echo.
pause
exit /b 1
