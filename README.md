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
 - [Python](https://www.python.org/) *(Needed to create a local http server)*

All source files are found in the `source/` directory. You can modify the
location of this directory to whatever by editing the variable `SOURCE_DIR` in
the Makefile.

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
You may need root priviledges to install to the directory if its owned by root,
```
$ sudo make install
```
You can also override the installation directory for testing purposes.
```
$ make install INSTAL_DIR='/your/custom/directory/here'
```

We can run a test http server with the following command, it will make the
source directory the root directory of the http server.
```
$ make test
```
You can also override the default address and port,
```
$ make test ADDRESS='127.0.1.1' PORT=8080
```

Drafts are encrypted using gpg keys. The encryptiong key is specified by
the file `.gpg-id` in the repository's root directory. All drafts follow the
naming convention `*.gpg`. Running the following command will decrypt those
files into `*.draft.md`.
```
$ make unlock
```
Once edits have been made to a draft, the files draft files can be locked back
to encrypted files by running the following command.
```
$ make lock
```

### How it works

The `make build` command essentially runs the default make target
in the Makefile that exists in the source directory. This Makefile
is responsible for building the individual html files. The details
of this Makefile are can be whatever you wish, but they should end
up building the html files in the locations relative to the
`SOURCE_DIR`. Meaning, that there should be an `index.html` in the
in the source directory after running `make build` at the very least.
The makefile should give more information about what is happening
under the hood.

The `make install` will then copy only the file types specified in
the `install.sh` script. You can specify the regular expressions
which search for the files at the bottom of that script.

