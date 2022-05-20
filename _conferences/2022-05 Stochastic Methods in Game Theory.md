---
layout: event
title:  7th Workshop on Stochastic Methods in Game Theory
date: 2022-05-12
place: Erice, ETTORE MAJORANA FOUNDATION AND CENTRE FOR SCIENTIFIC CULTURE 
link: https://sites.google.com/view/erice-smgt2020/the-workshop?authuser=0
---

I presented a work on Repeated Prophet Secretary, working paper.

Here is the presentation:

<iframe src="presentations\2022-05-17 Repeated Prophet Secretary - Erice.pdf" height="400" width="700"></iframe>

About the other talks, the following are some of my notes.


{%- include mathjax_body.html -%}

## Existence of Equilibria in Repeated Games with Long-Run Payoffs

By Galit Ashkenazi-Golan. 
This work considers infinitely many players and studies the existence of $\varepsilon$-equilibria. 

The main idea is to
<center>
	consider games where players join one at a time at each stage. 
</center>

Technically,
- History-dependent finite one-shot games are constructed.
- Players play, at each stage the corresponding Nash equilibria.
- Tail-measurability implies that the value of this dynamic can be connected back with the original game.

## Some recent results on Prophet inequalities with known or unknown distributions

By Bruno Ziliotto.

A result I was not so aware of is the following.
<center>
	If the distributions of values are known to follow some distribution only, then<br/>the optimal performance is $1/e$.
</center>

The argument goes as follows.
- Prophet inequalities are thought to be a one-player problem. 
- When distributions are unkown, optimizing the expectations falls back to optimizing the probabiltiy of choosing the maximum, ie the Secretary problem. 
- In the bayesian setting, there is a prior over possible distributions.
	+ This prior can be seen as a mixed strategy of the adversary.
- By defining a zero-sum game, and proving the maxmin theorem applies, the maximum performance is still $1/e$, just as if the distribution of values were unkown.

## From Experts to Bandits. How to Overcome Losses and Feel No Regrets

By Tom Cesari.

A tutorial on experts and bandits. The difference between the settings is their observability:
<center>
	Can we see the consequences of having taken an action that we did not take?
</center>

In the setting of experts, all outcomes are observed, even for those actions that we did not take. For bandits, only the action taken can be observed.

## Congestion games with stochastic demand: from Bernoulli to Poisson

By Marc Schröder.

Congestion games have two classical models: discrete and continuous. Continuous congestion games are studied under the assumption that they arise as the limit of discrete games, but
<center>
	What are natural limits of discrete congestion games?
</center>

They propose to ways to take the limit:
- Weights of players going to zero.
- Probability of participation of players going to zero.

The probability of participation models people who have a origin-destination pair, but might not be using the routes at some particular time of the day. This model was first proposed for voting games, by Myerson, to model people who choose not to vote.

When participation goes to zero, a new limit appears: Poisson congestion games, where the number of players is random.


## Information Design, Bayesian Persuasion

By Tristan Tomala.

The following concepts were key during the talk.
- Information design
	+ Basically the study of correlated equilibria, as a designer wants to promote this type of outcomes.
- Bayesian persuasion
	+ What information structure allows me to utilize the player(s) the most?
- Anonymous games
	+ Games where the outcome only depends on the proportion of players that took some action.
	+ Example: congestion games.

## Modelling blockchain protocols: Consensus and fee markets

By Barnabé Monnot.

This was a broad introduction to Blockchain protocols, including:
- Strucuture of blockchains
- Separation in consensus and execution layers.
	+ Consensus
		* Leader selection
			- proof of work, stake or others.
		* Concensus algorithm
		* Incentives
		* Cryptography
	+ Execution
		* Resource allocation and measurements
			- How to charge for the space and computing power used by validators?

## A short and biased tutorial on Social Learning

By Nicolas Vieille.

(Could not attend, but looking into it)

## Political competition with costly adjustments

By Gaëtan Fournier.

This work is a healthy critic to the "median voter theorem". It tries to model the general feeling that "a politician who lies is bad news".

The model introduces stages where politicians give "promises"; then the population emit opinions about the presented positions; and finally politicians can change their positions.

The optimal strategies that arise are:
- Not switching, or
- Move in between your current position and the population median voter.

## Undecidability of Existence of Measurable Equilibrium Selections

By John Levy.

Consider a continuous collection of games, each of them with their own equilibria. Then, the question is
<center>
	Can I construct a measurable selection of equilibria?
</center>

Under some continuity assumptions, this is easy to answer. But only assuming that the equilibria exist makes the corresponding theorem independent of ZFC!

## The Secretary Problem with Independent Sampling

By Tim Oosterwijk.

This is the Secretary Problem with random sampling beforehand.

It is a framework that connects the no sampling setting (performance $1/e$) to the setting where values come from a known iid distributions (performance $\approx 0.58$).

## On a Competitive Selection Problem

By Dana Pizarro.

