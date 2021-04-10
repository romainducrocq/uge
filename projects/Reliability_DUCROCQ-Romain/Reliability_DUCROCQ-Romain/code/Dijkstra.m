function [path] = Dijkstra(adjacency, nodeOrigin, nodeDestination)
  weights = AssignWeight(adjacency, nodeOrigin);
  numberNode = size(adjacency,1);
  previousNode = zeros(1,numberNode);%
  previousNode(nodeOrigin) = -1;
  path = [];
  
  listNodes = zeros(1,numberNode);
  for i = 1:numberNode
    listNodes(i) = i;
  endfor
  
  while size(listNodes,2) > 0
    [lightestNode, listNodes] = SearchLightNode(listNodes, weights);
    
    if lightestNode == nodeDestination
      % shortest possible path found to go to destination
      weight = weights(lightestNode);
      index = nodeDestination;
      path = [];
      while index > 0
        path = [index, path];
        index = previousNode(index);      
      endwhile
      if size(path,2) == 1
        path = [];
      endif
      break;
    endif
    
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



