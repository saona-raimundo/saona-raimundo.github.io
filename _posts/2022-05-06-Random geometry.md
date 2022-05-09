---

layout: post
title:  "Random geometry"
date:   2022-05-06 00:00:00 +0000
front: 	true
categories: 
  - Mathematics 
  - Questions
---

The following is an open research question for which I would be happy to have an answer. Please contact me if you have ideas.

The model is in random geometry in the Euclidean space and the question is about the asymptotic behavior of some probabilities.

<noscript>
	The following uses MathJax, 
	<strong>
		make sure you have JavaScript enabled!
	</strong>
</noscript>

<script>
MathJax = {
	tex: {
		inlineMath: [['$', '$']]
	},
};
</script>
<div style="display:none">
$
  \newcommand{\PP}{\mathbb{P}}
  \newcommand{\RR}{\mathbb{R}}
  \newcommand{\eps}{\varepsilon}
$
</div>
<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-chtml.js"></script>

Let $0 < d < n$ be two integers. Consider the following construction of a uniformly random subspace of $\RR^n$.

**Procedure:** Construction random sub-space.<br>
**Input:** Integers $0 < d < n$.<br>
**Output:** Subspace of $\RR^n$ of dimension $d$.<br>
- $S \gets \\{ 0 \\}$.
- For $i \in \\{ 1, 2, \ldots, d \\}$
	- Choose $v \in \partial B(0, 1) \cap S^\perp$ uniformely
	- $S \gets \langle S \cup \\{ v \\} \rangle$
- Return $S$

**Qesution.**
For each $d, n$, what is $\PP(S \cap \RR^n_+ \not = \emptyset)$?

**Question**
For each $d, n$, and each $\eps > 0$, what is $\PP( \\{ x \in S \cap \RR^n_+ : ||x||_1 \le (1 + \eps) ||x||_2 \\} = \emptyset)$?
