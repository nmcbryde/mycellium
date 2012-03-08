int initialNumWorms = 10;
int maxWorms = 100;

Worm[] worms = new Worm[maxWorms];

int scoreToFavour = 255;

int numberOfWorms = 0;

int counter = 0;

int branchThreshold = 230 * 4;

int lifetime = 100000;

int justBranched = 0;

boolean paused = false;

boolean once = true;


// WINDOW SETUP
int windowWidth = 400;
int windowHeight = 400;

class Worm {
  int id;
  float x;
  float y;
  float vector;
  boolean dead = false;
  int speed = 1;
  int food = 100;
  
  Worm (int pid, float px, float py, float pv) {
    // initializer
    id = pid;
    x = px;
    y = py;
    vector = pv;
  }
  
  void updateDirection() {
    float thirtyDegrees = PI / 12;
    float angle = 0;
    float bestAngle = 0;
    
    Score bestScoreSoFar = new Score(0, 0, 0, 0, 99999999);
    
    for (int i = 0; i < 6; i++) {
      angle = vector - ((random(0, 1) * thirtyDegrees)) + ((random(0, 1) * thirtyDegrees));
      
      // Calculate a new direction
      float tx = x + (cos(angle) * 5 * speed);
      float ty = y + (cos(angle) * 5 * speed);
      
      // test the source image
      Score score = getColour(tx, ty, 2);
      
      if (score.score < bestScoreSoFar.score) {
        bestAngle = angle;
        bestScoreSoFar = score;
      }
    }
    
    justBranched--;
    
    if (bestScoreSoFar.score > branchThreshold) {
      if (justBranched <= 0) {
        float startAngle = vector + (random(0, 1) * thirtyDegrees);
        vector -= 0.37;
        
        if (numberOfWorms < maxWorms) {
          worms[numberOfWorms] = new Worm(numberOfWorms, x, y, startAngle);
          numberOfWorms++;
          
          justBranched = 500;
        } else {
          // too many worms
          for (int i = 0; i < worms.length; i++) {
            if (worms[i].dead == true) {
              worms[i] = new Worm(i, x, y, startAngle);
              numberOfWorms++;
              break;
             }
          }
        }
      } else {
        // just branched 
      }
    }
    
    vector = bestAngle;
    food--;
    
    
    // favour the dark
    if (bestScoreSoFar.score > 355) {
      food = 200;
    }
    
    if (food == 0) {
      
      log("worm died");
      dead = true;
      numberOfWorms--;
    }
  }
}

class Score {
  int r;
  int g;
  int b;
  int a;
  int score;
  
  Score(int pr, int pg, int pb, int pa, int pscore) {
    r = pr;
    g = pg;
    b = pg;
    a = pa;
    score = pscore;
  }
}

Score getColour(float px, float py, int src) {
  int tr = int(random(255));
  int tg = int(random(255));
  int tb = int(random(255));
  int ta = int(random(255));
  int ts = tr + tg + tb + ta;
  
  return new Score(tr, tg, tb, ta, ts);
}

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
  size(windowWidth, windowHeight);
  stroke(0);
  background(255, 255, 255);
  smooth();
  initWorms();
  
  
}



void draw() {
  for (int i = 0; i < numberOfWorms; i++) {
    Worm w = worms[i];
    
    if(w.dead == false) {
      
      log("worm is alive and is at -  " + Float.toString(w.x) + " " + Float.toString(w.y));
      line(w.x, w.y, w.x + 0.1, w.y + 0.1);
      
      
      //arc(w.x, w.y, 0.5, 0.5, PI, 2*PI);
      
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
  pause();
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
