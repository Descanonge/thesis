#!/usr/bin/env bash

LOGFILE=$1

ERR_LOG="$(pplatex -q -i "$LOGFILE" 2>&1)"
RES="$(echo "$ERR_LOG" | grep -E '^Result')"
NERRORS="$(echo "$RES" | sed -En -e "s/^Result: o\) Errors: +([0-9]+), Warnings: +([0-9]+), BadBoxes: +([0-9]+)/\1/p")"

if [ "$NERRORS" -ge 1 ]; then
    # Only print errors if there are errors
    LOG="$ERR_LOG"
else
    LOG="$(pplatex -i "$LOGFILE" 2>&1)"
fi

# Cut if too long
HEAD=20
if [ "$(echo "$LOG" | wc -l)" -gt "$HEAD" ]; then
    echo "$LOG" | head -n"$HEAD"
    echo "..."
    echo "$RES"
else
    echo "$LOG"
fi
