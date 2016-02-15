module TransitionParser

export beamsearch, max_violation

"""
Requirements of T:
  member: score
  member: step
"""
function beamsearch{T}(initstate::T, beamsize::Int, expand::Function)
  chart = Vector{T}[]
  push!(chart, [initstate])
  lessthan(x::T, y::T) = y.score - x.score

  k = 1
  while k <= length(chart)
    states = chart[k]
    length(states) > beamsize && sort!(states, lt=lessthan)
    for i = 1:min(beamsize, length(states))
      for s in expand(states[i])
        while s.step > length(chart)
          push!(chart, T[])
        end
        push!(chart[s.step], s)
      end
    end
    k += 1
  end
  chart
end

"""
Requirements of T:
  member: prev
"""
function to_seq{T}(finalstate::T)
  seq = T[]
  s = finalstate
  while s != nothing
    push!(seq, s)
    s = s.prev
  end
  reverse!(seq)
  seq
end

"L. Huang et al. \"Structured Perceptron with Inexact Seatch\", ACL 2012"
function max_violation(gold, pred)
  goldseq, predseq = to_seq(gold), to_seq(pred)
  maxk, maxv = 1, 0.0
  for k = 1:length(golds)
    v = predseq[k].score - goldseq[k].score
    if v > maxv
      maxk = k
      maxv = v
    end
  end
  maxk
end

end
