using Core: Bits
"""
Bitstrings, genetic algorithms and such thngs
"""
using Base.Threads
using Random

# Constants
const FINTESS_TARGET = 5


mutable struct Bitstring
  data::String

  function Bitstring(data::String)
    new(Bitstring(data))
  end
end

length(bs::Bitstring) = length(bs.data)
ones(bs::Bitstring) = count(c -> c == '1', bs.data)
zeros(bs::Bitstring) = count(c -> c == '0', bs.data)

function flip_at(bs::Bitstring, idx::Integer)
  bs.data[idx] = bs.data[idx] == '1' ? '0' : '1'
end

function flip_all(bs::Bitstring)
  Threads.@threads for (i, e) in enumerate(bs.data)
    bs.data[i] = e == '1' ? '0' : '1'
  end
end

function flip_random_n!(bs::Bitstring, n::Integer)
  idxs = randperm(0, 100)[1:n]
  Threads.@threads for i in idxs
    flip_at(bs, i)
  end
end




# Population represented
mutable struct Population
  pop::Vector{Bitstring}
  size::Integer

  function Population(pop::Vector{Bitstring}, size::Integer)
    new(Population(pop, size))
  end
end

pop_size(pop::Population) = pop.size



# Init 
function generate_random_bitstrings(n::Integer)
  return [Bitstring(join(rand(0:1))) for _ in 1:n]
end

# Selection

"""
  Select at most n of all the strings in the population
"""
function deterministic_select!(p::Population, n::Integer; treshhold::Integer=20)
  r::Vector{Bitstring} = [e for e in p.pop if ones(e) > treshhold]

  compare_score(lhs::Bitstring, rhs::Bitstring) = ones(lhs) > ones(rhs)

  # Only take largest elements
  if length(r) > n
    sort!(r, by=compare_score)
    r = r[1:n]
  end

  p = Population(r, length(r))
  return nothing
end

# Mutation
function mutate!(p::Population)
  Threads.@threads for child in p.pop
    mutate!(child)
  end
end

function mutate!(bs::Bitstring)
end

# Crossover
function cross(pop::Population)
end

function cross(bs::Bitstring)
end



# Fitness

f(x::Bitstring) = ones(x)


# Eval




# Main loop

function main()


end

main()
