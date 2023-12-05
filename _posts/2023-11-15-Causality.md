---

layout: post
title:  "Causality Theory"
date:   2023-11-15 00:00:00 +0000
front: false

---

Classical Probability Theory is incapable to distinguish causal relationship in general.
Therefore, causality is not study "only" using Prbability.
This is an introduction to the models used in Causality Theory.

## Introduction

Probabilistic models summarize a phenomena by a probability distribution: a function that assigns chances to each possible observation of the phenomena. 
The probability distribution is a summary of an emergent pattern when the phenomena is repeatedly observed.

For example, you see a signal repeatedly often: 0, 1, 0, 0, 1, 1, ... 
After some time, you notice that time there are as many zeros as ones. 
Make the simplification that: (1) every time you see the signal is independent from previous signals; (2) no matter how you interact with the signal, the behaviour of the signal is always the same. 
Then, there is a probabilitic model of the phenomena that allow us to answer questions about the behaviour of the observations of this signal.

Causal models summarize a phenomena by a mechanical process for the phenomena to unfold. 
This is usually represented by a causal graph, although some causal models require more than only a graph.

For example, you see a signal repeatedly often: 0, 1, 0, 0, 1, 1, ... 
After some time, you a person is controlling the signal on the other side of a wall. 
You can not observe the person, but you know what the controller can and can not do to change the signal. 
There may be various ways to send a signal of 1 and only observing the signal 1 does not allow us to determine what the person did.
After some assumptions and observations, we could answer questions about how the person is using the controller. 

## Hierarchy of questions

The following hierarchy is given by Pearl to classify questions and what is needed to answer them.

### Association (seeing)

What if I see ...? 
How would seeing X change my belief about Y?

In this type of questions we are purely observing the phenomena and can not intervene on it in any way. 
Be careful, deciding what to do knowing that you will interfere or change the phenomena purely on association is a bad idea!

Example: "if there is a sunny day, will there be less car accidents?"

### Intervention (doing)

What if I do ...?
What would Y be if I do X?

This type of questions require you to do something, to force part of the phenomena to be something and then the rest of the phenomena will unfold, interacting with your modification and therefore leading to possibly new results.

Example: "if I take this medicine, will I be cured?"

### Counterfactual (imagining)

What if I had done ...?
Was it X that caused Y? 
What if X had not ocurred?
What if I had done something differently?

This type of questions require you to repeat the phenomena while interacting with it. Usually, we think of this in either very controlled experiments, or in our imagination.

Example: "Would I had share my evening with that person if I had said hi?"


## References

- [The Book of Why](https://en.wikipedia.org/wiki/The_Book_of_Why)
	- Accessible introduction to causality
- [Causal Inference in Statistics: A Primer](https://www.wiley.com/en-us/Causal+Inference+in+Statistics%3A+A+Primer-p-9781119186847)
	- Technical introduction to the field
- [Causal Reasoning Through Intervention](https://www.ucl.ac.uk/lagnado-lab/publications/lagnado/intervention%20hagmayer%20et%20al.pdf)
- [Interventions and Causal Inference](https://www.cmu.edu/dietrich/philosophy/docs/scheines/PSA2006.pdf)
