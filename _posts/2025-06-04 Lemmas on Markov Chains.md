---

layout: post
title:  "Lemmas on Markov Chains"
date:   2025-06-04 00:00:00 +0000
front:  false

---

# Useful lemmas

Technical mathematical results can be applied to a variety of contexts.
In this post, we explain results related to Markov Chains that have been useful to me.
They relate to the hitting distribution of a set of states and the discounted occupation time on a state.

## References

- Solan, Eilon. “Continuity of the Value of Competitive Markov Decision Processes.” Journal of Theoretical Probability 16, no. 4 (October 1, 2003): 831–45. https://doi.org/10.1023/B:JOTP.0000011995.28536.ef.

- Freidlin, Mark I., and Alexander D. Wentzell. Random Perturbations of Dynamical Systems. 3rd ed. Grundlehren Der Mathematischen Wissenschaften. Springer Berlin Heidelberg, 2012. https://doi.org/10.1007/978-3-642-25847-3.

- Catoni, Olivier. “Simulated Annealing Algorithms and Markov Chains with Rare Transitions.” In Séminaire de Probabilités XXXIII, edited by Jacques Azéma, Michel Émery, Michel Ledoux, and Marc Yor, 1709:69–119. Lecture Notes in Mathematics. Berlin, Heidelberg: Springer Berlin Heidelberg, 1999. https://doi.org/10.1007/BFb0096510.

- Kirchhoff G. (1847) Über die Auflösung der Gleichungen, auf welche man beider Untersuchung der linearen Verteilung galvanischer Ströme gefuhrt wird, Ann. Phys. Chem., 72, pp. 497-508.(English translation IRE Trans. Circuit Theory CT-5 (1958) 4-7).


<noscript>
	The following uses MathJax, 
	<strong>
		make sure you have JavaScript enabled!
	</strong>
</noscript>

<script>
MathJax = {
	tex: {
		inlineMath: [ ['$','$'], ["\\(","\\)"] ],
		displayMath: [ ['$$','$$'], ["\\[","\\]"] ],
	},
};
</script>
<div style="display:none">
$
  \newcommand{\PP}{\mathbb{P}}
  \newcommand{\RR}{\mathbb{R}}
  \newcommand{\EE}{\mathbb{E}}
  \newcommand{\eps}{\varepsilon}
  \newcommand{\defas}{≔} % {\coloneqq}
  \newcommand{\1}{𝟙}
$
</div>
<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-chtml.js"></script>

## Results

These results have been introduced in the large deviation theory of random dynamical  systems by Freidlin and Wentzell. 
The idea of using graphs to compute determinants has been known since the nineteenth century and presumably goes  back to Kirchhoff.

For finite Markov chains the distribution at the time of exit from a set can be expressed explicitly as the ratio of
some determinants, i.e., sums of products consisting of transition probabilities. 
Which products appear in the various sums, can be described conveniently by means of graphs on the set of states of the chain.

### Hitting distribution

Consider a homogeneous Markov chain $(S_t)_{t \ge 0}$ with states $\{s_1, s_2, \ldots, s_n\}$ and transition function $p \colon [n] \to \Delta([n])$, and denote $p(s \to s') \defas p(s)(s')$.
Fix a subset of states $A \subseteq [n]$ and denote $\overline{A} \defas [n] \setminus S$.
We are interested in the probability that the Markov chain starting on a given state outside $A$ enters for the first time the set $A$ at a given state.
More precisely, denote the hitting time of $A$ by $\tau_A$, i.e.
\[
	\tau(A) \defas \min \{ t \ge 0 : X_t \in A \}
\]
We are interested in, for each $s \in \overline{A}$ and $s' \in A$, 
\[
	\PP \left( S_{\tau(A)} = s' \middle| S_0 = s \right)
\]

Consider functions $f \colon \overline{A} \to [n]$.
Each function naturally generates a graph $G_f$ on vertices $[n]$ containing the edge $(s, s') \in  \overline{A} \times [n]$ only if $f(s) = s'$.
Denote $F(A)$ the set of all functions $f \colon \overline{A} \to [n]$ whose graph does not contain a cycle.
For $s \in \overline{A}$ and $s' \in A$, denote $F(A, s \to s')$ the subset of $F(A)$ where $s$ is connected to $s'$ in the corresponding graph.
Define the "probability" of a function by
$\pi \colon F(S) \to [0, 1]$ given by
\[
	\pi(f) \defas \prod_{s \in \overline{S}} p(s \to f(s))
\]

The main result states that, for all $s \in \overline{A}$ and $s' \in A$,
\[
	\PP \left( S_{\tau(A)} = s' \middle| S_0 = s \right) \left( \sum_{f \in F(A)} \pi(f) \right) = \sum_{f \in F(A, s \to s')} \pi(f)
\]

**Example**
Consider a Markov chain given by the following matrix.
\[
	\begin{pmatrix}
		0 & 0.5 & 0.5 & 0 \\
		0.5 & 0 & 0.25 & 0.25 \\
		0 & 0 & 1 & 0 \\
		0 & 0 & 0 & 1 \\
	\end{pmatrix}
\]
States $s_1$ and $s_2$ are transient, and state $s_3$ and $s_4$ are absorbing. 

*Question*
Starting from state $s_1$, what is the probability of being absorbed in state $s_3$ rather than state $s_4$?

