#!/usr/bin/env sh

LOGFILE=$1
LOG="$(pplatex -i "$LOGFILE" 2>&1)"

if [ "$(echo "$LOG" | wc -l)" -ge 10 ]; then
    OUTPUT="$(echo "$LOG" | head)\n...\n$(echo "$LOG" | tail)"
else
    OUTPUT="$LOG"
fi

echo "$OUTPUT"
