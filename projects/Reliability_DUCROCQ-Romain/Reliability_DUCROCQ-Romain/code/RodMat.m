function rodMat = RodMat(adjacency, name)
  numberNodes = size(adjacency,2);
  rodMat = zeros(numberNodes,numberNodes);
  for origin = 1:numberNodes
    for destination = 1:numberNodes
      [origin destination]
      if destination ~= origin
        rodMat(origin, destination) = Rod(adjacency, origin, destination);        
      endif
    endfor
  endfor
  save (strcat(name, "_rod.mat"), "rodMat");
endfunction
