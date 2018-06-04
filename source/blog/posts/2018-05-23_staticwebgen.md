
---
title: Static Website Generator
author: zamlz
date: 2018-05-23
css: /style.css
---

### The problem with static website generators

Static website generators are really common these days,
but most require a lot of dependencies. For example,
Jekyll uses Ruby, Hugo needs go, etc. I didn't want to
have to install so many dependencies and it would take
time to try all of them and see which ones I liked. Many
have a myriad of features and and it would take quite
a while to test them all. Instead, I tought it would
be cool to create my own static website generator using
GNU Make and shell scripts.

### Markdown to HTML

I lied. I didn't just use makefiles and shell scripts. I
used a program called [pandoc] which is a universal
document convertor. While this program does way more than
just convert a markdown files to html files, it has some
really useful features.


[pandoc]: http://pandoc.org

