function make2DArray(cols, rows){
  let arr = new Array(cols);
  for(let i=0; i < arr.length; i++){
    arr[i] = new Array(rows);
  }
  return arr;
}

let grid;
let cols;
let rows;
let resolution = 20;
let speed = 5;
let borders = false;
let next;

let generation = 0;

let divTitle;
let divGeneration;
let divResolution;
let divX;
let divY;
let divSpeed;
let divBorders;

let buttonNew;
let buttonStart;
let buttonPause;

let inputResolution;
let inputX;
let inputY;
let inputSpeed;

let sliderBorders;

let pause = false;

let start = false;

let maxResolution = 100;
let maxSpeed = 60;

function setup() {
  background(0);
  canvas = createCanvas(800, 600);
  canvas.position(0, 100);
  canvas.mousePressed(selectCell);
  setSize(800, 600);

  frameRate(speed);

  cols = width / resolution;
  rows = height / resolution;
  grid = make2DArray(cols,rows);

  for(let i = 0; i < cols; i ++){
    for(let j = 0; j < rows; j++){
      grid[i][j] = 0;
    }
  }

  fill(0);
  stroke(255);
  for(let i = 0; i < cols; i ++){
    for(let j = 0; j < rows; j++){
      rect(i*resolution, j*resolution, resolution, resolution);
    }
  }
  stroke(0);

  showBorders();

  divTitle = createDiv('The game of life - ');
  divTitle.position(10, 10);
  divTitle.style('font-size', '24px');
  divTitle.style('font-family','Ubuntu, sans-serif');
  divTitle.style('color',color(51));

  divGeneration = createDiv('Generation : ' + generation);
  divGeneration.position(200, 10);
  divGeneration.style('font-size', '24px');
  divGeneration.style('font-family','Ubuntu, sans-serif');
  divGeneration.style('color',color(255, 0, 100));

  buttonStart = createButton("START");
  buttonStart.position(10, 60);
  buttonStart.mousePressed(startGame);

  buttonPause = createButton("PAUSE");
  buttonPause.position(buttonStart.x + buttonStart.width + 10, 60);
  buttonPause.mousePressed(pauseGame);

  buttonNew = createButton("NEW");
  buttonNew.position(buttonPause.x + buttonPause.width + 10, 60);
  buttonNew.mousePressed(newGame);

  divResolution = createDiv('Res : ');
  divResolution.position(buttonNew.x + buttonNew.width + 10, 60);
  divResolution.style('font-size', '16px');
  divResolution.style('font-family','Ubuntu, sans-serif');
  divResolution.style('color',color(51));

  inputResolution = createInput("" + resolution);
  inputResolution.position(buttonNew.x + buttonNew.width + 70, 60);
  inputResolution.size(50);

  divX = createDiv('Width : ');
  divX.position(inputResolution.x + inputResolution.width + 10, 60);
  divX.style('font-size', '16px');
  divX.style('font-family','Ubuntu, sans-serif');
  divX.style('color',color(51));

  inputX = createInput("" + width);
  inputX.position(inputResolution.x + inputResolution.width + 70, 60);
  inputX.size(50);

  divY = createDiv('Height : ');
  divY.position(inputX.x + inputX.width + 10, 60);
  divY.style('font-size', '16px');
  divY.style('font-family','Ubuntu, sans-serif');
  divY.style('color',color(51));

  inputY = createInput("" + height);
  inputY.position(inputX.x + inputX.width + 70, 60);
  inputY.size(50);

  divSpeed = createDiv('Speed : ');
  divSpeed.position(inputY.x + inputY.width + 10, 60);
  divSpeed.style('font-size', '16px');
  divSpeed.style('font-family','Ubuntu, sans-serif');
  divSpeed.style('color',color(51));

  inputSpeed = createInput("" + speed);
  inputSpeed.position(inputY.x + inputY.width + 70, 60);
  inputSpeed.size(50);

  divBorders = createDiv('Borders (y/n) : ');
  divBorders.position(inputSpeed.x + inputSpeed.width + 10, 60);
  divBorders.style('font-size', '16px');
  divBorders.style('font-family','Ubuntu, sans-serif');
  divBorders.style('color',color(51));

  sliderBorders = createSlider(1, 2, 2);
  sliderBorders.position(inputSpeed.x + inputSpeed.width + 10, 75);
}

function draw() {
  if(!pause && start){
      background(0);
      fill(255);
      for(let i = 0; i < cols; i ++){
        for(let j = 0; j < rows; j++){
          if(grid[i][j] === 1){
            rect(i*resolution, j*resolution, resolution, resolution);
          }
        }
      }

      showBorders();

      generation++;
      showGeneration();

      next = make2DArray(cols,rows);
      let neighbors;
      for(let i = 0; i < cols; i ++){
        for(let j = 0; j < rows; j++){
          neighbors = countNeighbors(grid, i, j);
          if(grid[i][j] === 0 && neighbors === 3){
            next[i][j] = 1;
          }else if(grid[i][j] === 1 && (neighbors < 2 || neighbors > 3)){
            next[i][j] = 0;
          }else{
            next[i][j] = grid[i][j];
          }
        }
      }
      grid = next;

    }
}

