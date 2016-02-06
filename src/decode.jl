"""
Requirements of T:
  member: score
  member: step
"""
function beamsearch{T}(beamsize::Int, expand::Function, initstate::T)
  chart = Vector{T}[]
  push!(chart, [initstate])
  lessthan(x::T, y::T) = y.score - x.score

  i = 1
  while i <= length(chart)
    states = chart[i]
    length(states) > beamsize && sort!(states, lt=lessthan)
    for j = 1:min(beamsize, length(states))
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
