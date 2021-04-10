function localClustering = ComputeLocalClust(adjacency, nodeIndex)
  Ki = sum(adjacency(nodeIndex,:));
  denominator = Ki*(Ki-1);
  if denominator <= 1
    localClustering = 0;
  else
    numerator = 0;
    for j = 1:size(adjacency,2)
      if j~= nodeIndex
        for k = 1:size(adjacency,2)
          if k~=j && k~=nodeIndex
            numerator = numerator + adjacency(nodeIndex,j)*adjacency(j,k)*adjacency(k,nodeIndex);
          endif
        endfor
      endif
    endfor
    localClustering = numerator/denominator;
  endif
endfunction
