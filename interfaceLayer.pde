class InterfaceLayer extends Layer {
  int boxWidth = 100;
  Console c = new Console();
  
  InterfaceLayer(PApplet parent) {
    super(parent);
  }
  
  
  void draw() {
  }
  
  
  /*
   * Finds the nearest worm to the cursor
   * Draws a box 50 pixels each side of the x and y points and loops over the pixels looking for worms. 
   * If a worm is found it measures it against the last worm found to see if its closer, and if so replaces the previous nearest worm.
   */
  Worm findNearestWorm() {
    
    Worm nearestWormSoFar = null;
    
    for (int i = 0; i < numberOfWorms; i++) {
      Worm w = worms[i];
      if ( (w.x > mouseX-(boxWidth/2) && w.x < mouseX+(boxWidth/2)) && (w.y > mouseY-(boxWidth/2) && w.y < mouseY+(boxWidth/2)) ) {
        if (nearestWormSoFar == null) {
          nearestWormSoFar = w;
        } else {
          if (distanceBetween(mouseX, mouseY, w.x, w.y) < distanceBetween(mouseX, mouseY, nearestWormSoFar.x, nearestWormSoFar.y)) {
            nearestWormSoFar = w;
          }
        }
      }
    }
   
    return nearestWormSoFar; 
  }
  
  void mousePressed() {
    if (paused == false) {
      pause();
    }
    
    Worm nearestWorm = findNearestWorm();
    
    if (nearestWorm != null) {
      background(0, 0);
      
      c.show();
      if (nearestWorm.dead) {
        c.log("The worm is dead");
      }
      
      c.log("X: " + Float.toString(nearestWorm.x) + ", Y: " + Float.toString(nearestWorm.x));
      c.log("Food " + Integer.toString(nearestWorm.food));
      
      showDirections(nearestWorm);
      
      Score s = getColour(nearestWorm.x, nearestWorm.y, srcImgData);
      
      c.log("Score " + s.score);
      
      noFill();
      stroke(255, 0, 0);
      ellipse(nearestWorm.x, nearestWorm.y, 10, 10);
      redraw();
    } else {
      background(0, 0);
      c.show();
      c.log("Score " + getColour(mouseX, mouseY, srcImgData).score);
    }
    
    
  }
  
  
  float distanceBetween(float x1, float y1, float x2, float y2) {
    return sqrt(sq(x1 - x2) + sq(y1 - y2));
  }
  
  
  void keyPressed() {
    switch (key) {
      case(' '):
        pause();
        break;
      case('s'):
        save("snapshots/output-"+Integer.toString(outputCounter++)+".jpg");
        break;
      case('i'):
        showBackgroundImage();
        break;
      case('q'):
        exit();
        break;
      default:
    }
  }
  
  void showBackgroundImage() {
    if(paused) {
      pause();
    } else {
      pause();
      image(srcImgData, 0, 0);
    }
  }
  
  void showDirections(Worm worm) {
    
    float thirtyDegrees = PI/12;
    float angle = 0;
    float bestAngle = 0;
    
    Score bestScoreSoFar = new Score(0, 0, 0, 0, 0);
    
    for (int i = 0; i < 6; i++) {
      angle = worm.vector - ((random(0, 1) * thirtyDegrees)) + ((random(0, 1) * thirtyDegrees));
      
      float tx = worm.x + (cos(angle) * 30 * worm.speed);
      float ty = worm.y + (sin(angle) * 30 * worm.speed);
      
      stroke(0);
      line(worm.x, worm.y, tx, ty);
      
      // test the source image
      Score score = getColour(tx, ty, srcImgData);
      
      if (score.score > bestScoreSoFar.score) {
        bestAngle = angle;
        bestScoreSoFar = score;
      }
    }
    
    float tx = worm.x + (cos(bestAngle) * 30 * worm.speed);
    float ty = worm.y + (sin(bestAngle) * 30 * worm.speed);
    stroke(255, 0, 0);
    line(worm.x, worm.y, tx, ty);
  }
  
  void pause() {
    if ( paused == true ) {
      paused = false;
      background(0, 0); // clear the background every time, but be transparent
      loop();
      
    } else {
      paused = true;
      noLoop();
    }
  }
  
  class Console {
    int topEdge;
    int currentHeight = 0;
    int padding = 20;
    int opacity = 200;
    
    Console () {
      topEdge = floor(windowHeight-(windowHeight*.2));
    }
    
    void show() {
      noStroke();
      fill(0, 0, 0, opacity);
      rect(0, topEdge, windowWidth, windowHeight*.2);
      currentHeight = 0;
    }
    
    
    void log(String message) {
      fill(255, 255, 255);
      text(message, padding, (topEdge + padding + currentHeight));
      currentHeight += 20;
    }
  }

}


