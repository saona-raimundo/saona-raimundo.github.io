---

layout: post
title:  "UI development in Rust"
date:   2022-12-21 00:00:00 +0000
front: 	false
categories: 

---

# UI development in Rust, 2022

There was a recent
<a href="https://poignardazur.github.io/2022/12/11/rust-gui-blog-posts-2023/">call for blogs about Rust GUI</a>. 
These are my thoughts about <em>User Interface</em>, as opposed to only the graphical part.

Before we mention things like reactivity, GPUs and others, remember: graphics is but one way to interact with the user. 
Reading through [xi-editor's plugin architecture](https://xi-editor.io/docs/plugin.html) has been one of the best sources of inspiration.
Ask yourself the following.

<strong>
	How is your application having a conversation with the user?
</strong>

From the development side, you should think about testing: how do you test your application? This is far more difficult than testing some "backend functionality". There is at least automatic controlling (web driver?) and querying elements (CSS querying?) involved.

Have all this in mind while reading through ;)

## Example: a counter

Consider a counter widget. It has two parts: 
- the (current) count displayed
- increment button

Consider the interaction of pressing the button twice, what should happen?
- Option 1:
	- Increment the count by two no matter what and report as soon as possible.
- Option 2:
	- If the buttons were clicked within 1/20 of a second, increment the count only once, otherwise increment twice.
- Option 3:
	- After the first click, disable the button until the count is updated. Then enable it again.
	- Increment the count only if the button was clicked while enabled, of course.

Here we are modelling the conversation that our application is having with the user. They all can be the correct answer depending on the widget you are using. For this counter, I prefer option 4.
- Option 4:
	- Upon the first click, if the processing takes longer than 1/60 of a second, disable the count display, but not the button. Enable the count display once it is updated.
	- Upon the second click, process the increment anyway. If the count display is disabled, then disable the button. Enable the button once the count display is updated (including this last increment).

Option 4 is a detailed model of a conversation between the user and the application. Every reaction from the application is part of the interaction they are having. Disabling the count display is saying "I am working on updating it, but you can increment more if you want". Disabling the increment button is saying "Great, but you already interacted too much with me, so give me time to process".

This is a very important design decision while developing (G)UIs. Moreover, this choice feels much like dealing with race conditions. What are the current Rust frameworks encouraging or facilitating? 

## Where does it come from?

Say I propose that `vec.push()` were an `async` operation, would you agree? Most likely not, but why would I suggest so?

In Rust, `Vec` is implemented so that when the buffer is full, it migrates its memory to a doubled-sized buffer. What if, after sending the request for pushing an element (`vec.push()`), I want to query the first element of the vector? If we were crazy for speed, we might think of accessing the first element while `Vec` is doing its migration... only if the operating system is slow enough so that the migration takes more than... 1/1000 of a second(?). Let's be clear: if the migration of memory were to take 1 minute, I would definitely like to access the first element before completing the migration.

This process does not happen in practice in `Vec` because (we assume that) operating systems are fast enough. That is why `vec.push()` is "blocking". This process does happen in (G)UIs, so you should think about it. And frameworks should give their point of view on this topic.

## Basic progression

