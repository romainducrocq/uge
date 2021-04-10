function B = Betweenness(adjacency)
  numberNode = size(adjacency,2);
  B = zeros(1, numberNode);
  for node = 1:numberNode
    [~, paths] = Dijkstra2(adjacency, node);
    for pathFromNode = 1:numberNode
      for indexInPaths = 2:size(paths, 2)
        if paths(pathFromNode, indexInPaths) == 0 || paths(pathFromNode, indexInPaths) == node
          break;
         endif
         nodeInPath = paths(pathFromNode, indexInPaths);
         B(nodeInPath) = B(nodeInPath) + 1;
       endfor
    endfor
  endfor
endfunction
