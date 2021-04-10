let end;

function findEnd(){
  for(const ic of strips[nDisks].INIT["CLEAR"]){
    let goalClear = false;
    for(const gc of strips[nDisks].GOAL["CLEAR"]){
      if(gc[0] === ic[0]){
        goalClear = true;
        break;
      }
    }
    if(!goalClear){
      return ic;
    }
  }
  return null;
}

const copySet = x => {
  const y = new Set()
  for (const item of x) y.add(item)
  return y
}

function copyState(s){
  let newState = {};
  for(rule in s){
    newState[rule] = copySet(s[rule]);
  }
  return newState;
}

function stateStringify(s){
  return JSON.stringify({
    "CLEAR": [...s["CLEAR"]].sort((a, b) =>
      (a.charAt(2) == "B" ? -1 : 1) *  parseInt(a.charAt(3)) -
      (b.charAt(2) == "B" ? -1 : 1) * parseInt(b.charAt(3))
    ),
    "ON": [...s["ON"]].sort((a, b) =>
      (a.charAt(7) == "B" ? -1 : 1) *  parseInt("" + a.charAt(3) + a.charAt(8)) -
      (b.charAt(7) == "B" ? -1 : 1) *  parseInt("" + b.charAt(3) + b.charAt(8))
    )
  });
}

function infinity(){
  return 9007199254740991;
}
