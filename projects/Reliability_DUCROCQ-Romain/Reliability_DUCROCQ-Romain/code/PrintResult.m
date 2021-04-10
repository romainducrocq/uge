function PrintResult(name, plots, sortMode)
  load (strcat(name, "_result.mat"));
  
  numberNodes = size(rnode, 2);
  
  if plots == 1
    subplot (211);
    plot(1:1:numberNodes, rnode);
    ylim([0, 1]);
    xlabel("Nodes");
    ylabel("R node");
    title("R nodes");
    
    subplot (212);
    plot(1:1:numberNodes, rrange);
    ylim([0, 1]);
    xlabel("Nodes");
    ylabel("R range");
    title("R ranges");
  endif
 
  if (sortMode == 1)
    [rnode,idx] = sort(rnode, "ascend");
  elseif (sortMode == 2)
    [rnode,idx] = sort(rnode, "descend");
  else
    for i = 1:numberNodes
      idx(i) = i;
    endfor
  endif 
  
  for origin = 1:numberNodes
    printf("Node %i: \t Rnode = %f \t Rrange = %f\n", idx(origin), rnode(origin), rrange(idx(origin)));
  endfor
  printf("\nRsys = %f\n", rsys);
endfunction
