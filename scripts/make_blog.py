#!/usr/bin/env python3

import sys
import datetime
import frontmatter
from collections import defaultdict, namedtuple

PostInfo = namedtuple('PointInfo', ['date', 'title', 'url'])

# This is not a complicated argparse script. Please be careful with ordering
# of arguments.
mode = sys.argv[1]
template = sys.argv[2]
blog_posts = sys.argv[3:]

# dump contents of template to STDOUT
with open(template, 'r') as inf:
    for line in inf.readlines():
        print(line, end='')

# Next we write out the blog posts
if mode == '--time':

    time_map = defaultdict(list)

    for post in blog_posts:
        pt = frontmatter.load(post)

        url = post.replace('source', '').replace('.md', '.html')

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

