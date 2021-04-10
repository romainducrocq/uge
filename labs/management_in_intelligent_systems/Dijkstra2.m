function [weights, paths] = Dijkstra2(adjacency, nodeOrigin)
  weights = AssignWeight(adjacency, nodeOrigin);
  numberNode = size(adjacency,1);
  previousNode = zeros(1,numberNode);%
  previousNode(nodeOrigin) = -1;
  
  listNodes = zeros(1,numberNode);
  for i = 1:numberNode
    listNodes(i) = i;
  endfor
  
  while size(listNodes,2) > 0
    [lightestNode, listNodes] = SearchLightNode(listNodes, weights);
    
    if weights(lightestNode) == Inf
      %  no path possible
      weight = Inf; 
      break;
    endif
    
    for neighborNodeIndex = 1:size(listNodes,2)
      neighborNode = listNodes(neighborNodeIndex);
      if adjacency(lightestNode, neighborNode) ~= 0
        [weights, previousNode] = RefreshWeight(weights, previousNode, lightestNode, neighborNode, adjacency(lightestNode, neighborNode));
      endif      
    endfor    
  endwhile
  
  
  paths = [];
  for i = 1:numberNode
    if previousNode(i) == 0
      paths(i,1) = 0;
    else
      paths(i,1) = i;
      lastNodeAddedPath = i;
      index = 1;
      while lastNodeAddedPath ~= nodeOrigin
        lastNodeAddedPath = previousNode(lastNodeAddedPath);
        index = index + 1;
        paths(i,index) = lastNodeAddedPath;
      endwhile
    endif
  endfor
  
endfunction


function weights = AssignWeight(adjacency, node)
  numberNode = size(adjacency,1);
  weights = Inf(1,numberNode);
  weights(node) = 0;
endfunction


function [lightestNode, listNodes] = SearchLightNode(listNodes, weights)
  lightestNode = listNodes(1);
  lightestNodeIndex = 1;
  for i = 2:size(listNodes,2)
    possibleNode = listNodes(i);
    if weights(possibleNode) < weights(lightestNode)
      lightestNode = possibleNode;
      lightestNodeIndex = i;
    endif
  endfor
  listNodes(lightestNodeIndex) = [];
endfunction


function [weights, previousNode] = RefreshWeight(weights, previousNode, nodeOrigin, nodeDestination, distance)
  if weights(nodeOrigin) + distance < weights(nodeDestination)
    weights(nodeDestination) = weights(nodeOrigin) + distance;
    previousNode(nodeDestination) = nodeOrigin;
  endif
endfunction



