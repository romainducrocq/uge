function diameter = Diameter(adjacency)
  numberNode = size(adjacency,2);
  diameter  =0;
  for node = 1:numberNode
    [weights,~] = Dijkstra2(adjacency, node);
    maxWeight = max(weights);
    if maxWeight > diameter
      diameter = maxWeight;
    endif
  endfor
endfunction
