#!/usr/bin/env python
"""Parse log given by pplatex.

Called by latexmk on completion, see .latexmkrc
"""

import re
import sys

log = sys.argv[1]

items = list(map(str.strip, filter(None, log.split('**'))))

last = items[-1].split('Result: o)')
items[-1] = last[0]
recap = last[1]
print(recap)
n_items = sum(map(int, re.fullmatch(r'Errors: (\d+), Warnings: (\d+), BadBoxes: (\d+)',
                                    recap.strip()).groups()))

errs_by_type = {t: list(filter(lambda x: x.startswith(t), items))
                for t in ['Error', 'Warning', 'BadBox']}

n_found = 0
for t, errs in errs_by_type.items():
    pattern = rf'{t}\s+in (?P<file>.+?)(?:, Line (?P<line>\d+))?:(?P<err>.*)'
    for er in errs:
        m = re.fullmatch(pattern, er, re.DOTALL)
        if not m:
            continue
        n_found += 1
        filename, line, err = [m.group(x) for x in ('file', 'line', 'err')]
        err = err.strip()
        line = f"[{line}]" if line else ''
        print(f"{t} {filename}{line}: {err}")

if n_found != n_items:
    print(f'Parsing missed {n_items-n_found} errors')