Imagine there is a really cool function or library that you would like to interact with. The first step would be to make a command line interface application (CLI). There is even a [CLI Rust working group](https://www.rust-lang.org/governance/wgs/cli) overseeing its development, which I think is great. 

### Single functionality

The most basic interface would be solving one single task: parse the input and return output. For this, the way to go is using something like [clap](https://crates.io/crates/clap) for parsing, then do you thing and report back.

Already here, you should consider internationalization of reporting back. Think of different languages and outputting sound and not only text. Some relevant crates are the following.
- [tts](https://crates.io/crates/tts) 
	- high-level Text-To-Speech (TTS) interface
- [rust-i18n](https://crates.io/crates/rust-i18n) 
	- load localized text from a set of YAML mapping files
- [fluent](https://crates.io/crates/fluent)
	- localization system designed to unleash the entire expressive power of natural language translations 

For testing the application, you may use the following crates.
- [assert_cmd](https://crates.io/crates/assert_cmd)
	- Test CLI Applications
- [escargot](https://crates.io/crates/escargot)
	- More control over configuring the crate's binary.
- [duct](https://crates.io/crates/duct) 
	- Orchestrating multiple processes
- [commandspec](https://crates.io/crates/commandspec) 
	- Easily use multiple processes
- [assert_fs](https://crates.io/crates/assert_fs) 
	- filesystem fixtures and assertions
- [tempfile](https://crates.io/crates/tempfile) 
	- scratchpad directories
- [dir-diff](https://crates.io/crates/dir-diff) 
	- testing file side-effects

### Adding interaction

Consider prompts for more user input, a drop-down menu and such. This is basic interaction.
There is a real problem to consider when adding interaction: user expectations. Let me ask you:
- What if your program is taking too long to finish?
	- Do you report back saying "working"?
- When asking for more input... 
	- do you wait until infinity?
	- do you play a sound to call the attention of the user?
	- do you keep processing in the background? 

Basically, how do you plan the interaction with the user? 
I believe that `async` interactions are the way to go.
But, as mentioned in the counter example, there are many options to implement an interaction!

Some crates that can help you, even at the CLI level, are the following.
- [dialoguer](https://crates.io/crates/dialoguer)
	- small interactive user inputs for the command line
- [indicatif](https://crates.io/crates/indicatif)
	- report progress to users
- [howudoin](https://crates.io/crates/howudoin)
	- separates the progress producers from the consumer
- [console](https://crates.io/crates/console)
	- nice looking command line interfaces
- [asking](https://crates.io/crates/asking)
	- Async prompts
	- There are more references in the README
	- Author here :)

For testing the application, you may use the following crates.
- [rexpect](https://crates.io/crates/rexpect) 
	- test interactive CLIs

### Adding complex interactions

So far, we have not left the terminal, and sometimes you do not need to. 
To add more interactivity, you go for a terminal user interface (TUI).

Some relevant crates are:
- [tui](https://crates.io/crates/tui)
	- build rich terminal user interfaces or dashboards 
- [cursive](https://crates.io/crates/cursive)
	- focused on ease-of-use

You can do a lot without leaving the terminal!
And the basic question still apply: how do you plan the interaction with the user?

For testing the application, you may use the following crates.
- [enigo](https://crates.io/crates/enigo) 
	- control your mouse and keyboard in an abstract way on different operating systems

### Stepping out of the terminal

Graphics is but one form of interaction. As soon as you step out of the terminal, you should consider accessibility (different ways of interaction) a major concern. So far, you should consider integration with [AccessKit](https://crates.io/crates/accesskit), "UI accessibility infrastructure across platforms".

Running on desktop, mobile, web, embedded... they are totally different and the user expects a different experience in each of them. Personally, I simply go with web apps where many important problems are solved... at a price, the web model for applications. 

I have used 
- [yew](https://crates.io/crates/yew)
- [sycamore](https://crates.io/crates/sycamore)
- [druid](https://crates.io/crates/druid)

They are great and vastly different, so think about what you want before committing to one of them. 

For testing the application, you may use the following crates.
- [fantoccini](https://crates.io/crates/fantoccini) 
	- High-level API for programmatically interacting with web pages through WebDriver

### Stepping out of a single machine

The progression continuous with applications that run partly on a server, but I will not go into that.

## Pain points

What problems arise while developing applications that are not so easy to solve?
For me, everything changed when I thought of using an application as a conversation between at least two actors: the user and the application. More actors would be plugins of the application or the server. All these actors share a common resource: the interface. Are GUIs thought to <em>share</em> resources with the user, or simply getting back as soon as possible?

Consider the simple task of loading a webpage. Showing a skeleton of the site is a vast improvement in user experience. Are Rust GUIs thinking about this? Reading the documentation of GUI frameworks, this task seems to be left out. It is definitely possible to do, but should it not be one of the most basic tasks? Loading a page is but one action when rendering on screen. In general, each interaction will take time, how should the application handle time and what structures facilitate this development?

Consider the famous reactivity model. The main idea is to make the basic types `signals`. Reference to the most updated value is a basic element, run effects that occur every time a value changes, etc. If a sequence of reactions should deactivate part of the UI, is it easy to get all widgets affected by a signal and temporarily deactivate them?

Lastly, background work. If the user wants to let the app work on something while they change the configuration of the theme... how easy does the framework make it is to code this behavior?

## Wishlist

This is more a list of things that I would like they had more attention. 
- Accessibility
	- Many types of interactions, including 
		- voice commands
		- keyboard navigation
		- etc...
- Internationalization
	- Include it in the tutorials!
	- Close integration with frameworks like `fluent`
- Async by default
	- All interactions are `async`, you can opt-out
- Easy reporting
	- Reporting to user while working is a must
- Plugin system
	- Hopefully based on WASM and WASI

We can aim for much more than what web development dictates! 

