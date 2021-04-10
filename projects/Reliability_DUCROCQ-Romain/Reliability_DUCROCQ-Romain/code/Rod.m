function rod = Rod(adjacency, origin, destination)
  rod = 0;
  odPaths = YenKSP(adjacency, origin, destination);
  if size(odPaths{1},2) > 0
    numberPaths = size(odPaths, 2);
    multPNotEkMin1 = 1;
    for k = 1:numberPaths
      m = size(odPaths{k}, 2) - 1;
      pEk = (1 - (1 / m)) ** m;
      pDk = multPNotEkMin1 * pEk;
      rod += pDk;
      multPNotEkMin1 *= (1 - pEk);
    endfor
  endif
endfunction