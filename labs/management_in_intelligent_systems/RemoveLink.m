function [adjacency, weightedAdjacency, incidence] = RemoveLink(adjacency, weightedAdjacency, incidence, nodeOrigin, nodeDestination)
  adjacency(nodeOrigin, nodeDestination) = 0;
  weightedAdjacency(nodeOrigin, nodeDestination) = 0;
  numberLink = size(incidence,2);
  for linkIndex = 1:numberLink
    if incidence(nodeOrigin,linkIndex) == 1 && incidence(nodeDestination,linkIndex) == -1
      % if its the index of the link to go from nodeOrigin to nodeDestination
      newIncidence(:,linkIndex) = [];  
      break
      % break is used to stop the for loop
    endif
  endfor
endfunction