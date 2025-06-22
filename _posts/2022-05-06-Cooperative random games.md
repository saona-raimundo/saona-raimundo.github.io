---

layout: post
title:  "Cooperative random games"
date:   2022-05-06 00:00:00 +0000
front: 	true
categories: 
  - Mathematics
  - Questions

---

The following is an open research question for which I would be happy to have an answer. Please contact me if you have ideas.

The model is in cooperative matrix games and the question is about hardness of computation of equilibria.

In cooperative one-shot games, there is a matrix with payoff for single actions from each of the players. In contrast to zero-sum games where one player pays the other, each player gets the entry of the matrix. Players can not communicate before the game.

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
  \newcommand{\EE}{\mathbb{E}}
  \newcommand{\eps}{\varepsilon}
  \newcommand{\defas}{≔} % {\coloneqq}
$
</div>
<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-chtml.js"></script>


For example, if the matrix is
\\[
	\begin{bmatrix}
		1	&	0	\\\\
		0	&	0
	\end{bmatrix} \,,
\\]
players play *up* and *left* respectively and get $1$. On the other hand, foe the payoffs
\\[
	\begin{bmatrix}
		1	&	0	\\\\
		0	&	1
	\end{bmatrix} \,,
\\]
since there is no communication, players are confused between their two possible actions and the best they can do is to play randomly. This last game has a value of $1/2$.

If the pay-off matrix $S \in \RR^n$ is symmetric, we can define the value of the game as follows.
\\[
	v(S)
		\defas \max\_{p \in \Delta([n])} p^t S p 
		= \max\_{p \in \RR^n} \frac{ p^t S p }{ ||p||\_1 } \,.
\\]

**Question.**
Given a rational symmetric matrix $S$, what is the complexity computing or approximating $v(S)$?

## Random games

Now, turning to random game model, consider that each entry of $S = (S\_{i, j})\_{i, j \in [n]}$ is a random variable. More precisely, consider that, for $i \in [n]$, $S\_{i, j} \sim \mathcal{N}(0, 2)$ and that, for $i \not = j \in [n]$, $S\_{i, j} \sim \mathcal{N}(0, 1)$.

Assuming that computing $v(S)$ is computationally difficult, we consider $\EE(v(S))$. Note that,

**Lemma.** 
\\[
	\EE \left( \max\_{i \in [n]} \mathcal{N}(0, 2) \right) \approx 2 \sqrt{\log(n)} \,.
\\]

**Corollary.**
\\[
	\EE(v(S)) \ge 2 \sqrt{\log(n)} \,.
\\]


*Proof.*
Player may play the row or column in which the biggest diagonal element is. &#9724;


Consider the new symmetric matrix $\tilde{S} \defas S - 2 \sqrt{\log(n)} I$. Now, it is not clear if the rest of the matrix allows the players to obtain a good value. Notice that there should be enough payoffs left.
**Lemma.** 
\\[
	\EE \left( \max\_{i \not = j \in [n]} \mathcal{N}(0, 1) \right) \approx 2 \sqrt{\log(n)} \,.
\\]

**Corollary.**
\\[
	\EE(v(\tilde{S})) \ge \sqrt{\log(n)} \,.
\\]

*Proof.*
Denote $i^{\*}, j^{\*}$ the row and column of the largest element of $\tilde{S}$. Player may play the strategy $(\delta\_{i^{\*}} + \delta\_{j^{\*}}) / 2$, i.e. randomly choosing one of them, and obtain $\sqrt{\log(n)}$ in expectation. &#9724;

**Question.**
Can players recover $2 \sqrt{\log(n)}$ in the game with payoffs $\tilde{S}$?


