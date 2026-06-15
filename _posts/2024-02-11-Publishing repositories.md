---

layout: post
title:  "Publishing repositories"
date:   2024-02-11 00:00:00 +0000
front:  true

---

A few repositories to freely publish your research. 

The main goal of publishing (research) is sharing (your work).
A main concern when publishing research is long-term availability and discoverability.
I my field, various colleagues keep an eye on journals, conferences and a few repositories like [ArXiv](https://arxiv.org/).

Alongside theoretical papers, sometimes there are code for some computations or datasets. These should also be accessible and there is no clear consensus in the community about how.
Also, when publishing code, the double-blind policy asks you to take a few more steps into account.
This post supports the use of [Zenodo](https://zenodo.org) for this task and explains how to use it.

## Research paper

Research paper are written in LaTeX (for better or worse). 
[ArXiv](https://arxiv.org/) is the only repository I know of that hosts source code files and publishes its output.
This approach is so much better for long-term availability than uploading a pdf file.
Also, it naturally supports versioning of the same paper.

## Supporting code

Supporting code is a collection of scripts or data used durign the research. 
It is clear that they should also be published, but classical repositories do not support this type of attachments well yet.

[Zenodo](https://zenodo.org) is a public, free, open repository for science.
It is funded by OpenAIRE, CERN, and the European Comission.
You can publish a screenshot of various forms of research (papers, presentations, thesis, code, datasets, etc...) and get a DOI identifier.
Once a repository is published, the files included can not be changed, only the metadata.
To make a "blind" submission (without reference to the authors) and obtain a public DOI, simply publish a repository making the author metadata anonymous.

About licensing your work, please consider the [CC0 license](https://creativecommons.org/publicdomain/zero/1.0/).
You can read more about why in the [Fact Sheet on Creative Commons & Open Science](https://zenodo.org/records/840652).
