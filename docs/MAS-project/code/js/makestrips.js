function makestrips(n){

  stripN = {
    "INIT": {
      "CLEAR": [
        ["D1"],
        ["B2"],
        ["B3"]
      ],
      "ON": [
      ],
      "FITS": [
      ]
    },
    "GOAL": {
      "CLEAR": [
        ["D1"],
        ["B1"],
        ["B2"]
      ],
      "ON": [
      ]
    }
  }

  for(let i = 1; i < n; i++){
    stripN.INIT["ON"].push(["D"+i, "D"+(i+1)]);
    stripN.GOAL["ON"].push(["D"+i, "D"+(i+1)]);
  }

  stripN.INIT["ON"].push(["D"+n, "B1"]);
  stripN.GOAL["ON"].push(["D"+n, "B3"]);

  for(let i = 1; i < n; i++){
    for(let j = i + 1; j <= n; j++){
      stripN.INIT["FITS"].push(["D"+i, "D"+j]);
    }
  }

  for(let i = 1; i <= 3; i++){
    for(let j = 1; j <= n; j++){
      stripN.INIT["FITS"].push(["D"+j, "B"+i]);
    }
  }

  stripsDiv.html(
    "<br>" + "\"" + n + "\":" + JSON.stringify(stripN) + ",",
    true
  );

  console.log("Clear cache: Ctrl + Shift + Del");
}
