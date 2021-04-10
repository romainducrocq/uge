function rnode = Rnode(rodMat, origin)
  rnode = sum(rodMat(origin,:)) / (size(rodMat,2) - 1);
endfunction
