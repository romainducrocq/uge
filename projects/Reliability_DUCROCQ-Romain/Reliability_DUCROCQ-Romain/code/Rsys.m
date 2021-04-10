function rsys = Rsys(rodMat)
  rsys = sum(rodMat(:)) / (size(rodMat,2) * (size(rodMat,2) - 1));
endfunction
