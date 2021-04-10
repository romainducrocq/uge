function [degreeIn, degreeOut] = ComputeDegree(adjacency)
  nodeDegreeIn = sum(adjacency);
  nodeDegreeOut = sum(adjacency.');
  degreeIn = zeros(1,max(nodeDegreeIn)+1);
  degreeOut = zeros(1,max(nodeDegreeOut)+1);
  for i = 1:size(nodeDegreeIn,2)
    numberLinkIn = nodeDegreeIn(i);
    numberLinkOut = nodeDegreeOut(i);
    degreeIn(numberLinkIn+1) = degreeIn(numberLinkIn+1) +1;
    degreeOut(numberLinkOut+1) = degreeOut(numberLinkOut+1)+1;
  endfor
  degreeIn = degreeIn/sum(degreeIn);
  degreeOut = degreeOut/sum(degreeOut);
endfunction
