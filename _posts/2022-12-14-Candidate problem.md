---

layout: post
title:  "Candidate problem"
date:   2022-12-14 00:00:00 +0000
front: 	true
categories: 

---

# How to choose in life?

Everyone has thought about how to make decisions in life, mathematicians too.
As is customary in Mathematics, they simplify the problem until they can analyze it.
For some of us, the simplified setting may have nothing to do with real life.
The hope is that these simplifications still capture the essence of the problem. If that is true, the solution "somehow" applies to real life. 
In other words, mathematicians hope that they have something meaningful to share with you.

This article introduces the most classical setting, discusses some open extensions and points out a few references for the interested reader. 

## Mathematical formalization

The problem goes by many names, including:
- Secretary problem
- Marriage problem 
- Dowry problem
- Candidate problem

### Statement (rules of the game)

The <em>candidate problem</em>, in its simplest form, has the following features. 
1. There is one position available. 
2. The number of applicants is known. 
3. The applicants are interviewed sequentially in random order, each order being equally likely. 
4. You can rank all the applicants, if given the chance, from best to worst without ties. 
5. After an interview, you can only compare the current candidate with past candidates.
5. Once an applicant is rejected, you cannot recall the rejected candidate later. 
6. You will be satisfied with nothing but the very best candidate.

Since the order of presentation is random (3) and you care about nothing but the very best candidate (6), your objective is to define a rule that maximizes the probability of choosing the best candidate.

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



### Solution

Lindley (1961) (Section "The Marriage Problem", page 47) seems to be the first to solve the problem in a scientific journal. 

The solution to this problem consists in rejecting candidates until some fixed number and then choosing the first candidate that is better than anything you have seen. 
This can be expressed by a number $k^*$, which depends on the number of candidates $n$. Then, the optimal selection procedure is determined as follows.
1. Reject the first $(k^* - 1)$ candidates,
2. Then, if a leading candidate appears (someone preferable to all previous ones) then choose it.

Note that this rule may not choose any option if no leading candidate appears after the initial rejections. 

The critical number $k^*$ is defined in terms of the number of candidates $n$ by the following inequalities.
<math display="block">
  <mrow>
    <mrow>
      <munderover>
        <mo movablelimits="false">∑</mo>
        <mrow>
          <mi>ℓ</mi>
          <mo>=</mo>
          <msup>
            <mi>k</mi>
            <mo>*</mo>
          </msup>
        </mrow>
        <mrow>
          <mi>n</mi>
          <mo>−</mo>
          <mn>1</mn>
        </mrow>
      </munderover>
    </mrow>
    <mfrac>
      <mn>1</mn>
      <mi>ℓ</mi>
    </mfrac>
    <mo>≤</mo>
    <mn>1</mn>
    <mo>&lt;</mo>
    <mrow>
      <munderover>
        <mo movablelimits="false">∑</mo>
        <mrow>
          <mi>ℓ</mi>
          <mo>=</mo>
          <msup>
            <mi>k</mi>
            <mo>*</mo>
          </msup>
          <mo>−</mo>
          <mn>1</mn>
        </mrow>
        <mrow>
          <mi>n</mi>
          <mo>−</mo>
          <mn>1</mn>
        </mrow>
      </munderover>
    </mrow>
    <mfrac>
      <mn>1</mn>
      <mi>ℓ</mi>
    </mfrac>
    <mspace width="0.1667em"></mspace>
    <mi>.</mi>
  </mrow>
</math>

<!--
$$\sum_{\ell = k^*}^{n - 1} \frac{1}{\ell} \le 1 < \sum_{\ell = k^* - 1}^{n - 1} \frac{1}{\ell} \,.$$
-->
The corresponding maximum probability of selecting the best candidate is the following.
<math display="block">
  <mrow>
    <mfrac>
      <mrow>
        <msup>
          <mi>k</mi>
          <mo>*</mo>
        </msup>
        <mo>−</mo>
        <mn>1</mn>
      </mrow>
      <mi>n</mi>
    </mfrac>
    <mrow>
      <munderover>
        <mo movablelimits="false">∑</mo>
        <mrow>
          <mi>ℓ</mi>
          <mo>=</mo>
          <msup>
            <mi>k</mi>
            <mo>*</mo>
          </msup>
          <mo>−</mo>
          <mn>1</mn>
        </mrow>
        <mrow>
          <mi>n</mi>
          <mo>−</mo>
          <mn>1</mn>
        </mrow>
      </munderover>
    </mrow>
    <mfrac>
      <mn>1</mn>
      <mi>ℓ</mi>
    </mfrac>
    <mspace width="0.1667em"></mspace>
    <mi>.</mi>
  </mrow>
