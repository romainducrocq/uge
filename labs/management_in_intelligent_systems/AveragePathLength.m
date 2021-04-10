function averagePL = AveragePathLength(adjacency)
  numberNode = size(adjacency,2);
  diameter = 0;
  averagePL = 0; 
    for node = 1:numberNode
      [weights,~] = Dijkstra2(adjacency, node);
      averagePL = averagePL + sum(weights) - numberNode + 1;
    endfor
   averagePL = averagePL / (numberNode * (numberNode - 1));
endfunction
