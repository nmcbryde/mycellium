import com.nootropic.processing.layers.*;

// Layers
AppletLayers layers;

// Counters
int numberOfWorms = 0;
int counter = 0;
int justBranched = 0;
boolean paused = false;

// Variables
int initialNumWorms = 100;
int maxWorms = 1000;
int scoreToFavour = 500;
int branchThreshold = 300;

//srcImgData = loadImage("clint-eastwood.jpg");
String imgSrc = "photograph_test_02.jpg";
//String imgSrc = "clint-eastwood.jpg";

// Setup
int windowWidth;
int windowHeight;
int outputCounter;

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

void paint(java.awt.Graphics g) {
  // This method MUST be present in your sketch for layers to be rendered!
  if (layers != null) {
    layers.paint(this);
  } else {
    super.paint(g);
  }
}

void setup() {
  stroke(0);
  background(255, 255, 255);
  smooth();
  
  outputCounter = 1;
  
  srcImgData = loadImage(imgSrc);
  windowWidth = srcImgData.width;
  windowHeight = srcImgData.height;
  
  size(windowWidth, windowHeight);
  
  layers = new AppletLayers(this);
  InterfaceLayer m = new InterfaceLayer(this);
  layers.addLayer(m);
  
  srcImgData.loadPixels();
  initWorms();
}



void draw() {
  for (int i = 0; i < numberOfWorms; i++) {
    Worm w = worms[i];
    
    if(w.dead == false) {
      stroke(0, w.food/2);
      
      /*
      0 = low
      255 = high
      
      food = 100 alpha = 50
      
      food = 1 alpha should = 0
      food = 700 alpha should = 255
      */
      
      strokeWeight(1);
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

void log(String message) {
  println(message); 
}
