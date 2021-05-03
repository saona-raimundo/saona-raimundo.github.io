---
layout: new
title:  IMS Student Puzzle 31
date: 2020-12-15
link: https://imstat.org/2020/12/15/solution-to-puzzle-31/
---

My solution was selected!

# Solution to Puzzle 31
December 15, 2020

## Student Puzzle Editor Anirban DasGupta writes:

Our respondent Raimundo Julian Saona Urmeneta, who is a PhD student at the Institute of Science and Technology in Austria, has done a lovely and complete job of solving the previous puzzle. Congratulations to Raimundo. We are publishing his answer [below] as an example of clarity and completeness.

The self-avoiding walk problem is incredibly diverse. Limited to the case of the square lattice as in this puzzle, it is obvious that log f(n) is subadditive, so it follows that f(n)1/n converges to some positive number μ. This is classic and appears to have been already noted in Hammersley and Morton’s 1954 JRSS(B) article. In fact, a pointwise inequality holds that is of some use in numerically approximating μ; one has f(n)≥ μn pointwise in n. A reasonable rational approximation to the value of μ is 8/3.

A delightful reference that you will enjoy is Gordon Slade’s survey article in the Princeton Companion to Mathematics.

## Raimundo’s solution:

**Imagine a particle conducting a walk on the traditional square lattice, starting at the origin (0, 0). That is, at any time during the walk, the particle goes one unit distance to either the east, or the west, or the north, or the south. An n-walk is a walk that has taken n steps. The walk is called self-avoiding if the particle does not visit any given state twice. Let f(n) denote the number of n-walks that are self-avoiding.**

**(a) Compute f(n) for n = 2, 3, and justify how you got these values.**

For n=2, the only non self-avoiding paths are those that return to the origin, which are only 4. Then, f(2) = 42 − 4 = 12. For n = 3, the first two steps of the walk must be a self-avoiding path itself. Then, the third step has three possibilities. Therefore, f(3) = 3f(2) = 36.

**(b) Compute f(4) if you can, or place it within good lower and upper bounds.**

Of all self-avoiding 3-walks, there are only 8 that can complete a square by adding a fourth step, leaving only 2 possibilities to complete a 4-walk. All other self-avoiding 3-walks have 3 possibilities for a fourth step. Therefore, f(4) = 3(f(3) − 8) + 2(8) = 84 + 16 = 100.

**(c) Give non-trivial lower and upper bounds on f(n) of the form ckn for c > 0 and k ∈ℕ.**

f(n) ≤ 4 · 3n−1 = 4/3 3n, because there are 4 initial directions and each next step has at most 3 possibilities.

f(n) ≥ 4 ·(2 · 2n−1 −1) = 4 · 2n −4, because there are 4 initial directions and then using either (i) the same initial direction, or (ii) a perpendicular direction, will result in a self-avoiding walk. This counting procedure repeats the four paths that uses one direction only, therefore we must correct the counting by subtracting 4.

These bounds mean that for all N natural numbers, there exists a constant cN > 0 such that f(n) ≥ cN · 2n and limN→∞ cN = 4.
