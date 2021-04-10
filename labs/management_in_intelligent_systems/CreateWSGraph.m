function adjacency = CreateWSGraph (n,k,B)
  adjacency = zeros(n);
  for node = 1:n
    for link = 1:k
      adjacency(node,mod(node+link-1,n)+1) = 1;
    endfor
  endfor
  
  for node = 1:n
    for link = (node+1):(node+k)
      prob = rand();
      if prob < B
        numberPossibleLink = n-1-k;
        probLink = 1/numberPossibleLink;
        randLink = rand();
        realProb = 0;
        for i = 1:n
          if i ~= node && i ~= link && adjacency(node,i) ~= 1 
            realProb = realProb + probLink;
            if randLink < realProb
              adjacency(node,mod(link-1,n)+1) = 0;
              adjacency(node, i) = 1;
              break;
            endif
          endif     
        endfor
      endif
    endfor
  endfor
  
endfunction
