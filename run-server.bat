@echo off
setlocal EnableExtensions
cd /d "%~dp0"
if "%SERVER_MEMORY%"=="" set "SERVER_MEMORY=4096"
set "SERVER_JARFILE=VoidCore.jar"
if not exist "%SERVER_JARFILE%" (
    echo Missing %SERVER_JARFILE%. Run start.bat to build the server first.
    pause
    exit /b 1
)
java -Xms128M -Xmx%SERVER_MEMORY%M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+DisableExplicitGC -XX:+PerfDisableSharedMem -jar "%SERVER_JARFILE%" %*
