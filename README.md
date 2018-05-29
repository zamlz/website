# My personal website/blog builder

I wanted a simple program that would let me convert markdown to html
files without having to install a variety of programs. Many static
blog generators needed alot of dependencies to be installed and I
was not a fan of it. This aims to just use Makefiles and shell scripts
to create html files from markdown files. Initially I wanted write my
own markdown to html covertor, but then I found pandoc. It has a lot
of features that have/may be useful. Then I needed a local http server
and it turns out python comes with one aldready.

### Prerequisites

Make sure the following programs are installed and in your path.
 - GNU/Make
 - Pandoc
 - Python *(Needed for creating a local http server)*
 
All source files are found in the `source/` directory. You can modify
the location of this directory to whatever by editing the variable
`SOURCE_DIR` in the Makefile. 

### Usage

To build the html files, simply run `make` (default target) or,
```
$ make build
```

To clean up the source directory after building the files, 
```
$ make clean
```

Be sure to set the server directory in the makefile as well with the
`INSTALL_DIR` variable. You can then install to the directory with,
```
$ make install
```
You may need root priviledges to install to the directory if its
owned by root,
```
$ sudo make install
```
You can also override the installation directory for testing purposes.
```
$ make install INSTAL_DIR='/your/custom/directory/here'
```

### How it works

To be explained...
