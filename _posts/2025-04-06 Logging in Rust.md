---

layout: post
title:  "Logging in Rust"
date:   2025-04-06 00:00:00 +0000
front:  false

---

How to implement logging in Rust libraries and applications?

There are of course various approaches, but I want to highlight one of them now: `log` + `fastrace` + `logforth`.
- `log` is the standard crate for logging in Rust. It provides a common language throughout the ecosystem.
- `fastrace` implements distributed tracing on top of `log` API.
- `logforth` is a flexible logging implementation for applications.

[Here is an article focusing on `fastrace`](https://fast.github.io/blog/fastrace-a-modern-approach-to-distributed-tracing-in-rust/) explaining most of the reasons for this setup, including the difference between `fastrace` and `tokio-rs/tracing`.