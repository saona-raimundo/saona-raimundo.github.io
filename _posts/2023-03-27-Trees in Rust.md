---

layout: post
title:  "Trees in Rust"
date:   2022-03-27 00:00:00 +0000
front: 	false
categories: 

---

# Trees in Rust

Trees are one of the most basic data structures. So, how are they supported in Rust?

In general, you can checkout https://crates.io/keywords/tree

<table>
	<tr>
		<th>feature\crate</th>
		<th>tree-flat</th>
		<th>ego-tree</th>
		<td>description</td>
	</tr>
	<tr>
		<th>stable node id</th>
		<td>✔</td>
		<td>✔</td>
		<td>Nodes have a unique id that never invalidates</td>
	</tr>
	<tr>
		<th>root</th>
		<td>✔</td>
		<td>✔</td>
		<td>Get root id</td>
	</tr>
	<tr>
		<th>get node</th>
		<td>✔</td>
		<td>✔</td>
		<td>Get a node form an id</td>
	</tr>
	<tr>
		<th>mutate values</th>
		<td>✔</td>
		<td>✔</td>
		<td>Get mutable reference to node values</td>
	</tr>
	<tr>
		<th>children</th>
		<td>✔</td>
		<td>✔</td>
		<td>Get children of a node</td>
	</tr>
	<tr>
		<th>parent</th>
		<td>✔</td>
		<td>✔</td>
		<td>Get the parent of a node</td>
	</tr>
	<tr>
		<th>siblings</th>
		<td>✔</td>
		<td>✔ (separated in next_ and previous_siblings)</td>
		<td>Get the siblings of a node</td>
	</tr>
	<tr>
		<th>detach</th>
		<td>❌</td>
		<td>✔</td>
		<td>Node can not bea accessed anymore/td>
	</tr>
	<tr>
		<th>remove</th>
		<td>❌</td>
		<td>❌</td>
		<td>Node is not part of the tree</td>
	</tr>
</table>

✔: Efficiently implemented
❌: Should not be used for this
❓: Could be implemented?
❗: Could be efficiently implemented

There are a few utility crates that might improve your experience.
- Visualize
	- [termtree](https://crates.io/crates/termtree)
	- [treeline](https://crates.io/crates/treeline)
	- [ptree](https://crates.io/crates/ptree)
- Traverse
	- [petgraph](https://crates.io/crates/petgraph)
		- Visit, Walker
	- [traversal](https://crates.io/crates/traversal)
		- Takes reference to the tree
