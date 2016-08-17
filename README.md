# TransitionParser.jl

[![Build Status](https://travis-ci.org/hshindo/TransitionParser.jl.svg?branch=master)](https://travis-ci.org/hshindo/TransitionParser.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/github/hshindo/TransitionParser.jl?branch=master)](https://ci.appveyor.com/project/hshindo/TransitionParser-jl/branch/master)

<p align="center"><img src="https://github.com/hshindo/TransitionParser.jl/blob/master/TransitionParser.png" width="250"></p>

A transition-based parser in [Julia](http://julialang.org/).

A transition system is an abstract concept to describe discrete systems, which consists of `state` and `transition`.
In natural language processing (NLP), it is often used for syntactic and semantic parsing of texts, which is called transition-based parsing.

This package provides search and training algorithms for transition-based parsing.

## Installation
```julia
julia> Pkg.clone("https://github.com/hshindo/TransitionParser.jl.git")
```

## Usage
Define `state` and `transition` for your transition system.

Currently, the following members are required for `state`:
* score::Float64
* step::Int

For deciding, `beamsearch` function finds k-best optimal states according to your transition system.

```julia
using TransitionParser

initstate = State()
beamsearch(initstate, 16, expand)
```
where beamsize is 16, `expand` is a function to get next states from current state.

See [JukaiNLP](https://github.com/hshindo/JukaiNLP.jl.git) for concrete examples.
