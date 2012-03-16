
// Counters
int numberOfWorms = 0;
int counter = 0;
int justBranched = 0;
boolean paused = false;

// Variables
int initialNumWorms = 40;
int maxWorms = 100;
int scoreToFavour = 0;
int branchThreshold = 250;


// Setup
int windowWidth;
int windowHeight;

// Holders
Worm[] worms = new Worm[maxWorms];
PImage srcImgData;


void initWorms() {
  for (int i = 0; i < initialNumWorms; i++) {
    int tx = floor(random(0, 1) * windowWidth);
    int ty = floor(random(0, 1) * windowHeight);
    
    float angle = random(0, 1) * 2 * PI;
    
    worms[i] = new Worm(i, tx, ty, angle);
    numberOfWorms++;
  }
}

void setup() {
  stroke(0);
  background(255, 255, 255);
  smooth();
  
  srcImgData = loadImage("clint-eastwood.jpg");
  windowWidth = srcImgData.width;
  windowHeight = srcImgData.height;
  
  size(windowWidth, windowHeight);
  
  srcImgData.loadPixels();
  
  initWorms();
}



void draw() {
  for (int i = 0; i < numberOfWorms; i++) {
    Worm w = worms[i];
    
    if(w.dead == false) {
      
      //log("worm is alive and is at -  " + Float.toString(w.x) + " " + Float.toString(w.y));
      line(w.x, w.y, w.x + 0.1, w.y + 0.1);
      
      
      w.x += (cos(w.vector) * w.speed);
      w.y += (sin(w.vector) * w.speed);
      
      worms[i].updateDirection();
      
      if (w.x > windowWidth) w.x = 0;
      if (w.x < 0) w.x = windowWidth;
      if (w.y > windowHeight) w.y = 0;
      if (w.y < 0) w.y = windowHeight;
    }
  }
}

void mousePressed() {
//  log(Integer.toString(mouseX));
//  log(Integer.toString(mouseY));
  
  Score s = getColour(mouseX, mouseY, srcImgData);
  log(Integer.toString(s.score));
}

void keyPressed() {
  if (key == ' ') {
    pause();
  }
}


void log(String message) {
  println(message); 
}

void pause() {
  if ( paused == true ) {
    paused = false;
    loop();
  } else {
    paused = true;
    noLoop();
  }
}
