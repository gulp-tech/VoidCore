#!/usr/bin/env sh
set -eu
cd "$(dirname "$0")"
SERVER_MEMORY="${SERVER_MEMORY:-4096}"
SERVER_JARFILE="${SERVER_JARFILE:-build/VoidCore.jar}"
if [ ! -f "$SERVER_JARFILE" ]; then
  echo "Missing $SERVER_JARFILE. Build first with ./build-voidcore.sh" >&2
  exit 1
fi
exec java -Xms128M -Xmx"${SERVER_MEMORY}"M \
  -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 \
  -XX:+DisableExplicitGC -XX:+PerfDisableSharedMem \
  -jar "$SERVER_JARFILE" "$@"
