function globalClustering = ComputeGlobalClust(adjacency)
  globalClustering = 0;
  numerator = 0;
  denominator = 0;
  for i = 1:size(adjacency,2)
    for j = 1:size(adjacency,2)
      if j~=i
        for k = 1:size(adjacency,2)
          if k~=j && k~=i
            numerator = numerator + adjacency(i,j)*adjacency(j,k)*adjacency(k,i);
            denominator = denominator + adjacency(i,j)*adjacency(k,i);
          endif
        endfor
      endif
    endfor
  endfor
  if denominator ~= 0
    globalClustering = numerator/denominator;
  endif
endfunction
