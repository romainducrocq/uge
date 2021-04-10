function pageRank = PageRank(adjacency, E, d)
  numberNode = size(adjacency, 2);
  pageRank = zeros(1, numberNode);
  for i = 1:numberNode
    pageRank(i) = 1 / numberNode;
  endfor
  maxIt = 100;
  itareation = 0;
  stabilized = false;
  while iteration < maxIt && ~stabilized
    newPageRank = zeros(1, numberNode);
    for i = 1:numberNode
      newPageRank(i) = (1 - d) / numberNode;
    endfor
    for nodeIn = 1:numberNode
      numberLinkOut = sum(adjacency(nodeIn,:));
      if numberLinkOut == 0
        for otherNode = 1:numberNode
          if otherNode ~= nodeIn
            newPageRank(otherNode) = newPageRank(otherNode) + d * pageRank(nodeIn) / (numberNode - 1);
          endif 
        endfor
      else
        for nodeOut = 1:numberNode
          if adjacency(nodeIn, nodeOut) == 1
            newPageRank(nodeOut) = newPageRank(nodeOut) + d * pageRank(nodeIn) / numberLinkOut;
          endif
        endfor
      endif
    endfor
    stabilized = Istabilized(pageRank, newPageRank, E);
    pageRank = newPageRank;
    iteration = iteration + 1;
  endwhile
endfunction

function stabilized = IsStabilized(oldPageRank, newPageRank, E)
  stabilized = true;
  for node = 1:size(oldPageRank, 2)
    deltaPageRank = abs(oldPageRank(node)-newPageRank(node));
    if deltaPageRank > E
      stabilized = false;
    endif
  endfor
endfunction
