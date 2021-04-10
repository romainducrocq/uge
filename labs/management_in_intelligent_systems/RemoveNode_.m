function [adjacency, weightedAdjacency, incidence] = RemoveNode_(adjacency, weightedAdjacency, incidence, node)
  adjacency(:, node) = [];
  adjacency(node, :) = [];
  weightedAdjacency(:, node) = [];
  weightedAdjacency(node, :) = [];
  numberLink = size(incidence,2);
  
  for i = 1:numberLink
    if incidence(node, numberLink-i+1) ~= 0
      incidence(:, numberLink-i+1) = [];
      % delete all the link who go from or to the node
    endif
  endfor
  % here it go backward to avoid indexing problem
  incidence(node, :) = [];
  % to delete the row of the node
endfunction