int initialNumWorms = 10;
int maxWorms = 100;

int[] worms = new int[maxWorms];

int scoreToFavour = 255;

int counter = 0;

int branchThreshold = 230 * 4;

int lifetime = 100000;

int justBranched = 0;

boolean paused = false;

boolean once = true;

void setup() {
  size(400, 400);
  stroke(255);
  background(192, 64, 0);
}

void draw() {
  line( 150, 25, mouseX, mouseY);
}

void mousePressed() {
  pause();
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