</math>
<!--
$$\frac{k^* - 1}{n} \sum_{\ell = k^* - 1}^{n - 1} \frac{1}{\ell} \,.$$
-->

The proof is an application of dynamic programming, see Lindley (1961) for details.

The sequence has been identified in the [On-Line Encyclopedia of Integer Sequences, code A054404](http://oeis.org/A054404) and here are the few first numbers.
<table>
	<thead>
        <tr>
            <th colspan="13">Optimal acceptance starting candidate</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <th>Number of candidates</th>
            <td>1</td>
            <td>2</td>
            <td>3</td>
            <td>4</td>
            <td>5</td>
            <td>6</td>
            <td>7</td>
            <td>8</td>
            <td>9</td>
            <td>10</td>
            <td>11</td>
            <td>12</td>
        </tr>
        <tr>
            <th>Start accepting from</th>
            <td>1</td>
            <td>1</td>
            <td>1</td>
            <td>2</td>
            <td>2</td>
            <td>2</td>
            <td>3</td>
            <td>3</td>
            <td>3</td>
            <td>4</td>
            <td>4</td>
            <td>5</td>
        </tr>
    </tbody>
</table>


## Extensions

In real life, not all assumptions are satisfied, or not exactly.
We highlight some questions that may be of interest.

### Question: What if the number of candidates is unknown?

Assume that the number of candidates is not known, but you may have a belief about how many candidates you may encounter.
Let's model this by saying that the number of candidates is random and follows some known distribution.

In the worst possible distribution for the number of candidates, can we choose the best candidate with non-zero probability?
The answer is no, given by Abdel-Hamid et al. (1982).

Consider a parameter $m \in \mathbb{N}$ and the following distribution $p$ over the number of candidates $n$.
<math display="block">
  <mrow>
    <mi>p</mi>
    <mo form="prefix" stretchy="false">(</mo>
    <mi>n</mi>
    <mo form="postfix" stretchy="false">)</mo>
    <mo>≔</mo>
    <mrow>
      <mo fence="true" form="prefix">{</mo>
      <mtable class="tml-cases">
        <mtr>
          <mtd>
            <mfrac>
              <mi>c</mi>
              <mrow>
                <mi>n</mi>
                <mo>+</mo>
                <mn>1</mn>
              </mrow>
            </mfrac>
          </mtd>
          <mtd>
            <mrow>
              <mi>n</mi>
              <mo>&lt;</mo>
              <mi>m</mi>
            </mrow>
          </mtd>
        </mtr>
        <mtr>
          <mtd>
            <mi>c</mi>
          </mtd>
          <mtd>
            <mrow>
              <mi>n</mi>
              <mo>=</mo>
              <mi>m</mi>
            </mrow>
          </mtd>
        </mtr>
        <mtr>
          <mtd>
            <mn>0</mn>
          </mtd>
          <mtd>
            <mrow>
              <mi>n</mi>
              <mo>&gt;</mo>
              <mi>m</mi>
            </mrow>
          </mtd>
        </mtr>
      </mtable>
      <mo fence="true" form="postfix"></mo>
    </mrow>
    <mspace width="0.1667em"></mspace>
    <mo separator="true">,</mo>
  </mrow>
</math>
<!--
$$
	p(n) \coloneqq \begin{cases}
		\frac{c}{n + 1}
			&n < m \\
		c
			&n = m \\
		0
			&n > m
	\end{cases} \,,
$$
-->
where $c$ is such that $p$ sums up to one.

This belief is a very tricky: usually the number of candidates behaves very differently.
Person and Sonin (1972) investigated more "usual" distributions like [Uniform](https://en.wikipedia.org/wiki/Discrete_uniform_distribution), [Poisson](https://en.wikipedia.org/wiki/Poisson_distribution) and [Geometric](https://en.wikipedia.org/wiki/Geometric_distribution). 
In all these cases, you can obtain a constant probability of selecting the best candidate. 

## History and extensions

If you are interested in the history of this problem or its extensions, you may find useful the following references.

- "Who solved the secretary problem?"
	+ Historical and mathematical review. Partly serious, partly entertainment.
	+ Ferguson (1989)
- "The secretary problem and its extensions"
	+ Extensive review
	+ Freeman (1983)

## My work

My master thesis titled "Prophet Secretary Through Blind Strategies" deals with the case where you do not care only about the best candidate but want to select a "good" candidate.

This shift in objective requires formalizing what a "good" candidate is. In the end, we propose a strategy where you start with a very high requirement to accept a candidate and lower it as time goes by.

