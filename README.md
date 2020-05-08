# My personal website/blog builder

I wanted a simple program that would let me convert markdown to html files
without having to install a variety of programs. Many static blog generators
needed alot of dependencies to be installed and I was not a fan of it. This
aims to just use Makefiles and shell scripts to create html files from markdown
files. Initially I wanted write my own markdown to html covertor, but then I
found pandoc. It has a lot of features that have/may be useful. Then I needed a
local http server and it turns out python comes with one aldready.

### Prerequisites

Make sure the following programs are installed and in your path.
 - [GNU/Make](https://www.gnu.org/software/make/)
 - [Pandoc](http://pandoc.org/)
 - [Julia](https://julialang.org/)
 - [Python](https://www.python.org/) *(Needed to create a local http server)*

### Usage

I'll add more to this section, but for now, if you're curious how it works,
then take a look at the Makefile. Look at the default target and just follow
through with whats there.
