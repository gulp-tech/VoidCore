@echo off
setlocal
cd /d "%~dp0"
if "%SERVER_MEMORY%"=="" set SERVER_MEMORY=4096
if "%SERVER_JARFILE%"=="" set SERVER_JARFILE=build\VoidCore.jar
if not exist "%SERVER_JARFILE%" (
  echo Missing %SERVER_JARFILE%. Build first with gradlew.bat buildSkipChores
  exit /b 1
)
java -Xms128M -Xmx%SERVER_MEMORY%M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+DisableExplicitGC -XX:+PerfDisableSharedMem -jar "%SERVER_JARFILE%" %*
