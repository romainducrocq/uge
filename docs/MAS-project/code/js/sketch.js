let nDisks = 5;

let strips;
let startState;
let solution;

async function loadData(){
  let response = await fetch('strips.json');
  let data = await response.json();
  return data;
}

function setup() {
  canvas = createCanvas(1200, 600);
  initgui();
  loadData()
    .then(data => setup_(data))
    .catch(reason => console.log(reason.message))
}

function setup_(data){
  strips = data;
  run(parseInt(diskDropdown.value()));
}

function run(n){
  nDisks = n;

  end = findEnd();
  startState = initialState();

  initguiData();

  solution = astar();

  displaySolution();
}

function draw() {
  noLoop();
}

/*

Div = createDiv("");
Div.position(,);
Div.style('font-size', '16px');
Div.style('font-family','Ubuntu, sans-serif');
Div.style('color',color(51));
// let val = Div.html(); //get
// Div.html(""); //set

Button = createButton("");
Button.position(,);
Button.style('font-size', '16px');
Button.style('font-family','Ubuntu, sans-serif');
Button.style('color',color(51));
Button.mousePressed(function);

Slider = createSlider(1, 3, 2, 1);
Slider.position(,);
// let val = Slider.value(); //get
// Slider.value(int); //set

Input = createInput("");
Input.position(,);
Input.size(50);
Input.value("");
// let val = Input.value(); //get
// Input.value(""); //set

Checkbox = createCheckbox("", boolean);
Checkbox.position(,);
// let val = Checkbox.checked(); //get
// Checkbox.checked(boolean); //set

function keyPressed() {
  if(keyCode === 80){ //P
  }else if(keyCode === 32){ //SPACE
  }else if(keyCode === UP_ARROW){
  }else if (keyCode === DOWN_ARROW){
  }else if (keyCode === LEFT_ARROW){
  }else if (keyCode === RIGHT_ARROW){
  }
}

function mousePressed() {
}
*/
