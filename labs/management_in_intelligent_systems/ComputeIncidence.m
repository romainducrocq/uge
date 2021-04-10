function incidence = ComputeIncidence(adjacency)
  numberOfLinks = sum(sum(adjacency));
  % get the number of link from the adjacency matrix of a directed graph
  numberOfNodes = size(adjacency,1)
  % get the number of nodes of the adjacency matrix
  incidence=zeros(numberOfNodes,0);
  for originNode = 1:numberOfNodes
    for destinationNode = 1:numberOfNodes
      if adjacency(originNode,destinationNode) == 1
        incidence(originNode,end+1) = 1;
        % add a new column to add the link with the end+1
        incidence(destinationNode,end) = -1;
        % use end because the column is already created
      endif
    endfor
  endfor
endfunction
