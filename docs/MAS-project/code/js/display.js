let canvas;

let titleDiv;
let diskDropdownDiv;
let solutionTitleDiv;
let solutionDiv;
let stripsDivTitle;
let stripsDiv;

let diskDropdown;

let runButton;

let stackNumberDiv;

let colB;
let colD;

let startWorld;

let finish;

function displaySolution(){

  solutionDiv.html("<strong style='color:rgb(220, 0, 100);'>-> " + solution.length + " STACKS" + "</strong><br><br>", true);

  for(let i = 0; i < solution.length; i++){
    solutionDiv.html("<strong style='color:rgb(220, 0, 100);'>" + (i+1) + "</strong>" + ": " +
    /*"<span id='stack-" + (i+1) + "'>" + */"STACK(" + solution[i][0] + ", " + solution[i][1] + ", " + solution[i][2] + ")" /*+ "</span>*/ + "<br>", true);
  }

  stackNumberDiv.html('<span style="color:rgb(255,0,100);">0</span>' + " / " + solution.length);

  runButton.show();

  finish = true;
}

function initgui(){

  background(220);
  canvas.position(300, 100);

  titleDiv = createDiv('<strong>Tower of Hanoi with <span style="color:rgb(255, 0, 100);">STRIPS</span> and <span style="color:rgb(255, 0, 100);">A*</span></strong> - ')
    .position(10, 10)
    .style('font-size', '40px');

  diskDropdownDiv = createDiv('Number of disks: ')
    .position(700, 10)
    .style('font-size', '40px');

  diskDropdown = createSelect('')
    .style('font-size', '32px')
    .parent(diskDropdownDiv);

  for(let i = 1; i <= 8; i++){
    diskDropdown.option(i);
  }

  diskDropdown.value(nDisks);
	diskDropdown.changed(reset);

  solutionTitleDiv = createDiv('Solution:')
    .position(10, 100)
    .style('font-size', '40px');

  solutionDiv = createDiv('<br>')
    .position(10, solutionTitleDiv.y + solutionTitleDiv.height + 20)
    .style('font-size', '24px');

  runButton = createButton("RUN")
    .position(canvas.x + 20, canvas.y + 20)
    .style('font-size', '40px')
    .mousePressed(displayAnimation);

  stackNumberDiv = createDiv('')
    .position(canvas.x + width - 200, canvas.y + 20)
    .style('font-size', '40px');

  stripsDivTitle = createDiv('<strong>Strips</strong>:')
    .position(canvas.x, height + canvas.y + 20)
    .style('font-size', '24px');

  stripsDiv = createDiv('')
    .position(canvas.x , stripsDivTitle.height + stripsDivTitle.y + 20)
    .size(width, AUTO);

  colB = color(floor(random(255)), floor(random(255)), floor(random(255)));
  colD = color(floor(random(255)), floor(random(255)), floor(random(255)));
}

function initguiData(){
  let finish = false;

  stripsDiv.html(
    "\"" + "ACTIONS" + "\":" + JSON.stringify(strips["ACTIONS"]) + "<br>" +
    "\"" + nDisks + "\":" + JSON.stringify(strips[nDisks])
  );

  solutionDiv.html('<br>')

  runButton.hide();

  startWorld = exploreWorld(startState);

  displayState(startWorld);
}

function displayState(world){
  background(220);
  strokeWeight(3);
  for(tower in world){
    push();
    translate(tower * width / 3 + width / 6, 0);
    fill(colB);
    rect(-width / 6 + 1, height - 50, width / 3 - 1, 50);
    fill(colD);
    for(let i = 1; i < world[tower].length; i++){
      let diskSize = diskDimension(world[tower][i-1].charAt(1));
      let diskPos = diskPosition(world[tower][i-1].charAt(1), world[tower].length - i);
      rect(
        diskPos.x,
        diskPos.y,
        diskSize.x,
        diskSize.y
      );
    }
    pop();
  }
}

function diskDimension(weight){
  return createVector(
    weight / (nDisks + 1) * width / 3,
    ( 0.75 * (height - 50)) / nDisks
  );
}

function diskPosition(weight, order){
  return createVector(
    -(weight / (nDisks + 1) * width / 6),
    height - 50 - (((0.75 * (height - 50)) / nDisks) * order),
  )
}


function displayAnimation(){
  finish = false;

  runButton.hide();

  let world = JSON.parse(JSON.stringify(startWorld));

  for(let i = 0; i < solution.length; i++){
    setTimeout(function() {
      nextWorldWithWorld(world, solution[i]);
      displayState(world);
      stackNumberDiv.html('<span style="color:rgb(255,0,100);">' + (i+1) + '</span>' + " / " + solution.length);
      if(i == solution.length - 1){
        finish = true;
      }
    }, 500 * i);
  }
}

function reset(){
  if(finish){
    run(parseInt(diskDropdown.value()));
  }
}
