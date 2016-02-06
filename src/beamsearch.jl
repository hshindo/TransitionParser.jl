type BeamSearch
  size::Int
end

"""
Requirements of T:
  member: score
  member: step
"""
# `state` must have a function: expand and a variable: score"
function decode{T}(bs::BeamSearch, expand::Function, initstate::T)
  chart = Vector{T}[]
  push!(chart, [initstate])
  lessthan(x::T, y::T) = y.score - x.score

  i = 1
  while i <= length(chart)
    states = chart[i]
    length(states) > bs.size && sort!(states, lt=lessthan)
    for j = 1:min(length(states), bs.size)
      for s in expand(states[j])
        while s.step > length(chart)
          push!(chart, T[])
        end
        push!(chart[s.step], s)
      end
    end
    i += 1
  end
  chart
end
