#!/usr/bin/env python3

import sys
import datetime
import frontmatter
from collections import defaultdict, namedtuple
from functools import reduce

PostInfo = namedtuple('PointInfo', ['date', 'title', 'url'])

# This is not a complicated argparse script. Please be careful with ordering
# of arguments.
mode = sys.argv[1]
root_dir = sys.argv[2]
markdown_files = sys.argv[3:]

# Next we write out the markdown posts
if mode == '--time':

    time_map = defaultdict(list)

    for post in markdown_files:
        pt = frontmatter.load(post)

        url = post.replace(root_dir, '').replace('.md', '.html')

        title = pt.get('title', 'TITLEisMISSING')

        date = pt.get('date', 'November 8, 1995')
        date = datetime.datetime.strptime(date, '%B %d, %Y')
        year = int(date.strftime('%Y'))

        time_map[year] += [PostInfo(date, title, url)]

    for year in sorted(time_map.keys(), reverse=True):
        print("\n### " + str(year) + "\n")

        for p in sorted(time_map[year], reverse=True, key=lambda p: p.date):
            small_date = p.date.strftime('%Y-%m-%d')
            print('- [' + p.title + '](' + p.url + ') [' + small_date + ']')

elif mode == '--tags':

    pass

