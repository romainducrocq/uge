function C = Closeness(adjacency, node)
  numberNode = size(adjacency, 2);
  C = 0;
    for x = 1:numberNode
      if x ~= node
        weight = Dijkstra(adjacency, x, node);
        C = C + weight;
      endif
    endfor
  C = 1 / C;
endfunction