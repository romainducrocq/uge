function H = Harmonic(adjacency, node)
  numberNode = size(adjacency, 2);
  H = 0;
    for x = 1:numberNode
      if x ~= node
        weight = Dijkstra(adjacency, x, node);
        H = H +  (1 / weight);
      endif
    endfor
endfunction
