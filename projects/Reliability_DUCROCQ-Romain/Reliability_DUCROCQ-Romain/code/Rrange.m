function rrange = Rrange(rodMat, origin)
  rrange = Inf;
  maxRod = 0;
  minRod = Inf;
  numberNodes = size(rodMat,2);
  for destination = 1:numberNodes
    if destination ~= origin
      rod = rodMat(origin, destination);
      if rod ~= 0
        if rod > maxRod
          maxRod = rod;
        endif        
        if rod < minRod
          minRod = rod;
        endif
      endif
    endif
  endfor
if maxRod > minRod
  rrange = maxRod - minRod;
endif
endfunction