She presented a Prophet inequality setting where there are two decision makers competing for choosing values. 

The object of interest was the equilibrium payoffs (not the optimal strategies) and two models were considered:
- No recall
	+ Classical online setting
	+ There are non-symmetric equilibrium payoffs!
- Full recall
	+ Makes no sense in one-player setting
	+ Competition between players makes this setting still interesting
	+ All equilibrium payoffs are symmetric

## Identifying the Deviator

By Eilon Solan.

Assume there are two players taking turns in an infinite game and our aim is that they act in a specific way. After the players have heard our advice on each stage and acted on their own,
<center>
	can we identify who did not cooperate <br/>
	if the objective is not achieved?
</center>

There is a direct application to games: correlated equilibria are supported over the idea that players can be punished if they do not follow the advice, but can we even identify a deviation?

An illustrative example is to consider players choosing either $0$ or $1$ and our objective being that the normalize average visits $0$ infinitely many times. This would be achieved if, for example, players choose at random. 

In this case, deviators can be identified by looking 

The main theorem goes as follows. Let $T$ be a target set for histories, if $\PP(T) > 1 - \eps$, then a deviator can be identified with high probability (of the order $\sqrt{\lvert I \rvert \eps}$, where $I$ is the set of players).

## Fees, Incentives, and Efficiency in Large Double Auctions

By Simon Jantschgi.

The talk focused on inlcuding transaction costs in economical analysis. 


## Active Network and Price of Anarchy in multi-commodity routing games with variable demand

By Valerio Dose.

The shape of the Price of Anarchy for many theoretical examples is very specific:
- Increasing then decreasing
- With a non differentiable pointy maximum

This observation can be made rigurous and is valid for many models in routing games.

## Bayesian persuasion in sequential games

By Aditya Aradhye.

## Bounded Foresight in random Decision Making

By Arkadi Predtetchinski.

During life, we take decisions. Everytime we decide for something, we miss some possible future, but we can never know what would have happen if we had taken different decisions in life. What it seems to happen is that, as we get more and more experience, we can forsee more of the future of our actions.

This work tries to model this situation and compare what players can obtained, as opposed to prophets that know the future of every possible action.

The setting is a sequetial decision process where the future is revealed as the player takes actions in each stage. The player might gain forsight power as they take decisions.

## Folk Theorems in repeated games with switching costs.

By Xavier Venel. 

An extension of the folk theorem for games with switching costs.

Folks theorem characterizes the possible long-run average equilibrium payoffs. In particular, it claims that there are two properties characterizing these payoffs: feasibility and invidual rationality. The same characteristics extends when one consider switching costs.

Switching costs consists on penalities players need to pay in order to take different decisions in consecutive rounds.

# Open questions

## Secretary game - one strategic candidate

In the Secretary problem, 
- a recruiter see candidates in a random order
- after seeing a candidate, an irrevocable hiring decision must be made
- there is no previous information other than the number of candidates
- upon seeing a candidate, the relative ranking with previous options is known

The objective of the secretary is to maximize the probability of choosing the maximum.

The twist is when there is one candidate that knows their absolute ranking and can choose their position in the order.

This problem was proposed by Marco Scarsini.

### Simple setting: unaware recruiter

Given the optimal strategy of the recruiter (waiting $\lfloor n / e \rfloor$ samples and choose the next ranking), the optimal strategy for the strategic candidate is to appear at place $(\lfloor n / e \rfloor + 1)$, no matter their absolute rank.

### Game setting

When the recruiter is aware of this candidate, the optimal strategy is no longer deterministic by mixed. Actually, for the strategic candidate too.
<center>
	What is the equilibrium of this game?
</center>

## Existence of equilibria for non-regular payoffs

The objective is to push measurability of payoffs as far as possible, maintaining the existence of equilibria.

The setting considers
- Two players
- Repeated games
- Payoffs that are (borel-measurable) history-dependent and bounded.

<center>
	Is there always an equilibria in such games?
</center>

This problem was proposed by Eilon Solan.

### Related works

- Equilibria in Repeated Games with Countably Many Players and Tail-Measurable Payoffs
	- Eilon Solan, Galit Ashkenazi-Golan, Janos Flesch, and Arkadi Predtetchinski.
- In quitting games, existence of equilibria is not known




## Meeting place for uncommunicated players

Consider two people who want to meet in a cafe in the city.
They can not communicate beforehand and can try tom meet every day.
The sooner they meet the better.

<center>
	What are optimal strategies for the players?
</center>

Since there is no communication, it is natural to assume that players must play the same strategy.

This problem was proposed by Thomas Lidbetter.

### Previous works

- For #places = 3, there is an optimal strategy where players
	- Choose a random order
	- Start visitng cafes in this order
	- At the following day, with some probability they stay at the same cafe, if not the continue their order
- For #places = 4, the previous strategy is no loger optimal, ie
	- There exists a different explicit strategy that is bettter
		- This other strategy is not known to be optimal
