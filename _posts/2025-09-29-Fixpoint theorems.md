---

layout: post
title:  "Fixpoint theorems"
date:   2025-09-29 00:00:00 +0000
front:  false

---

This is a list of fix-point theorems that I have seen are useful in Game Theory.

## Browwer

**Theorem**
Every continuous function from a closed simplex (in any dimension) to itself has a fixed point.

```bib
@article{Knaster1929,
author = {Knaster, Bronisław, Kuratowski, Casimir, Mazurkiewicz, Stefan},
journal = {Fundamenta Mathematicae},
language = {ger},
number = {1},
pages = {132-137},
title = {Ein Beweis des Fixpunktsatzes für n-dimensionale Simplexe},
url = {http://eudml.org/doc/212127},
volume = {14},
year = {1929},
}
```

## Schauder

**Theorem**
Every continuous function from a nonempty convex compact subset K of a Banach space to K itself has a fixed point.

## Kakutani 

This considers functions mapping a point to a set.

**Upper semi-continuous**
A function f is upper semi-continuous if when (x_n) \to x, y_n \in f(x_n) for all n, and (y_n) \to y, then y \in f(x).

**Theorem**
Every upper semi-continuous function from a simplex to the family of closed convex subsets of itself has a point that is included in its image.

```bib
@article{kakutani1941,
  title = {A Generalization of {{Brouwer}}'s Fixed Point Theorem},
  author = {Kakutani, Shizuo},
  year = {1941},
  journal = {Duke Mathematical Journal},
  volume = {8},
  number = {3},
  doi = {10.1215/S0012-7094-41-00838-4},
}
```


## Glicksberg

Kakutani's fixed point theorem states that in Euclidean space a closed point to (nonvoid) convex set map of a convex compact set into itself has a fixed point. 
Kakutani showed that this implied the minimax theorem for finite games. 
The object of Glicksberg is that Kakutani's theorem can be extended to convex linear topological spaces, and implies the minimax theorem for continuous games with continuous payoff as well as the existence of Nash equilibrium points.

**Closed graph**
The graph of a function f: X \rightrightarrows X is the set of points (x, f(x)). The set of a function is said to be closed if the corresponding set is closed in X \times X.

**Theorem**
Consider S a convex compact subset of a convex Hausdorff linear topological space. 
Every function with closed graph from S to the family of closed convex subsets of S has a point that is included in its image.

```bib
@article{glicksbergFurtherGeneralizationKakutani1952,
  title = {A {{Further Generalization}} of the {{Kakutani Fixed Point Theorem}}, with {{Application}} to {{Nash Equilibrium Points}}},
  author = {Glicksberg, I. L.},
  year = {1952},
  month = feb,
  journal = {Proceedings of the American Mathematical Society},
  volume = {3},
  number = {1},
  pages = {170},
  doi = {10.2307/2032478},
}
```

## Eilenberg–Montgomery

Applies to (non necessarily convex) acyclic absolute neighborhood retract.

**Acyclic**
A compact metric space S is said to be acyclic if:
1. S is non-vacuous
2. the homology groups H_q(x) vanish for q > 0
3. the reduced 0-th homology group \tilde{H}_0(x) vanishes.

**Absolute neighborhood retract**
Check out the [wikipedia page](https://en.wikipedia.org/wiki/Retraction_(topology)#Absolute_neighborhood_retract_(ANR)) for an explanation.

**Theorem**
Let S be an acyclic absolute neighborhood retract.
Every function with closed graph from S to the family of convex subsets of S has a point that is included in its image.

```bib
@article{eilenbergFixedPointTheorems1946,
  title = {Fixed {{Point Theorems}} for {{Multi-Valued Transformations}}},
  author = {Eilenberg, Samuel and Montgomery, Deane},
  year = {1946},
  journal = {American Journal of Mathematics},
  volume = {68},
  number = {2},
  pages = {214},
  doi = {10.2307/2371832},
}
```