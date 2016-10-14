function model()
    T = Float32
    x = Var()
    y = Embedding(T,10000,100)(x)
end

function getscore(m, s::State)
    fs = features(s)
    score = 0.0
    
end
