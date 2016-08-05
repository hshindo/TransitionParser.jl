type Node{T}
    state::T
    score::Float64
    prev::Node{T}

    Node(state) = new(state, 0.0)
end

lessthan{T}(x::T, y::T) = x.score > y.score

function beamsearch{T}(initstate::T, beamsize::Int)
    chart = Vector{T}[]
    push!(chart, [initstate])

    k = 1
    while k <= length(chart)
        states = chart[k]
        length(states) > beamsize && sort!(states, lt=lessthan)
        for i = 1:min(beamsize, length(states))
            for (s,score) in next(states[i])
                while s.step > length(chart)
                    push!(chart, T[])
                end
                push!(chart[s.step], s)
            end
        end
        k += 1
    end
    sort!(chart[end], lt=lessthan)
    chart
end
