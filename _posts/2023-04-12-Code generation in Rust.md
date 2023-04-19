---

layout: post
title:  "Code generation in Rust"
date:   2022-04-12 00:00:00 +0000
front: 	false
categories: 

---

# Code generation in Rust

So you want to write Rust code that writes Rust code? Here are your options.
- Macros
- Build script (`build.rs`)
- Source generation

When to use each of them?
- Macros
	- Available to external users in their Rust code
	- Easy to incorporate anywhere in the Rust codebase 
- Build script
	- Use external non-Rust tools
	- Generate files that can be included in Rust code
- Source generation
	- Custome code generation
	- Large code generation with custom logic

## Preliminaries

Let me explain each approach first.
Each approach has its own use.

### Macros

Macros is an advanced feature of Rust to generate code in place.
There are three types of procedural macros:
1. Derive macros (`#[derive(MyMacro)]`)
2. Attribute macros (`#[my_macro]`)
3. Functional macros (`my_macro!()`)

See [its chapter in the Rust book](https://doc.rust-lang.org/book/ch19-06-macros.html).
[This post](https://medium.com/@altaaar/a-guide-to-declarative-macros-in-rust-6f006fdaeebf) discusses declarative macros in a friendly way too. 

### Build script

A build script is a piece of code that runs before a crate is built.
Some example use cases are:
- Building a bundled C library.
- Finding a C library on the host system.
- Generating a Rust module from a specification.
- Performing any platform-specific configuration needed for the crate.

See [the reference](https://doc.rust-lang.org/cargo/reference/build-scripts.html#build-scripts).

### Source generation

We call source generation the process of generating Rust code, as a build script may do, outside of the usual compilation process, so without the help of `cargo`.
Some reasons to do this are:
1. Does not take compilation time for consumers of your crate.
2. Compilation does not depend on non-Rust code used for generation.
3. Full source code is available for other tools.
4. Full control (and responsability) over the synchronization of generated source code and the rest of the crate.

## Considerations

### Macros

Usually they require their own separate crate

TODO

### Build script

- They might not play well with other tools that analyze your crate.
	- For example, rustdoc.
		- Check out [some guidelines](https://docs.rs/about/builds#read-only-directories)

Typically you do something like this in `build.rs`:
```rust
let out_path = PathBuf::from(env::var("OUT_DIR").unwrap());
std::fs::write(out_path.join("generated.rs"), contents).unwrap();
```
Then include it in your code (e.g. in `lib.rs`) like this:
```rust
include!(concat!(env!("OUT_DIR"), "/generated.rs"));
```

### Source generation

Keeping things in sync is now your responsability.

## Examples

### Macros

- [Rust Latam conference, Montevideo Uruguay, March 2019](https://github.com/dtolnay/proc-macro-workshop)
- [`duplicate` documentation](https://docs.rs/duplicate/latest/duplicate/)

### Build script

### Source generation

- Web interface in Rust
	- [web-sys crate](https://github.com/rustwasm/wasm-bindgen/tree/main/crates/web-sys) is generated from web-idl specification files
	- [wasm-bindgen-webidl crate](https://crates.io/crates/wasm-bindgen-webidl) is the Rust code source generator that parses the web-idl specification files

- Rust-analyzer grammar
	- internal [`sourcegen` crate](https://github.com/rust-lang/rust-analyzer/tree/master/crates/sourcegen) is the infraestructure to generate the Rust code
	- Rust-analyzer generating code from `ungrammar` files (grammar specification) that uses its internal sourcegen crate
		- https://github.com/rust-lang/rust-analyzer/blob/master/crates/syntax/src/tests/sourcegen_ast.rs

- Rome grammar generator
	- Rome generating code from `ungrammar` files
		- https://github.com/rome/tools/tree/main/xtask/codegen

## Tools for writing Rust code

### Parsing input
- [`syn`](https://crates.io/crates/quote)
	- Parses a stream of Rust tokens into a syntax tree of Rust source code.
- Any parser library
	- pest, nom, pom, combine, etc...

### Writing Rust code
- [`duplicate`](https://crates.io/crates/duplicate)
- [`quote`](https://crates.io/crates/quote)
	- Turns Rust syntax tree data structures into tokens of source code.
- [`codegen`](https://crates.io/crates/codegen)
	- Builder pattern for Rust code, resulting in a `String`
- Templates
	- `format!`, `write!`, etc...
	- Write your code by interpolating strings

### Formatting Rust code
- [`prettyplease`](https://crates.io/crates/prettyplease)
	- Crate available in crates.io
- `rustfmt`
	- Format Rust code
	- Shell out to the `rustfmt` command
	- [rustfmt-wrapper crate](https://crates.io/crates/rustfmt-wrapper)
