---

layout: post
title:  "Useful LaTeX"
date:   2026-01-03 00:00:00 +0000
front:  false

---

Here is a collection of useful packages and tips for LaTeX.

## Template

A template for new articles and notes.

```latex
\documentclass[11pt, a4paper]{article}

% ---------- Review / notes ----------
\usepackage{todonotes}
\usepackage[draft, deletedmarkup=sout]{changes} % \added[id=<id>, comment=<comment>]{<new text>} \deleted \replaced \highlight \comment
\definechangesauthor[name=NAME, color=green]{ID}
\definechangesauthor[name=NAME, color=blue]{ID}


% ---------- Layout ----------
\usepackage[margin=2.5cm]{geometry}
% Set space between lines
% For example, higher space when reviewing
\usepackage{setspace} 
\setstretch{1}

% ---------- Float control ----------
% Define \FloatBarrier command, beyond which floats may not pass
% For example, to ensure all floats for a section appear before the next \section command. 
\usepackage[section]{placeins}

% ---------- Table of Contents ----------
% Set depth
\setcounter{tocdepth}{2}

% ---------- Links ----------
\usepackage[colorlinks=true, allcolors=blue]{hyperref}
\hypersetup{
    bookmarksdepth=4  % include paragraphs in the TOC in PDF
}


% ---------- Math ----------
\usepackage{amsmath,amssymb,amsthm,mathtools,mathrsfs}
\usepackage{cleveref}

% ---------- Display math ----------
% Allow displays to break between pages
% For example, long aligned equations
\allowdisplaybreaks


% ---------- Figures, tables, algorithms ----------
\usepackage{graphicx}
\usepackage{subcaption}

% ---------- TikZ ----------
\usepackage{tikz}


% ---------- Theorems ----------
\newtheorem{Theorem}{Theorem}[section]
\newtheorem{Conjecture}[Theorem]{Conjecture}
\newtheorem{Lemma}[Theorem]{Lemma}
\newtheorem{Corollary}[Theorem]{Corollary}
\newtheorem{Proposition}[Theorem]{Proposition}
\newtheorem{Definition}[Theorem]{Definition}
\newtheorem{Remark}[Theorem]{Remark}
\newtheorem{Example}[Theorem]{Example}
\newtheorem*{Condition}{Condition}
\newtheorem*{Assumption}{Assumption}
\newtheorem*{Notation}{Notation}

% ---------- Math operators ----------
\DeclareMathOperator*{\argmax}{arg\,max}
\DeclareMathOperator*{\argmin}{arg\,min}
\newcommand{\supp}{\textnormal{supp}}   

% ---------- Math sets ----------
\newcommand{\A}{\mathcal{A}}
\newcommand{\NN}{\mathbb{N}}
\newcommand{\PP}{\mathbb{P}}
\newcommand{\EE}{\mathbb{E}}
\newcommand{\QQ}{\mathbb{Q}}
\newcommand{\RR}{\mathbb{R}}
\newcommand{\ZZ}{\mathbb{Z}}

% ---------- Math utilities ----------
\newcommand{\until}{\,..\,}
\newcommand{\eps}{\varepsilon}
\newcommand{\defas}{\coloneqq}
\newcommand{\given}{\,|\,}


\title{TITLE}

\author{
    NAME\thanks{AFFILIATION}
\and 
    NAME\thanks{AFFILIATION}
}

\date{\today} 

\begin{document}

\maketitle 
    
\begin{abstract}
	ABSTRACT
\end{abstract}

\noindent \textbf{Keywords}: KEYWORD1, KEYWORD2.

 
\section{Introduction}
\label{Section: Introduction}

\paragraph{[MAIN TOPIC]}

```