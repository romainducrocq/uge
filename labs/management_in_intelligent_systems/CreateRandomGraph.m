function adjacencyRandom = CreateRandomGraph(n,p)
  adjacencyRandom = zeros(n);
  for i = 1:n
    for j = 1:n
      if i ~= j
        if rand()<p
          adjacencyRandom(i,j) = 1;
        endif
      endif
    endfor
  endfor
endfunction
