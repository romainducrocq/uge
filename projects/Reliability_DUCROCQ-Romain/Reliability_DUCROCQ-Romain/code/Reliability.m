function Reliability(name)
  
  load (strcat(name, "_rod.mat"));
  
  numberNodes = size(rodMat, 2);
  
  for origin = 1:numberNodes
    rnode(origin) = Rnode(rodMat, origin);
    rrange(origin) = Rrange(rodMat, origin);
  endfor
  
  rsys = Rsys(rodMat);
  
  #for origin = 1:numberNodes
  #  printf("Node %i: \t Rnode = %f \t Rrange = %f\n", origin, rnode(origin), rrange(origin));
  #endfor
  #printf("\nRsys = %f\n", rsys);
  
  save (strcat(name, "_result.mat"), "rnode", "rrange", "rsys");
endfunction
