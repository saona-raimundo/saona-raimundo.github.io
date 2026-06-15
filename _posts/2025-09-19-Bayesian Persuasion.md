---

layout: post
title:  "Bayesian Persuasion"
date:   2025-09-19 00:00:00 +0000
front: 	false
categories: 

---

This is a very short introduction to Bayesian Persuasion: the use of information to control the belief of rational beings.

The following exercise is based on Bayesian Persuasion by Kamenica and Gentzkow.

Consider a prosecutor (Sender) and a judge (Receiver) involved in a legal process where the prosecutor’s goal is to maximize the probability of conviction, and the judge’s goal is to make a just decision.
The judge chooses between two actions: convict or acquit, based on evidence provided by the prosecutor.

The defendant is either guilty or innocent, with a prior probability of guilty of 0.3.
The prosecutor can conduct an investigation and must honestly report the results to the judge.
Investigations are modeled as signal distributions \pi( . | guilty) and \pi( . | innocent).
The judge uses Bayes’s rule to update her beliefs.
Moreover, we consider the judge to make a just decision by maximizing their expected utility.

The judge’s utility is:

Action \ Truth | Guilty | Innocent
-------------------------------------------------------
Convict          |    1     |       0
Acquit           |   0      |       1


Note that the optimal action for the judge apriori is to acquit (with utility 0.7).

We design a fair experiment that makes the judge convict with positive probability.
Suppose the prosecutor uses a binary signal {s_1, s_2} where s_1 is more likely to occur if the defendant is guilty and s_2 is more likely to occur if the defendant is innocent.
Consider the experiment where \pi( s_1 | guilty) = 0.8 and \pi( s_1 | innocent) = 0.3.

After computations, the judge's optimal action under this experiment is as follows.
Convict with probability 0.45
Acquit with probability 0.55

Should we allow the experiment to occur? Has the prosecutor persuaded the judge?
