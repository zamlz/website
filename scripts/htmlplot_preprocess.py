#!/usr/bin/env python3

import sys

html = sys.argv[1]

with open(html, 'r') as f:
    lines = f.readlines()

# Remove specific lines from the html file
lines = lines[8:-2]

for l in lines:
    print(l, end='')
