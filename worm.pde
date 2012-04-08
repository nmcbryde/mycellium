class Worm {
  int id;
  float x;
  float y;
  float vector;
  boolean dead = false;
  int speed = 1;
  int food = 160;
  
  Worm (int pid, float px, float py, float pv) {
    // initializer
    id = pid;
    x = px;
    y = py;
    vector = pv;
  }
  
  String toString() {
    return "("+x+", "+y+")";
  }
  
  void updateDirection() {
    float thirtyDegrees = PI / 12;
    float angle = 0;
    float bestAngle = 0;
    
    Score bestScoreSoFar = new Score(0, 0, 0, 0, 0);
    
    for (int i = 0; i < 6; i++) {
      angle = vector - ((random(0, 1) * thirtyDegrees)) + ((random(0, 1) * thirtyDegrees));
      
      // Calculate a new direction
      float tx = x + (cos(angle) * 3 * speed);
      float ty = y + (cos(angle) * 3 * speed);
     
      // test the source image
      Score score = getColour(tx, ty, srcImgData);
      
      if (score.score > bestScoreSoFar.score) {
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
          justBranched = 350;
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
    
    //log("Best score = " + Integer.toString(bestScoreSoFar.score));
    
    // favour the dark
    if (bestScoreSoFar.score > 555 && food < 255) {
      food += 2;
    }
    
    if (food <= 0) {
      dead = true;
      numberOfWorms--;
    }
  }
}
