module TransitionParser

export beamsearch, find_nbest, train

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

find_nbest(chart, n::Int) = chart[end][1:n]

function toseq{T}(state::T)
  seq = T[]
  s = state
  while s != nothing
    push!(seq, s)
    s = s.prev
  end
  seq
end

function train{T}(data::Vector{T}, decode_gold, decode_pred, train_gold, train_pred)
  preds = Array(T, length(data))
  for i in randperm(length(data))
    s = data[i]
    chart_g = decode_gold(s)
    chart_p = decode_pred(s)
    preds[i] = find_nbest(chart_p, 1)

    # max-violation training
    # L. Huang et al. "Structured Perceptron with Inexact Search", ACL 2012
    goldseq, predseq = toseq(gold), toseq(pred)
    maxk, maxv = 1, predseq[1].score
    for k = 1:length(golds)
      v = predseq[k].score - goldseq[k].score
      if v > maxv
        maxk = k
        maxv = v
      end
    end
    for k = 1:maxk
      train_gold(goldseq[k])
      train_pred(goldseq[k])
    end
  end
  preds
end

end
