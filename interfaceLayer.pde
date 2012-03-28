class InterfaceLayer extends Layer {

  InterfaceLayer(PApplet parent) {
    super(parent); // This is necessary!
  }

  void draw() {
    //background(0, 0); // clear the background every time, but be transparent
    // now draw something
  }
  
  
  int boxWidth = 100;
  
  void mousePressed() {
  //  log(Integer.toString(mouseX));
  //  log(Integer.toString(mouseY));
    
    //Score s = getColour(mouseX, mouseY, srcImgData);
    //log(Integer.toString(s.score));
    if (paused == false) {
      pause();
    }
    
    Worm bestWormSoFar = null;
    
    for (int i = 0; i < numberOfWorms; i++) {
      Worm w = worms[i];
      if ( (w.x > mouseX-(boxWidth/2) && w.x < mouseX+(boxWidth/2)) && (w.y > mouseY-(boxWidth/2) && w.y < mouseY+(boxWidth/2)) ) {
        if (bestWormSoFar == null) {
          bestWormSoFar = w;
        } else {
          if (distanceBetween(mouseX, mouseY, w.x, w.y) < distanceBetween(mouseX, mouseY, bestWormSoFar.x, bestWormSoFar.y)) {
            bestWormSoFar = w;
          }
        }
      }
    }
    
    if (bestWormSoFar != null) {
      log(Integer.toString(mouseX) + " " + Integer.toString(mouseY));
      noFill();
      stroke(255, 0, 0);
      ellipse(bestWormSoFar.x, bestWormSoFar.y, 10, 10);
    }
  }
  
  
  float distanceBetween(float x1, float y1, float x2, float y2) {
    return sqrt(sq(x1 - x2) + sq(y1 - y2));
  }
  
  
  void keyPressed() {
    if (key == ' ') {
      pause();
    }
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
}
