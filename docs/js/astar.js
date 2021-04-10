//https://en.wikipedia.org/wiki/A*_search_algorithm

class Node{
  constructor(state, stringState, lastStack){
    this.priority = 0; //f value for priority queue
    this.g = infinity();
    this.h;
    this.neighbors = [];
    this.cameFrom = null;

    this.state = state;
    this.stringState = stringState;
    this.lastStack = JSON.stringify(lastStack);
  }

  setF(f){
    this.priority = infinity() - f;
  }

  setH(state){
    this.h = heuristic(state);
  }

  addNeighbors(){
    if(this.neighbors.length === 0){
      let stacks = possibleStacks(this.state);
      for(const s of stacks){
        let neighborState = stack(s[0], s[1], s[2], copyState(this.state));
        this.neighbors.push(new Node(
          neighborState,
          stateStringify(neighborState),
          s
        ));
      }
      for(const n of this.neighbors){
        n.setH(n.state);
      }
    }
  }
}

function astar(){
  const openPriorityQueue = new PriorityQueue();
  let openSet = new Set();

  let startNode = new Node(startState, stateStringify(startState), []);
  startNode.g = 0;
  startNode.setH(startNode.state);
  startNode.setF(startNode.h);

  openPriorityQueue.enqueue(startNode);
  openSet.add(startNode.stringState);

  while(openSet.size > 0){
    let current = openPriorityQueue.dequeue();
    openSet.delete(current.stringState);
    if(goalReached(current.state)){
      console.log("GOAL");
      return reconstructPath(current);
    }else{
      current.addNeighbors();
      for(const neighbor of current.neighbors){
        let guessG = current.g + 1;
        if(guessG < neighbor.g){
          neighbor.cameFrom = current;
          neighbor.g = guessG;
          neighbor.setF(neighbor.g + neighbor.h);
          if(!openSet.has(neighbor.stringState)){
            openPriorityQueue.enqueue(neighbor);
            openSet.add(neighbor.stringState);
          }
        }
      }
    }
  }
  return null;
}

function reconstructPath(current){
  let path = [];
  while(current.cameFrom !== null){
    path.splice(0, 0, JSON.parse(current.lastStack));
    current = current.cameFrom
  }
  return path;
}
