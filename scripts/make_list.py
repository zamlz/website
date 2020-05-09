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

elif mode == '--toc':

    def trie(): return defaultdict(trie)
    toc = trie()

    for post in sorted(markdown_files):
        pt = frontmatter.load(post)

        url = post.replace(root_dir, '').replace('.md', '.html')
        title = pt.get('title', 'TITLEisMISSING')

        keys = url.split('/')[1:-1]

        loc = toc
        for k in keys:
            loc = loc[k]
        loc[('TITLE', title)] = url

    # Recursive function to build toc list
    def print_links(D, level=0, directory=''):
        for k in D:

            if type(k) is str:
                tmp_directory = f"{directory}/{k}"
                try:
                    with open(f"{tmp_directory}/title", 'r') as f:
                        title = f.readlines()[0].strip()
                except:
                    title = k
                print(' '*level*2 + f'- __*{title}*__')
                print_links(D[k], level=level+1, directory=tmp_directory)

            if type(k) is tuple:
                title = k[1]
                url = D[k]
                print(' '*level*2 + f'- [{title}]({url})')

    print_links(toc, directory=root_dir)
