immutable Node{T}
    state::T
    score::Float64
    prev::Node{T}

    Node(state, score) = new(state, score)
end

lessthan{T}(x::Node{T}, y::Node{T}) = x.score > y.score

function getseq{T}(finalstate::T)
    seq = T[]
    s = finalstate
    while true
        unshift!(seq, s)
        isdefined(s,:prev) || break
        s = s.prev
    end
    unshift!(seq, s)
    seq
end

"""
    beamsearch
"""
function beamsearch{T}(initstate::T, beamsize::Int, getscore)
    chart = Vector{Node{T}}[]
    push!(chart, [Node(initstate,0.0)])

    k = 1
    while k <= length(chart)
        states = chart[k]
        length(states) > beamsize && sort!(states, lt=lessthan)

        for i = 1:min(beamsize,length(states))
            s = states[i]
            for c::T in next(s)
                score = getscore(c) + s.score
                n = Node(c, score, s)
                while c.step > length(chart)
                    push!(chart, Node{T}[])
                end
                push!(chart[c.step], n)
            end
        end
        k += 1
    end

    length(chart[end]) > beamsize && deleteat!(chart[end], beamsize+1:length(chart[end]))
    sort!(chart[end], lt=lessthan)
    chart[end]
end
