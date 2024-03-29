---

layout: post
title:  "Web monetization"
date:   2022-03-08 00:00:00 +0000
front: false
categories: 

---

The browser is control various resources. Some are common with other applications, for example memory and power consumption, while others are more specific to browsers, like internet bandwidth. [Web monetization](https://webmonetization.org/) aims to be a web standard to control money, possibly without human interaction.

## What is new?

Zero-cost micro payments and what ever you can imagine doing with them.

In particular, this opens the possibility to:
- A new revenue model for the web (not necessarily through ads)
- Real-time premium model
- Getting paid as you browse

## What was there before?

Other than ads and subscriptions, there is Flattr. Flattr saves your history during a month and distributes your money pool accordingly among the visited websites (by time spent on them).

## What is not addressed?

Attention-based model is still the main driver of money: the more time you spent in my website, the more money I get. If you have new ideas, please share them!

## Details

The current components are:
- Network: (how payments are done?)
	- [Interledger](https://interledger.org/)
- Provider: (who controls the money?)
	- [Coil](https://coil.com/)
		- Update: From March 15, 2023, Coil was discontinued. The work continues through the [Interledger Foundation](https://interledger.org/)

### Interledger

The Interledger Foundation is a non-profit advocate for the web, promoting innovation, creativity, and inclusion by advancing open payment standards and technologies that seamlessly connect our global society. 

For now, micro-payments are only used to pay websites. [Rafiki, see main post](https://write.as/coil/introducing-rafiki-an-all-in-one-solution-for-interledger-wallets), extends this to receiving payments too.

## Some thoughts

The whole ecosystem is quite young, but eager to propose a different way to think about money (or value rewards) on the browser. Let us try something new!

## Resources

If you want to dive deep into the topic, try experimenting  with some of these:
- Get started from Interledger
	- https://interledger.org/developer-tools/get-started/overview/
