---

layout: post
title:  "Converting files with Pandoc"
date:   2022-05-18 00:00:00 +0000
front: 	false
categories: 

---

[Pandoc](https://pandoc.org) is a very powerful file format converter. 

This post is mainly to remind myself of how to use `pandoc`, maybe of use to others. You may also see [the complete manual](https://pandoc.org/MANUAL.html).

## LaTeX -> HTML

```
pandoc <file>.tex -f format -t html -s -o <file>.html --bibliography <file>.bib
```
- `-f` for format
- `-t` for target
- `-s` for standalone
- `-o` for ouput
- `--bibliography` for source bibliography data





