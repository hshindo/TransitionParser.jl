type State
    tokens::Vector{Int}
    headsets::Vector{Vector{Int}}
    step::Int
end

State(tokens, headsets) = State(tokens, headsets, 0)

function Base.next(s::State)::Vector{State}
    s.step == length(tokens) && return State[]
    map(headsets[s.step+1]) do h
        State(s.tokens, s.headsets, h)
    end
end

type Model
    nn
end

function Model()
    T = Float32
    x = Var()
    y = Embedding(T,10000,100)(x)
    y = Linear(T,100,1)(y)
    Model(Graph(y,x))
end

function getscore(m::Model, s::State)::Float64
    1.0
end
