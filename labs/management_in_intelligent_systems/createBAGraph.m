function adjacencyBA = createBAGraph(n,m)
  m0=m+1;
  adjacencyBA = CreateRandomGraph(m0,0.5);
  for newNode = (m0+1):n
    listAvailableNode = getAvailableNode(adjacencyBA);
    % its used to remember node who have alrready a link
    K = getK(adjacencyBA);
    adjacencyBA(newNode,newNode)=0;
    % add the node without any links
    for linkM = 1:m
      P = rand();
      for nodePossibleLink = 1:size(listAvailableNode,2)
        PossibleNode = listAvailableNode(nodePossibleLink);
        % for all possible node to add this link (without those who already have a link)
        Pk = sum(K(1:PossibleNode))/sum(K);
        if Pk>P
          listDisponibleNode(nodePossibleLink)=[];
          % like this its impossible to add twice the same link
          adjacencyBA(newNode,PossibleNode) = 1;
          K(PossibleNode) = K(PossibleNode) + 1;
          break;
          % stop the "for nodePossibleLink = 1:size(listDisponibleNode,2)" loop
        endif
      endfor
    endfor
  endfor
endfunction

function K = getK(adjacency)
  % here K mean the sum of link who go in and out of a node
  numberNodes = size(adjacency,1);
  K=zeros(1,numberNodes);
  for i = 1:numberNodes
    K(i) = sum(adjacency(i,:));
    K(i) = K(i) + sum(adjacency(:,i));    
  endfor
endfunction

function listNode = getAvailableNode(adjacency)
  numberNodes = size(adjacency,1);
  listNode = zeros(1,numberNodes);
  for i = 1:numberNodes
    listNode(i) = i;
  endfor
endfunction

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
