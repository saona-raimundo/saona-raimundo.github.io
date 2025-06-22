---

layout: post
title:  "Plotting rational data"
date:   2024-06-10 00:00:00 +0000
front:  false

---

# Plotting rational data

Usually, we think of a plot as an inexact drawing of some data, but it does not have to be like that. What if we want to 
- keep the data points exact? 
- interact with an exact plot that is approximated at drawing time?

Imagine the data to plot is given in rationals like "1/3", and you want to keep it like that as long as possible. How far can you go? 

## Keeping exact data

Although it may seem unsurprising, drawing libraries require the input to be floating points, so if you are going to input "1/3" to a plotting library, they should be able to do the math. 
The most widely used plotting library [gnuplot](http://www.gnuplot.info/) is like this. [This Stack overflow question](https://stackoverflow.com/questions/40682297) is related and I replicate it for illustration.

**Objective:**
Plotting data encoded in the form of "n/d".

**Example:** 
```
0  3/2
1  1 
2  7/3
3  15/7
```

**Solution:**
The solution is to parse the string and do the evaluation in gnuplot directly. I will use the gnuplot functions `real`, `substr`, `strstrt`. This approach can be extended to deal with more complex expressions.

The gnuplot script is the following
```gnuplot
# Define rational conversion from a string

rational(x) = strstrt(x, "/") ? (real(substr(x, 1, strstrt(x, "/") - 1)) / real(substr(x, strstrt(x, "/") + 1, strlen(x)))) : x

# Functions used
# real(x), parse string x as real number
# substr(x, start, end), returns the substring of x between start and end
# strstrt(x, y), return the first index where y appears in x, or zero if there is none

plot "data.dat" using (rational(strcol(1))):(rational(strcol(2))) with lines 

# Functions use
# rational(x), defined above, transform a string x with rational notation into a real
# strcol(n), pass a column of data as string directly
```

## Keeping exact drawing 

Exact drawing are indeed available, for example with [SVG](https://en.wikipedia.org/wiki/SVG).
The drawing can take rational coordinates and even allow you to interact with the plot in a way that exact values are preserved and discoverable.
A static plot will anyway approximate if it has finite pixels, or if the precision of the drawing is fixed. 
Instead, SVG can retain exact values and one can interact (zoom) with a drawing.
Read more about this topic in [this blog](https://blog.4d.com/svg-non-scaling-stroke-attribute-support/), [its feature documentation](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/vector-effect), and [check if you can use it in the web](https://caniuse.com/vector-effect).


**Objective:**
Plotting data encoded in the form of "n/d", and recover an arbitrary precision approximation of it by interacting with the plot.

**Example:**
```
0  4/3
1  1 
2  7/3
3  15/7
```

**Solution:**
Let us construct the SVG by hand this time, to see the code directly.

Some observations:
1. To use integer coordinates in the SVG, we convert the rational input data into integer data in a coordinate system large enough. For example, each unit will consist of `1/21` units in our case, so `4/3` is now `28`, since `28/21 = 4/3`. You could do the same for pixel-based pictures... but lines are the problem.
```svg
<svg viewBox="0 0 63 63">
	<!-- (0, 4/3) to (1, 1) -->
	<line x1="0" y1="28" x2="21" y2="21" stroke="black" vector-effect="non-scaling-stroke" />
	<!-- (1, 1) to (2, 7/3) -->
	<line x1="21" y1="21" x2="42" y2="49" stroke="black" vector-effect="non-scaling-stroke" />
	<!-- (2, 7/3) to (3, 15/7) -->
	<line x1="42" y1="49" x2="63" y1="45" stroke="black" vector-effect="non-scaling-stroke" />
</svg>
```

We can interact with with svg for example through CSS properties like `zoom` or `with`, which can be controlled by JavaScript. 
Here is a static example:
```html
<div style="width: 10%;">SVG</div>
<div style="width: 20%;">SVG</div>
<div style="width: 40%;">SVG</div>
```
Replacing with the previous SVG, we get the following (notice that the width of the line stroke does not change).

<div style="width: 10%;">
	<svg viewBox="0 0 63 63">
		<!-- (0, 4/3) to (1, 1) -->
		<line x1="0" y1="28" x2="21" y2="21" stroke="black" vector-effect="non-scaling-stroke" />
		<!-- (1, 1) to (2, 7/3) -->
		<line x1="21" y1="21" x2="42" y2="49" stroke="black" vector-effect="non-scaling-stroke" />
		<!-- (2, 7/3) to (3, 15/7) -->
		<line x1="42" y1="49" x2="63" y1="45" stroke="black" vector-effect="non-scaling-stroke" />
	</svg>
</div>
<div style="width: 20%;">
	<svg viewBox="0 0 63 63">
		<!-- (0, 4/3) to (1, 1) -->
		<line x1="0" y1="28" x2="21" y2="21" stroke="black" vector-effect="non-scaling-stroke" />
		<!-- (1, 1) to (2, 7/3) -->
		<line x1="21" y1="21" x2="42" y2="49" stroke="black" vector-effect="non-scaling-stroke" />
		<!-- (2, 7/3) to (3, 15/7) -->
		<line x1="42" y1="49" x2="63" y1="45" stroke="black" vector-effect="non-scaling-stroke" />
	</svg>
</div>
<div style="width: 40%;">
	<svg viewBox="0 0 63 63">
		<!-- (0, 4/3) to (1, 1) -->
		<line x1="0" y1="28" x2="21" y2="21" stroke="black" vector-effect="non-scaling-stroke" />
		<!-- (1, 1) to (2, 7/3) -->
		<line x1="21" y1="21" x2="42" y2="49" stroke="black" vector-effect="non-scaling-stroke" />
		<!-- (2, 7/3) to (3, 15/7) -->
		<line x1="42" y1="49" x2="63" y1="45" stroke="black" vector-effect="non-scaling-stroke" />
	</svg>
</div>

