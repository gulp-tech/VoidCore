@echo off
setlocal EnableExtensions
cd /d "%~dp0"
if "%SERVER_MEMORY%"=="" set "SERVER_MEMORY=4096"
set "SERVER_JARFILE=VoidCore.jar"
where java >nul 2>nul
if errorlevel 1 (
    echo Java was not found in PATH. Install a Java 25 runtime.
    pause
    exit /b 1
)
set "JAVA_VERSION="
set "JAVA_MAJOR="
for /f "tokens=3" %%V in ('java -version 2^>^&1 ^| findstr /i /c:"version"') do set "JAVA_VERSION=%%~V"
for /f "tokens=1 delims=." %%M in ("%JAVA_VERSION%") do set "JAVA_MAJOR=%%M"
if not "%JAVA_MAJOR%"=="25" (
    echo VoidCore requires Java 25. Detected: %JAVA_VERSION%
    pause
    exit /b 1
)
if not exist "%SERVER_JARFILE%" (
    echo Missing %SERVER_JARFILE%. Run start.bat to build the server first.
    pause
    exit /b 1
)
java -Xms128M -Xmx%SERVER_MEMORY%M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+DisableExplicitGC -XX:+PerfDisableSharedMem -jar "%SERVER_JARFILE%" %*
