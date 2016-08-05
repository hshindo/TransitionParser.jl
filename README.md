# TransitionParser.jl

[![Build Status](https://travis-ci.org/hshindo/TransitionParser.jl.svg?branch=master)](https://travis-ci.org/hshindo/TransitionParser.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/github/hshindo/TransitionParser.jl?branch=master)](https://ci.appveyor.com/project/hshindo/TransitionParser-jl/branch/master)

A transition-based parser in [Julia](http://julialang.org/).

In computer science, a transition system is an abstract concept to describe discrete systems, which consists of `state`s and `transition`s between states.
In natural language processing (NLP), it is used for syntactic and semantic parsing of a sentence given some statistical model.

## Installation
```julia
julia> Pkg.clone("https://github.com/hshindo/TransitionParser.jl.git")
julia> Pkg.update()
```

## Usage
Define `state` and `transition` for your transition system.

For example,
```julia
type State
    data
    score::Float64
    step::Int
    prev::State
    prevact::Int

    State(data, score, step) = new(data, score, step)
end

function State(s::State, act::Int)
    # return transitioned state
end

function Base.next(s::State)
    [State(s,act) for act=1:3]
end

Base.done(s::State) = s.step > 10
```

Similar to iterable objects in Julia, the following methods are required for `state`:
* next
* done
* score::Float64

For deciding, function: `beamsearch` automatically finds k-best final states according to your transition system.

```julia
using TransitionParser

initstate = State()
beamsearch(initstate)
```
