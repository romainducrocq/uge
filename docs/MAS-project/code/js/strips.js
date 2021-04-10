function initialState(){
  let state = {};
  for(predicate in strips[nDisks].INIT){
    const set = new Set();
    state[predicate] = set;
    for(const p of strips[nDisks].INIT[predicate]){
      state[predicate].add(JSON.stringify(p));
    }
  }
  return state;
}

function goalReached(state){
  for(rule in strips[nDisks].GOAL){
    for(const predicate of strips[nDisks].GOAL[rule]){
      //console.log(rule, JSON.stringify(predicate));
      if(!state[rule].has(JSON.stringify(predicate))){
        return false;
      }
    }
  }
  return true;
}

/*
//Implementation with explore the world
function possibleStacks(world, state){
  let stacks = [];
  for(const tower of world){
    for(const other of world){
        if(state["FITS"].has(JSON.stringify([tower[0], other[0]]))){
            stacks.push([tower[0], tower[1], other[0]]);
      }
    }
  }
  return stacks;
}
*/

//Imlementation without explore world
//
//IF ON --> Not a base
//IF CLEAR --> On top
//FOR ALL CLEAR != CURRENT --> Avoid stack X on X
//IF FIT ON CLEAR --> Action is possible
function possibleStacks(state){
  let stacks = [];
  for(const o of state["ON"]){
    if(state["CLEAR"].has(JSON.stringify([JSON.parse(o)[0]]))){
      for(const c of state["CLEAR"]){
        if(c !== JSON.stringify([JSON.parse(o)[0]])){
          if(state["FITS"].has(JSON.stringify([JSON.parse(o)[0], JSON.parse(c)[0]]))){
            stacks.push([JSON.parse(o)[0], JSON.parse(o)[1], JSON.parse(c)[0]].slice());
          }
        }
      }
    }
  }
  return stacks;
}

function stack(disk, from, to, state){
  let vals = [disk, from, to];
  for(rule in strips.ACTIONS.STACK){
    for(predicate in strips.ACTIONS.STACK[rule]){
      for(const p of strips.ACTIONS.STACK[rule][predicate]){
        let args = [];
        for(const i of p){
          args.push(vals[i]);
        }
        if(!evaluate(rule, predicate, args, state)){
          return null;
        }
      }
    }
  }
  return state;
}

function evaluate(rule, predicate, args, state){
  switch(rule) {
    case "PRE":
      if(!state[predicate].has(JSON.stringify(args))){
        return false;
      }
      break;
    case "DEL":
      state[predicate].delete(JSON.stringify(args));
      break;
    case "ADD":
      state[predicate].add(JSON.stringify(args));
      break;
    default:
      return false;
  }
  return true;
}

//HEURISTIC
//Number of discs not on B3
// +
//2 * (Number of Discs on B3 for which there is a bigger disc on B1 or B2)
function heuristic(state){

  if(state["CLEAR"].has(JSON.stringify(end))){
    return state["ON"].size;
  }

  let onGoal = [];
  onGoal.push(end[0]);
  onGoalLoop:
  while(true){
    for(const o of state["ON"]){
      if(JSON.parse(o)[1] === onGoal[onGoal.length-1]){
        onGoal.push(JSON.parse(o)[0]);
        if(state["CLEAR"].has(JSON.stringify([onGoal[onGoal.length-1]]))){
          break onGoalLoop;
        }
      }
    }
  }

  let numberNotOnGoal = state["ON"].size - (onGoal.length - 1);

  let numberOnGoalWithBiggerNotOnGoal = 0;
  let i = 1;
  while(i < onGoal.length){
    if((i == 1 && state["ON"].size - parseInt(onGoal[1].charAt(1)) > 0) || (parseInt(onGoal[i-1].charAt(1)) - parseInt(onGoal[i].charAt(1)) > 1)){
      numberOnGoalWithBiggerNotOnGoal++;
      i++;
      while((i < onGoal.length) && (parseInt(onGoal[i-1].charAt(1)) - parseInt(onGoal[i].charAt(1)) == 1)){
        numberOnGoalWithBiggerNotOnGoal++;
        i++;
      }
    }else{
      i++;
    }
  }

  return numberNotOnGoal + 2 * numberOnGoalWithBiggerNotOnGoal;
}

function exploreWorld(state){
  let towers = [];

  for(const c of state["CLEAR"]){
    towers.push([JSON.parse(c)[0]]);
  }

  const elt = new Set();
  while(elt.size < state["ON"].size){
    for(const o of state["ON"]){
      if(!elt.has(o)){
        for(const t of towers){
          if(JSON.parse(o)[0] === t[t.length-1]){
            elt.add(o);
            t.push(JSON.parse(o)[1]);
          }
        }
      }
    }
  }

  return towers;
}

function nextWorldWithState(currentState, nextStack){
  stack(nextStack[0], nextStack[1], nextStack[2], currentState);
  return exploreWorld(currentState);
}

function nextWorldWithWorld(world, nextStack){
  if(nextStack !== null){
    for(const tower of world){
      if(tower[0] === nextStack[2]){
        for(const other of world){
          if(other[0] === nextStack[0] && other[1] === nextStack[1]){
            tower.splice(0, 0, nextStack[0]);
            other.splice(0, 1);
          }
        }
      }
    }
  }
}