Consider the set of absorbing states $A \defas \{ 3, 4 \}$.
Then, the previous result gives us an equation for the probability of interest.
To apply it, we need to understand $F(A)$ and the probability of each of its functions.

In this case, $F(A)$ contains the following functions
- $(1 \to 2, 2 \to 3)$
- $(1 \to 2, 2 \to 4)$
- $(1 \to 3, 2 \to 1)$
- $(1 \to 3, 2 \to 3)$
- $(1 \to 3, 2 \to 4)$

The "probability" of each of these are 
- 0.125
- 0.125
- 0.25
- 0.125
- 0.125
These weight sum up to $0.75$, and considering only those functions that connect state $s_1$ with state $s_3$ the sum is only $0.625$.
Therefore, 
\[
	\PP \left( S_{\tau(A)} = s_3 \middle| S_0 = s_1 \right) = \frac{0.625}{0.75} = \frac{75}{90} \approx 0.833
\]

### Discounted occupation time

Consider a homogeneous Markov chain $(S_t)_{t \ge 0}$ with states $\{s_1, s_2, \ldots, s_n\}$ and transition function $p \colon [n] \to \Delta([n])$, and denote $p(s \to s') \defas p(s)(s')$.
We are interested in the number of times the dynamic spends in a particular state, discounted over time.
More precisely, for each $i, j \in [n]$ and $\lambda \in (0, 1)$, we are interested in 
\[
	\EE \left( (1 - \lambda) \sum_{t \ge 0} \lambda^t \1[S_t = s_j] \middle| S_0 = s_i \right)
\]

Following a construction by Solan, for each $\lambda \in (0, 1)$, we can interpret the discounted time as a hitting probability.
Indeed, consider a Markov chain with state space $[2n]$.
The transition function $q \colon [2n] \to \Delta([2n])$ incorporates the discount factor as follows
\[
	q(s_i) = (1 - \lambda) \1[s_{n + i}] + \lambda p(s_i) \\
	q(s_{n + i}) = \1[s_{n + i}]	
\]

Then, taking $A \defas [2n]\setminus[n]$, we have that, for all $i, j \in [n]$, 
\[
	\EE_p \left( (1 - \lambda) \sum_{t \ge 0} \lambda^t \1[S_t = s_j] \middle| S_0 = s_i \right) = \PP_q \left( S_{\tau(A)} = s_{j + n} \middle| S_0 = s_i \right)
\]
In other words, recalling that $F(A)$ is defined in the constructed Markov chain, we have that
\[
	\EE \left( (1 - \lambda) \sum_{t \ge 0} \lambda^t \1[S_t = s_j] \middle| S_0 = s_i \right) \left( \sum_{f \in F(A)} (1 - \lambda)^{|f([n]) \cap [2n] \setminus [n]|} \lambda^{|f([n]) \cap [n]|} \prod_{k \in [n]} p(s_k \to f(s_k)) \right) = \sum_{f \in F(A, s_i \to s_{j+n})} (1 - \lambda)^{|f([n]) \cap [2n] \setminus [n]|} \lambda^{|f([n]) \cap [n]|} \prod_{k \in [n]} p(s_k \to f(s_k))
\]
where, if $f(i) \in [2n]$, then $p(s_k \to f(s_k)) \defas p(s_k \to (f(s_k) - n))$.

**Example**
Consider a deterministic cycle of length three.
The discounted occupation time starting from $s_1$ on $s_1$ is 
\[
	(1 - \lambda) \sum_{t \ge 0} \lambda^{3t} 
		= \frac{1 - \lambda}{1 - \lambda^3}
		= \frac{}{1 + \lambda + \lambda^2}
\]

Applying the theorem we get the same conclusion.
Indeed, the set $F(A)$ consists of the following functions
- $(1 \to {1 + 3}, 2 \to 3, 3 \to 1)$
- $(1 \to {1 + 3}, 2 \to 3 + 3, 3 \to 1)$
- $(1 \to {1 + 3}, 2 \to 3, 3 \to 1 + 3)$
- $(1 \to {1 + 3}, 2 \to 3 + 3, 3 \to 1 + 3)$
- $(1 \to 2, 2 \to 3 + 3, 3 \to 1)$
- $(1 \to 2, 2 \to 3, 3 \to 1 + 3)$
- $(1 \to 2, 2 \to 3 + 3, 3 \to 1 + 3)$

Their weights are the following
- $(1 - \lambda)^{1} \lambda^{2}$
- $(1 - \lambda)^{2} \lambda^{1}$
- $(1 - \lambda)^{2} \lambda^{1}$
- $(1 - \lambda)^{3} \lambda^{0}$
- $(1 - \lambda)^{1} \lambda^{2}$
- $(1 - \lambda)^{1} \lambda^{2}$
- $(1 - \lambda)^{2} \lambda^{1}$
from which only the first four for connect $1$ with $1 + 3$.
Therefore, 
\[
	\EE \left( (1 - \lambda) \sum_{t \ge 0} \lambda^t \1[S_t = s_j] \middle| S_0 = s_i \right)
		= \frac{(1 - \lambda) \lambda^{2} + 2 (1 - \lambda)^{2} \lambda + (1 - \lambda)^{3}}{3 (1 - \lambda) \lambda^{2} + 3 (1 - \lambda)^{2} \lambda + (1 - \lambda)^{3}}
		= \frac{ 1 - \lambda }{ 1 - \lambda^3 }
		= \frac{ 1 }{ 1 + \lambda + \lambda^2 }
\]