function countNeighbors(grid, x, y){
  let sum = 0;
  let row;
  let col;
  for(let i = -1; i < 2; i++){
    for(let j = -1; j < 2; j++){
      if(borders){
        if( x + i >= 0 && x + i < cols && y + j >= 0 && y + j < rows){
          sum += grid[x+i][y+j];
        }
      }else{
        col = (x + i + cols) % cols;
        row = (y + j + rows) % rows;
        sum += grid[col][row];
      }
    }
  }
  sum -= grid[x][y];
  return sum;
}

function showGeneration(){
  divGeneration.html('Generation : ' + generation);
}

function newGame(){
  setResolution(int(inputResolution.value()));
  setSize(int(inputX.value()), int(inputY.value()));
  setSpeed(int(inputSpeed.value()));
  setBorders(sliderBorders.value()-1);
  logInputs();
  cols = width / resolution;
  rows = height / resolution;
  grid = make2DArray(cols,rows);
  for(let i = 0; i < cols; i ++){
    for(let j = 0; j < rows; j++){
      grid[i][j] = 0;
    }
  }
  generation = 0;
  showGeneration();
  pause = false;
  buttonPause.style('color',color(51));
  start = false;
  inputResolution.value("" + resolution);
  inputX.value("" + width);
  inputY.value("" + height);
  inputSpeed.value("" + speed);
  background(0);
  fill(0);
  stroke(255);
  for(let i = 0; i < cols; i ++){
    for(let j = 0; j < rows; j++){
      rect(i*resolution, j*resolution, resolution, resolution);
    }
  }
  stroke(0);
  showBorders();
}

function setResolution(res) {
  if(isNaN(res) || res < 1){
    res = resolution;
  }else if(res > maxResolution){
    res = maxResolution;
  }
  resolution = res;
}

function setSize(w, h) {
  let maxWidth = getMaxWidth();
  let maxHeight = getMaxHeight();

  if(isNaN(w) || w < 1){
    w = width;
  }else if(w > maxWidth){
    w = maxWidth;
  }
  if(isNaN(h) || h < 1){
    h = height;
  }else if(h > maxHeight){
    h = maxHeight;
  }

  if(w%resolution !== 0){
      w += (resolution - w%resolution);
      if(w > maxWidth){
        w -= resolution;
      }
  }
  if(h%resolution !== 0){
      h += (resolution - h%resolution);
      if(h > maxHeight){
        h -= resolution;
      }
  }

  resizeCanvas(w, h);
}

function setBorders(b) {
  if(b === 0){
    borders = true;
  }else if(b === 1){
    borders = false;
  }
}

function setSpeed(s) {
  if(isNaN(s) || s < 1){
    s = speed;
  }else if(s > maxSpeed){
    s = maxSpeed;
  }
  speed = s;
  frameRate(speed);
}

function getMaxWidth() {
  return windowWidth;
}

function getMaxHeight() {
  return windowHeight - 100;
}

function showBorders(){
  if(borders){
    stroke(255, 0, 10);
    strokeWeight(3);
    line(0, 0, width, 0);
    line(0, 0, 0, height);
    line(width, 0, width, height);
    line(0, height, width, height);
    stroke(0);
    strokeWeight(1);
  }
}

function logInputs(){
  console.log("Resolution : " + resolution);
  console.log("Width : " + width);
  console.log("Height : " + height);
  console.log("Speed : " + speed);
  console.log("Borders : " + borders);
  console.log(" ");
}

function startGame() {
  if(!start){
    start = true;

    for(let i = 0; i < cols; i ++){
      for(let j = 0; j < rows; j++){
        if(grid[i][j] === 1){
          return;
        }
      }
    }

    grid = make2DArray(cols,rows);
    for(let i = 0; i < cols; i ++){
      for(let j = 0; j < rows; j++){
        grid[i][j] = floor(random(2));
      }
    }

    stroke(0);
  }
}

function pauseGame() {
  pause = !pause;
  if(pause){
    buttonPause.style('color',color(255, 0, 100));
  }else{
    buttonPause.style('color',color(51));
  }
}

function selectCell(){
  if(!start){
    let selectX = (mouseX - mouseX%resolution + resolution)/resolution;
    let selectY = (mouseY - mouseY%resolution + resolution)/resolution;
    grid[selectX-1][selectY-1] = 1%(2-grid[selectX-1][selectY-1]);

    fill(255*grid[selectX-1][selectY-1]);
    stroke(255*(1-grid[selectX-1][selectY-1]));
    rect((selectX-1)*resolution, (selectY-1)*resolution, resolution, resolution);
  }
}
