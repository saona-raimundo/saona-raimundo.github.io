---

layout: post
title:  "Raw pdf files: Writing a pdf from the specification"
date:   2025-08-25 00:00:00 +0000
front: 	false
categories: 

---

[Portable Document Format (PDF)](https://en.wikipedia.org/wiki/PDF), standardized as ISO 32000, is a file format. [PDF secifications](https://www.pdfa.org/resource/pdf-specification-index/) have evolved over the years, but the format is very stable and backwards compatible.

This post is mainly a primer on the basics of the PDF format. You may write your first pdf without the help of a pdf writer. 
The content of the post follows closely [PDF 1.7 specification](https://opensource.adobe.com/dc-acrobat-sdk-docs/standards/pdfstandards/pdf/PDF32000_2008.pdf), from 2008. 
The newest specification I know of is [PDF 2.0 (ISO 32000-2 / 2017)](
https://developer.adobe.com/document-services/docs/assets/5b15559b96303194340b99820d3a70fa/PDF_ISO_32000-2.pdf), which was not free of charge for some time, and therefore PDF 1.7 might still be the most used version.

## Syntax

PDF files has four parts:
- Objects
	- Data structure composed of the most basic data types in PDF (such as numbers, strings and dictionaries)
- File structure
	- Determines how objects are: stored, accessed and updated.
- Document structure
	- Specifies how objects represent components of a PDF document (pages, fonts, annotations)
- Content streams
	- Sequence of instructions describing graphical entities (appearance of a page)


### Character set

There are three types of characters: whitespace, delimiter and regular.

**Whitespace**. Includes null, horizontal tab, line feed, form feed, carriage return and space.
**Delimiters**. Include `(`, `)`, `<`, `>`, `[`, `]`, `{`, `}`, `/`, `%`
**Regular**. The rest of the characters.

### Objects

There are:
- Boolean values 
	- `true` or `false`
- Integer and Real numbers
	- `+4`, `-3`, `0.004`, `-0.0001`
	- Reals are simply decimal digits with a decimal point 
- Strings 
	- Literal Strings (enclosed by `(` and `)`)
		- (This is a string and may have balanced parenthesis (). There is no problem.)
		- `\ddd` escape sequence provides a way to represent characters outside the printable ASCII character set
	- Hexadecimal Strings (enclosed by `<` and `>`)
		- <901FA3>
		- sequence of hexadecimal digits (0–9 and either A–F or a–f) encoded as ASCII characters
- Names 
	- /Name1
	- Atomic unique symbol
- Arrays
	- [24 0.132 [2] false /Name]
	- One-dimensional collection of objects arranged sequentially
- Dictionaries
	- << /Type /Example /Subtype /MyExample /Version [0 0 1] >>
	- Associative table containing pairs of objects, where the key is always a `Name`
	- By convention, /Type and /Subtype entries have special descriptive meaning
- Streams
	- dictionary `stream`\n... sequence of bytes ...\n`endstream`
	- Sequence of bytes, described by a preceding dictionary
	- The bytes may be in an external file too
		- The describing dictionary 
			- requires to have the key `/Lenght` mapping to the number of bytes in the stream
			- may have filter-related entries like `/Filter`
- Null object
	- `null`

#### Indirect objects

Pretty much like pointers, references, labels, they are unique object identifiers. Its identifier has two parts:
- Positive integer object number
- Non-negative integer generation number
	- In a newly created document, they are all zero
	- After updating content, this number should be increased
```pdf
12 0 obj
	(This is the value of this indirect object)
endobj
```

To refer to such indirect object, we write
```pdf
12 0 R
```

<!--
### File structure

PDF files are designed for efficient random access and incremental update. The convention for a new file is:
- **header** - version of the PDF specification
- **body** - objects that make up the document
- **cross-reference table** - information about the indirect objects
- **trailer** - location of the cross-reference table and of certain special objects

#### Header

```pdf
%PDF–1.7
```

The version of the document should also be in the `Version` entry in the document’s catalog dictionary (located via the `Root` entry in the file’s trailer)

-->
