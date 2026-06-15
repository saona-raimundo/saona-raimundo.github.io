---

layout: post
title:  "Font technology"
date:   2023-12-03 00:00:00 +0000
front: false

---

Font technology is amazing and there has been inmense progress. 
Yet, a principled approach to displaying "Text" is far from a solved issue.
I claim that historical baggage is hindering the choice of the right abstractions for the problem.

## Problem

The concept of "font" is solving too many problems at the same time and the process of displaying text is usually divided into steps that are not sequential.
In other words, it seems that we are not using the right abstraction to tame the complexity of text rendering.

## State of affairs

### Fonts

The latest and most used font format is [OpenType](https://en.wikipedia.org/wiki/OpenType). 
Fonts are complex enough to encode games on them ([Fontemon](https://www.coderelay.io/fontemon.html)).
Fonts are usually thought of character-to-pixels mappings, with extra features.

There are alternatives for font technologies:
- Graphite is designed to maximize flexibility for writing system of languages without computer support yet.
- OpenType is designed to ease the production of fonts for large linguistic markets.

### Text rendering pipeline

The process is usually divided in the following steps:
1. Styling (parse markup, query system for fonts)
2. Layout (break text into lines)
3. Shaping (compute the glyphs in a line and their positions)
4. Rasterization (rasterize needed glyphs into an atlas/cache)
5. Composition (copy glyphs from the atlas to their desired positions)

In this separation we see some assumptions:
- Fonts are given by the system. 
	- Font storage optimization
- Line breaking is based on text, but later adjusted by drawn text
	- Mixed steps
- Glyphs will be positioned in a line, not a path. 
	- No adaptability
- Cache is an atlas
	- Space optimizations

These assumptions prevent us from taking text rendering to the next level


### Questions

Here are some concrete questions to think about
1. What are fonts and what is the interface they should provide?
2. Is language and script part of a font?
3. How is context needed for rendering encoded? Is it an after-thought? 
4. What needs to change to stop rendering text in a straight line?
5. How would the cache for color fonts look like?

## Proposal

Here is my draft of my text rendering pipeline.
The goal is create clear separations of concerns. 
I can not do so for every language in the world simply because I do not speak or write them.
These are the steps I envision that can be solved independently:

- Encode
	- Take human writing and give a linear encoding
	- The best proposal so far is Unicode, which can be extended with Private Use Areas.
	- Recall that "The Unicode Standard does not define glyph images. The standard defines how characters are interpreted, not how glyphs are rendered." [Unicode Standard](https://unicode.org/standard/principles.html) 
	- For some applications, markup is needed in this encoding
	- `encode(text) -> tree(point)`
- Scribble
	- Take linear encoding meant for storage and text processing and create a tree encoding of glyphs
	- Some languages have the same unicode point for different glyphs, so this step already depends on a target language
	- Visual text is far from linear. This structure is part of planing during text rendering.
	- For example, ligatures could be solved in this step (strong ligature)
	- This step can handle converting `i` and `◌́` with `ı` and `◌́`.
	- `scribble(tree(point)) -> tree(glyph_id)`
- Instruct
	- Given a context (a node in the scribble tree), a glyph and whatever parameters for the final drawing, define commands relative to writing axis
	- Writing axis can be passed later on and may not be a simple line
	- For example, ligatures could be also solved in this step (weak ligature)
	- `instruct(context: tree_node, glyph_id, parameters, features) -> [command]`
- Draw
	- Given a surface (representing the geometry where we will write on), return specific vector commands to display in 2D
	- `draw(surface, [command]) -> [svg_path]`
- Render
	- Convert vector commands (SVG paths) into an image that displays can use
	- SVG rendering
	- `render(svg_path) -> pixels`

The idea is to stop thinking of fonts as objects encoding all responsabilities and start using abstractions for each of these problems that should be tackled separately.
To make these steps independent, we must hold the following:
- Linear encoding has sufficient information to express how glyphs should be thought of
- Instructung how to draw a glyph can depend on the context, but only requires to know other glyphs by id, not by how they are drawn. 
- Drawing requires a surface. Drawing surface should contain information like text axis (which can be more than one, think right-to-left and math text).
- SVG contains enough information to express the graphical representation of text. Rendering quality can be delegated to the rendering of SVG paths.

## Example

The following is a short example to illustrate the separation of concerns.
<div style="width: 15em;">
  La siguiente fórmula nos permite approximar π.
  <math display="block" style="border: 1px dotted black;">
    <mrow>
      <munderover>
        <mo>∑</mo>
        <mrow><mi>n</mi><mo>=</mo><mn>1</mn></mrow>
        <mrow><mo>+</mo><mn>∞</mn></mrow>
      </munderover>
      <mfrac>
        <mn>1</mn>
        <msup><mi>n</mi><mn>2</mn></msup>
      </mfrac>
    </mrow>
    <mo>=</mo>
    <mfrac>
      <msup><mi>π</mi><mn>2</mn></msup>
      <mn>6</mn>
    </mfrac>
  </math>
</div>

- Encode
	- As you may see, it is in Spanish, so, for example, `ó` is part of our linear encoding as a sinle point. In Unicode, this is U+00F3 (LATIN SMALL LETTER O WITH ACUTE). 
	- The text also uses mathematical symbols for the number pi, so `π` is also in our encoding. 
	- The mathematical formula requires markup (even if using the nearly linear encoding of UnicodeMath, it is a markup) and the reason is simple: the formula is far from linear, yet it is just "Text" for mathematicians.
	- The input to the encoding is going to be Unicode, but the result will be something more like a syntax tree.
- Scribble
	- In this case, the encoding and scribble do not have much difference because symbols are msostly context-independent.
	- Note that we can still use extra nodes to give context in the next step, for example, the formula is supposed to be in displayed (centered in its own line).
	- Also, this step may produce not one but many trees if next steps could be done independently
- Instruct
	- This step is what most people think fonts do: take a glyph, some parameters (like size and weight) and produce drawing commands.
	- We break this process a bit more: 
		- Context is given by the tree.
		- Language and scripts are implicit
			- I am not writing spanish and math, I am writing mathematics in my spanish text.
			- Similarly, when using more than one language, you are not writing in two languages on the same page, you write both languages in the same script.
		- parameters allow typographic control over the "font" (for example weight)
		- Parameters are not part of the tree. If contextual information is needed to automatically define parameters for the font based on markup, then this markup is part of the tree.
- Draw
	- In scientific writing we mostly write on "justified style" and on a paged media (as opposed to infinite canvas like websites).
	- Justified style is clearly not part of the surface, but the final visual result we desired. On the other hand, the paged media is clearly part of the surface we can write on.
- Render
	- Software the visualizes text (like text readers) implements this last step only.
	- Along the pipeline, a mapping from the original text or its encoding can be preserved to make an optical-to-content link. For example, a layer of Optical Character Recognition (OCR).  

## Resources

- [Unplain text – Increment: Programming Languages](https://increment.com/programming-languages/unplain-text-primer-on-non-latin/)
	- Great post on leaving the latin-dominated world
- [Text Rendering Hates You - Faultlore](https://faultlore.com/blah/text-hates-you/)
	- A post from a senior Firefox developer working on rendering 
- [Graphite](https://graphite.sil.org/)
	- Font technology that supports more writing systems and is more extensible. It investigates smart font shaping.
- [HarfBuzz](https://harfbuzz.github.io/)
	- Industry standard for text shaping on a line
- [Unicode Private Use Areas](https://en.wikipedia.org/wiki/Private_Use_Areas)
	- Extending Unicode with Private use areas 
- [Improving the Font Pipeline – Hypersect](https://blog.hypersect.com/improving-the-font-pipeline/)
	- Practical post on improving font pipeline in a real project
- [UAX #9: Unicode Bidirectional Algorithm](http://www.unicode.org/reports/tr9/#Introduction)
	- Unicode bidirectional algorithm: a way of mixing languages
- [Mathematical axis](https://www.w3.org/TR/mathml-core/#box-model-generic)
	- MathML axis model
- [Unicode Math](https://www.unicode.org/notes/tn28/UTN28-PlainTextMath-v3.1.pdf)
	- Unicode techinal report on an initiative of markup encoded in Unicode for mathematics
