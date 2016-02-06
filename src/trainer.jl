type Trainer
end

function train()

end

type Perceptron
  decoder
end

"L. Huang et al. \"Structured Perceptron with Inexact Seatch\", ACL 2012"
function maxviolation(gold, pred)

end

function train(p::Perceptron, data::Vector)
  res = []
  #prog = Progress(length(data), "training...")
  for i in randperm(length(data))
    #gold = decode(p.decoder, data[i])
    #pred = decode(p.decoder, data[i])
    #maxviolation(gold, pred)
    #next!(prog)
  end
  res
end
