---

layout: post
title:  "Coarse correlated equilibrium is too lax"
date:   2024-07-15 00:00:00 +0000
front:  false

---

# Coarse correlated equilibrium is too lax

The concept of equilibrium in Game Theory intends to predict the outcome of a game.
Sometimes, the equilibrium shoul be thought of the strategy profile that players get to play after knowing the game very well.
To know the game well, they must have played the game, so there are natural interpretations of equilibria in repeated games. 
Also, there is Evolutionary Game Theory, which tries to identify equilibria that a population of agents would arrive to, if given enough time.

In Learning Theory (and before), there is the concept of "Coarse correlated equilibrium", which is defined as follows.

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
$
</div>
<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-chtml.js"></script>

Consider a multi-player normal form game $(I, A, u \colon A^I \to \RR^I)$, where $I$ is the set of players, $A$ the set of actions for each player, and $u$ the payoff function in vector form.
A distribution over strategy profiles $\mu \in \Delta(A^I)$ is said to be a coarse correlated equilibrium if, for every player $i \in I$ and every action $a \in A$, 
<math display="block" class="tml-display" style="display:block math;">
  <semantics>
    <mrow>
      <msub>
        <mi>𝔼</mi>
        <mrow>
          <mi>σ</mi>
          <mo>∼</mo>
          <mi>μ</mi>
        </mrow>
      </msub>
      <mo form="prefix" stretchy="false">(</mo>
      <msub>
        <mi>u</mi>
        <mi>i</mi>
      </msub>
      <mo form="prefix" stretchy="false">(</mo>
      <mi>σ</mi>
      <mo form="postfix" stretchy="false">)</mo>
      <mo form="postfix" stretchy="false">)</mo>
      <mo>≥</mo>
      <msub>
        <mi>𝔼</mi>
        <mrow>
          <mi>σ</mi>
          <mo>∼</mo>
          <mi>μ</mi>
        </mrow>
      </msub>
      <mo form="prefix" stretchy="false">(</mo>
      <msub>
        <mi>u</mi>
        <mi>i</mi>
      </msub>
      <mo form="prefix" stretchy="false">(</mo>
      <msub>
        <mi>σ</mi>
        <mrow>
          <mo form="prefix" stretchy="false" lspace="0em" rspace="0em">−</mo>
          <mi>i</mi>
        </mrow>
      </msub>
      <mo separator="true">,</mo>
      <mi>a</mi>
      <mo form="postfix" stretchy="false">)</mo>
      <mo form="postfix" stretchy="false">)</mo>
      <mspace width="0.1667em"></mspace>
      <mo separator="true">.</mo>
    </mrow>
    <annotation encoding="application/x-tex">\mathbb{E}_{\sigma \sim \mu}( u_i(\sigma) ) \ge \mathbb{E}_{\sigma \sim \mu}( u_i(\sigma_{-i}, a) ) \,.</annotation>
  </semantics>
</math>

In other words, every player is better in expectation if they play according to $\mu$ than if they unilaterally and without disturbing the other players change their actions by a fix action all the time.

The best interpretation of this equilibrium concept I know if is as follows.
- Imagine the coordinator send a closed envelop to every player.
- Each envelop contains an action for them to play.
- The distribution over action profiles is commonly known and follows $\mu$.
- Once the player receives the envelop can choose between: open the envelop and play that action; or never open the envelop and do what they want.
Under this dynamic, coarse correlated equilibrium is a usual Nash equilibrium. 
Sounds good, right? 
We will see that there are very strong assumptions in this dynamic.

## Example

The following example is a variation of a game that appeared in [No-regret dynamics and fictitious play](https://doi.org/10.1016/j.jet.2012.07.003).
The game has tow players and four actions per player.
The payoff function is given by the following table.
<table>
    <caption>Table 1</caption>
    <thead>
        <tr>
            <th></th>
            <th>Action 1</th>
            <th>Action 2</th>
            <th>Action 3</th>
            <th>Action 4</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <th>Action 1</th>
            <td>3, 3</td>
			<td>3, 2</td>
			<td>0, 0</td>
			<td>0, -1</td>
        </tr>
        <tr>
            <th>Action 2</th>
            <td>2, 3</td>
			<td>2, 2</td>
			<td>-1, 0</td>
			<td>-1, -1</td>
        </tr>
        <tr>
            <th>Action 3</th>
            <td>0, 0</td>
			<td>0, -1</td>
			<td>3, 3</td>
			<td>3, 2</td>
        </tr>
        <tr>
            <th>Action 4</th>
            <td>-1, 0</td>
			<td>-1, -1</td>
			<td>2, 3</td>
			<td>2, 2</td>
        </tr>
    </tbody>
</table>

Actions 2 and 4 are strictly dominated for both players by actions 1 and 3 respectively.
Basically, players should never play them.
But there is a coarse correlated equilibrium that is supported only on these actions:
$1/2$ action $(2, 2)$ and $1/2$ action $(4, 4)$ is a coarse correlated equilibrium.

I can only explain this equilibria as follows: given that you know that the other player will play *irraltionally* actions $2$ and $4$ uniformely, your best option is to play as they do... and their action is given inside the envelop of the coarse correlated equilibrium.  
