function [adjacency,weightedAdjacency,incidence] = AddLink(adjacency,weightedAdjacency,incidence,nodeOriginIndex,nodeDestinationIndex,weight)
  adjacency(nodeOriginIndex, nodeDestinationIndex) = 1;
  weightedAdjacency(nodeOriginIndex, nodeDestinationIndex)= weight;
  incidence(nodeOriginIndex, end+1) = 1;
  incidence(nodeDestinationIndex, end) = -1;
endfunction