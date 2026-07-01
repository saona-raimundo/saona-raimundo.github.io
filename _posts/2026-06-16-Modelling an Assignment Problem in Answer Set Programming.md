---

layout: post
title:  "Modelling an Assignment Problem in Answer Set Programming"
date:   2026-06-16 00:00:00 +0000
front:  true

---

This is a tutorial on how to model, encode, and solve assignment problems. We make it concrete in the following example, hoping you can adapt to your needs.

**Task:** Assign a supervisor and a marker to each student project, subject to: 
- workload caps (not too much work for anyone)
- quality assurance per project (the team supervisor+marker should be trusted)
- forbidden pairings (restrict assignments)
- individual preferences of workers over projects (respect preferences)

The task is small enough that a spreadsheet feels tempting, and large enough that a spreadsheet is hopeless. We want a specification with: 
- what counts as a valid assignment
- desired criteria to optimize, the search is left to a solver

**Tools:** [Clingo](https://potassco.org/clingo/), the answer-set solver in the Potassco toolchain. You can [run Clingo in your browser](https://potassco.org/clingo/run/). My intent is not to advocate for ASP over its alternatives (please use whatever you want to solve your problems). I want to show, step by step, how each requirement maps to a small modelling pattern.

**Audience:** Comfortable with logic or constraint programming and want to see a real encoding.

---

## Setting up the domain

Define the variables.

> There are 56 projects and 23 workers.

```prolog
project(p(1..56)).
worker(w(1..23)).
```

`p(n)` and `w(n)` are distinct "ground terms". For reference, semicolons inside the parentheses let you mix ranges and singletons: `p(1..9; 12)` gives `p(1)` through `p(9)` and `p(12)`.

The answer we want is a list of assignment of workers to projects as supervisor and as marker. For example, 

``` prolog
supervision(w(1), p(10)), ...
marking(w(1), p(3)), ...
```

Fear not, it is easy to visualize this in a graph later on.

---

## Forcing the assignment

A first attempt to say "each project has a supervisor" might be:

```prolog
project(P) :- supervision(W, P).
```

This rule means:

> if there's a supervision atom `supervision(W, P)` assigning W to P, then P is a project.

Run this and the solver returns a model with no assignements. The constraint is vacuously satisfied: nothing in the program *generates* a `supervision` atom, so the solver picks the simplest assignment, which is no supervision atoms at all.

The behaviour may be unfamiliar if you come from Prolog or from a constraint solver. In a constraint solver (MiniZinc, CP-SAT, an MIP) you declare your decision variables first and the solver must assign every variable a value. The variables exist as a precondition of the search. ASP works the other way around: predicates are sets of atoms, and an atom belongs to the set only if some rule derives it. Constraints (... :- ...) eliminate candidate models; they do not populate predicates. With no rule generating supervision, the smallest set satisfying every rule is the empty one.

To generate supervision and marking atoms:
	
> Every project must have one worker as supervisor and one worker as marker.

```prolog
1 { supervision(W, P) : worker(W) } 1 :- project(P).
1 { marking(W, P)     : worker(W) } 1 :- project(P).
```

The lowerbound `1` and upperbound `1` make this an *exact-cardinality* choice. 

The shape of this constraint is "domain on the left of the colon, guard on the right". Once internalised, it covers most of the combinatorial structure one needs.

Forbidding a worker from supervising and marking the same project is a one-liner:

> No worker supervises and marks the same project.

```prolog
:- supervision(W, P), marking(W, P).
```

---

## Defaults with sparse overrides

We have a couple of features for each worker, and we would like to specify some features of some workers. Our approach is to define a feature with a default value that gets "manually" overridden.

For example, we could have "trust" meaning how confident we are to assign a project to a worker.

> Every worker has a level of trust, with 100 as default.

```prolog
trust(W, V)   :- trust_explicit(W, V).
has_trust_explicit(W) :- trust_explicit(W, _).
trust(W, 100) :- worker(W), not has_trust_explicit(W).
```

This gives a (default) trust of 100, which can be overridden as follows.

> Worker 1 has trust 50.

```prolog
trust_explicit(w(1), 50).
```

Now that we have trust values, how can we use them to ensure that we have enough trust in every team supervisor+marker?

---

## Joint trust

Each allocated project needs supervisor and marker whose trust values *jointly* meet a threshold.

> Every team supervisor+marker should be "trusted".

```prolog
:- project(P), #sum { T,W,P,s : supervision(W, P), trust(W, T); T,W,P,m : marking(W, P),     trust(W, T) } < 100.
```

Note that `project(P)` makes the rule apply to every project. We previously enforced that workers can not be assigned to projects as both supervisor and marker, so every tuple `(T,W,P)` appears only once. The tags `s` and `m` are used to count correctly (in general): aggregate elements in ASP are *sets* of tuples, so tuples that are equal collapse into one and are counted only once. Without the tags, if the supervisor and marker happened to have equal trust, the two contributions would collapse into a single set element and the sum would count once. 

## Workload caps

Each worker should not be assigned too much work: we can define default values for each worker, and specify specific cases by hand, just like we did with trust.

> Each worker has a maximum amount of work of 5 projects in total.

```prolog
max_work(W, V)   :- max_work_explicit(W, V).
has_max_work_explicit(W) :- max_work_explicit(W, _).
max_work(W, 5) :- worker(W), not has_max_work_explicit(W).
```

> Worker 1 can have a maximum work load of 10.

```prolog
max_work_explicit(w(1), 10).
```

Then, we can enforce this maximum work load as follows.

> Every worker can not work more than their max_work.

```prolog
:- max_work(W, M), M+1 #count { P,s : supervision(W, P); P,m : marking(W, P) }.
```

Note that we use again the tags `s` and `m` to count correctly, and we are enforcing an upper bound of `M` by saying that a lower bound of `M+1` is prohibited.

---

## Workload balance

Although a maximum work is a simple restriction, it does not take into account the nature of the work (supervision or marking). We would like to balance the workload for each worker.

> For every worker, denote s the number of supervisions and m the number of markings assigns. Then, we force (s is at most m + 2) and (m is at most s + 1).

```prolog
:- worker(W),
   S = #count { P : supervision(W, P) },
   M = #count { P : marking(W, P) },
   S - M > 2.

:- worker(W),
   S = #count { P : supervision(W, P) },
   M = #count { P : marking(W, P) },
   M - S > 1.
```

Note that hard fairness can make the problem unsatisfiable under tight capacity. If you cut these thresholds too aggressively, the solver returns `UNSAT` and you must either relax them, softening them into objectives to optimize.

## Forced and forbidden assignments

Specific worker-project assignments could be desired or need to be discarded.

> Assign worker 1 to project 1.

```prolog
supervision(w(1), p(1)).
```

> Do not assign worker 1 (as supervisor or marker) to project 2.

```prolog
forbid_assignment(w(1), p(2)).

:- supervision(W, P), forbid_assignment(W, P).
:- marking(W, P),     forbid_assignment(W, P).
```

This is dull but worth showing because it is the right pattern for *any* exclusion: name the relation and write the integrity constraint. Adding more exclusions is then a one-line edit.

---

## Preferences

Encoding and eliciting preferences can take many forms. Let's consider the simplest case: a binary preference "do you like this project?".

> worker 1 likes project 1.

```prolog
preference(w(1), p(1)).
```

One could encode rankings, bundles, etc. This approach is simple to handle both when asking workers and when optimizing the final assignment.

## Optimization: multi-level instead of a single objective

From classic optimization, the instinct is to "maximize the number of preferences satisfied":

> Maximize the number of supervisions that are preferred by workers.

```prolog
#maximize { 1,W,P : supervision(W,P), preference(W,P) }.
```

This is a utilitarian sum, and it fails in a way that is easy to overlook until you see it on real data. We hit it concretely: one person had four preferences, which coincided with the preference of someone else. The solver satisfied one person's preferences only and left the other person with nothing they had preference for. From the standpoint of the sum, this was optimal. From the standpoint of the person who got nothing, it was the worst possible outcome.

The fix is to take optimization in steps: first find assignments that maximize the number of workers that get at least one preference. Then, optimize on something else among these assignments. 

> A worker is "happy" if they get the supervision of a project they like. Maximize the number of happy workers.

```prolog
happy(W) :- supervision(W, P), preference(W, P).

#maximize { 1@5,W : happy(W) }.
```

The `@5` is a priority level. Clingo's `#minimize` and `#maximize` directives stack: higher priorities dominate lower ones lexicographically. The solver first finds the maximum number of happy workers. Then, among solutions that achieve that maximum, optimises whatever sits at the next priority.

---

## Diversity of teams

A team is composed of a supervisor and a marker. Depending on your approach, you may want to maximize or minimize the number of teams. Both positions can be argued, we opted to mazimize the number of teams. To do so, we minimize the number of times the same team is assigned projects.

> Minimize the number of times a team is assigned to more than one project.

```prolog
together(W1, W2, P) :- supervision(W1, P), marking(W2, P), W1 < W2.
together(W1, W2, P) :- marking(W1, P), supervision(W2, P), W1 < W2.

repeated_pair(W1, W2, P) :- together(W1, W2, P), together(W1, W2, P2), P2 < P.

#minimize { 1@4,W1,W2,P : repeated_pair(W1, W2, P) }.
```

The `repeated_pair` makes the pair unordered, so swapping supervisor and marker still counts as the same pairing. `repeated_pair` atom exists for every occurrence of a pair *after* its first, so each extra co-occurrence contributes exactly one penalty unit.

---

## Staying close to a reference

A subtle issue with this kind of model is that equally optimal solutions can look very different. Rerun on the same instance after a small change and you may get an assignment that has nothing in common with the previous one: equally optimal, but disconcerting to anyone who had already started planning around the old version.

The fix is a tiebreaker. Encode the previous solution as facts and penalise deviations at the lowest priority level:

```prolog
reference_supervision(w(1),  p(1)).
% ...
reference_marking(w(1),  p(2)).
% ...

mismatch(sup, W, P)  :- reference_supervision(W, P), not supervision(W, P).
mismatch(mark, W, P) :- reference_marking(W, P), not marking(W, P).

#minimize { 1@0,Role,W,P : mismatch(Role, W, P) }.
```

`@0` is below every real objective, so the reference cannot override them — it only chooses among solutions that are otherwise tied. Comment the block out when you want a clean run.

---

## Output

### From `w(1)` to a worker's name

After all the encoding, we can ask the solver to print specific atoms of the assignment it found.

> Show the assignments of the solution found.

```prolog
#show supervision/2.
#show marking/2.
```

You will see atoms like `marking(w(1),p(1))`, but we can do better: we can encode names of projects and workers, and show the assignment in those terms.

> Show the assignment in terms of names, project title, and role.


```prolog
name(w(1), "John Smith").
%...

project_title(p(1), "Title").

assignment(Name, Title, "supervisor") :- supervision(W, P), name(W, Name), project_title(P, Title).
assignment(Name, Title, "marker") :- marking(W, P), name(W, Name), project_title(P, Title).

#show assignment/3.
```

Note that `#show` suppresses any other output. The solver now emits a list of labelled triples that is straightforward to post-process.

### Solver output is not line-oriented

This is about the behavior of the `clingo` command line application. If you feed `clingo`'s answer-set output into a pipeline that splits on newlines, you will eventually be surprised: long answer sets wrap, and atoms whose string arguments contain spaces (`assignment("Sponsor X 2026#1", ...)`) break naively across lines. The pragmatic fix is to rejoin before parsing. Then, regex on the single joined string. Worth knowing the first time it bites.

## When is this the right tool?

ASP earns its place here for two reasons:

1. The constraints are heterogeneous: counts, sums, exclusions, lexicographic objectives. ASP expresses each of them in one or two lines. 
2. The problem decomposes naturally into facts (the instance) and rules (the encoding), so swapping in next year's data is a file replacement rather than a model rewrite.

The multi-level optimization is particularly clean to write, and we wanted the encoding to read like a specification.

Some warnings before you try it on your own problem:

- ASP has no floats: every numeric quantity must be integer. 
- ASP may timeout trying to prove that an instance is infeasible: as a rule of thumb, if the solver is taking too long, the problem is most likely unfeasible (and it is trying to prove it).

---

## The complete final encoding

For reference, the full encoding follows. We have stripped instance-specific data (names, sponsors, exact preference lists) to keep the focus on structure; the patterns above are sufficient to rebuild your own instance file.

```prolog
project(p(1..56)).
worker(w(1..23)).

1 { supervision(W, P) : worker(W) } 1 :- project(P).
1 { marking(W, P)     : worker(W) } 1 :- project(P).

:- supervision(W, P), marking(W, P).

trust(W, V)   :- trust_explicit(W, V).
has_trust_explicit(W) :- trust_explicit(W, _).
trust(W, 100) :- worker(W), not has_trust_explicit(W).

trust_explicit(w(1), 50).

:- project(P), #sum { T,W,P,s : supervision(W, P), trust(W, T); T,W,P,m : marking(W, P),     trust(W, T) } < 100.

max_work(W, V)   :- max_work_explicit(W, V).
has_max_work_explicit(W) :- max_work_explicit(W, _).
max_work(W, 5) :- worker(W), not has_max_work_explicit(W).

max_work_explicit(w(1), 10).

:- max_work(W, M), M+1 #count { P,s : supervision(W, P); P,m : marking(W, P) }.


:- worker(W),
   S = #count { P : supervision(W, P) },
   M = #count { P : marking(W, P) },
   S - M > 2.

:- worker(W),
   S = #count { P : supervision(W, P) },
   M = #count { P : marking(W, P) },
   M - S > 1.
   
supervision(w(1), p(1)).

forbid_assignment(w(1), p(2)).

:- supervision(W, P), forbid_assignment(W, P).
:- marking(W, P),     forbid_assignment(W, P).

preference(w(1), p(1)).

happy(W) :- supervision(W, P), preference(W, P).

#maximize { 1@5,W : happy(W) }.

together(W1, W2, P) :- supervision(W1, P), marking(W2, P), W1 < W2.
together(W1, W2, P) :- marking(W1, P), supervision(W2, P), W1 < W2.

repeated_pair(W1, W2, P) :- together(W1, W2, P), together(W1, W2, P2), P2 < P.

#minimize { 1@4,W1,W2,P : repeated_pair(W1, W2, P) }.

reference_supervision(w(1),  p(1)).
% ...
reference_marking(w(1),  p(2)).
% ...

mismatch(sup, W, P)  :- reference_supervision(W, P), not supervision(W, P).
mismatch(mark, W, P) :- reference_marking(W, P), not marking(W, P).

#minimize { 1@0,Role,W,P : mismatch(Role, W, P) }.

name(w(1), "John Smith").
%...

project_title(p(1), "Title").

assignment(Name, Title, "supervisor") :- supervision(W, P), name(W, Name), project_title(P, Title).
assignment(Name, Title, "marker") :- marking(W, P), name(W, Name), project_title(P, Title).

#show assignment/3.
```