---

layout: post
title:  "Inkscape command line: Export SVG to PDF"
date:   2025-01-10 00:00:00 +0000
front:  false

---

[Inkscape](https://inkscape.org/) comes with a command line interface for scripting various commands. 
To export an SVG file `image.svg` to a PDF `image.pdf`, we can use the following command (as of Inkscape version 1.4, 2024-10-09)

```
inkscape --export-filename=output.pdf --export-type=pdf output.svg
```

Check the help massage by running `inkscape --help` for more options. 
By default, this renders all drawn elements in the SVG to the PDF, rather than the selected page area.