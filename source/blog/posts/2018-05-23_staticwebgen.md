
---
title: Making a Static Website Generator
author: Amlesh Sivanantham
date: May 5, 2018
css:
  - "/style.css"
---

### Static Website Generators

Static website generators are all the hype these days. There really simple to
setup and requires very little (if any) knowledge of HTML as pages are written
up in [Markdown][markdown] and then converted into HTML at build time. Users
can then download custom themes and make their pages look beautiful.
The 3 most popular static website generators are [Jekyll][jekyllrb],
[Next][nextjs], and [Hugo][hugo]. Now, I have no problems against these
site generators. They do their job well and effeciently. But I decided to
wonder how hard would it be to write my own website generator from scratch.
And that's what I did, but to say that I built one entirely out of scratch is
a bit of a stretch.

### The Right Tools 

I did use a couple awesome tools. For starters, I've been a huge fan of
[Pandoc][pandoc] which is the equivalent of a swiss army knife for document
convertors. It seem like the idea choice to use as a convertor between Markdown
and HTML. The second tool I found to be very help here was [GNU Make][make].
Makefiles are very cool, but I'm still trying to get a hang of them. These
tools were not enough however and I had to use some Shell Scripting to really
bind these tools together. Finally, I also used python to create a simple
test HTTP server so I view my website on localhost.

*By the way, this whole website can be viewed from this
[public repository][githubweb].
It not only contains all the markdown pages but also the very build/install
scripts that were used to create this very page. The only downside of
having the website in a public repository is that anyone can view posts not
published to your web server.
A possible fix would be to use GPG to encrypt these posts.*

### More to come below...


[githubweb]: https://github.com/zamlz/website

[markdown]: https://commonmark.org
[pandoc]: https://pandoc.org
[make]: https://www.gnu.org/software/make/

[staticgen]: https://staticgen.com
[jekyllrb]: https://jekyllrb.com
[nextjs]: https://nextjs.org
[hugo]: https://gohugo.io
