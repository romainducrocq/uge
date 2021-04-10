function BIndex = BetaIndex(adjacency)
  numberLinks = sum(sum(adjacency));
  numberNode = size(adjacency,2);
  BIndex = numberLinks / (numberNode * 2);
endfunction
