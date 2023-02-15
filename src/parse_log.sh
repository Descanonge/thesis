#!/usr/bin/env sh

LOGFILE=$1
LOG="$(pplatex -i "$LOGFILE" 2>&1)"

if [ "$(echo "$LOG" | wc -l)" -ge 20 ]; then
    OUTPUT="$(echo "$LOG" | head -n10)\n...\n$(echo "$LOG" | tail -n10)"
else
    OUTPUT="$LOG"
fi

echo "$OUTPUT"
