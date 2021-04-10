function density = ComputeDensity(adjacency)
  numberOfLink = sum(sum(adjacency));
  numberOfNodes = size(adjacency,1);
  numberOfPossibleLink = numberOfNodes*(numberOfNodes-1);
  density = numberOfLink / numberOfPossibleLink;
endfunction
