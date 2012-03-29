class InterfaceLayer extends Layer {
  int boxWidth = 100;
  Console c = new Console();
  
  InterfaceLayer(PApplet parent) {
    super(parent);
  }
  
  
  void draw() {
  }
  
  void mousePressed() {    
    if (paused == false) {
      pause();
    }
    
    Worm bestWormSoFar = null;
    
    for (int i = 0; i < numberOfWorms; i++) {
      log(Integer.toString(i));
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
      background(0, 0);
      c.show();
      c.log(Float.toString(bestWormSoFar.x) + " " + Float.toString(bestWormSoFar.x));
      
      noFill();
      stroke(255, 0, 0);
      ellipse(bestWormSoFar.x, bestWormSoFar.y, 10, 10);
      redraw();
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
      case('q'):
        exit();
        break;
      default:
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
      
      
      c.log("test");
    }
  }
  
  class Console {
    int topEdge;
    int currentHeight = 0;
    int padding = 20;
    
    Console () {
      topEdge = floor(windowHeight-(windowHeight*.2));
    }
    
    void show() {
      noStroke();
      fill(0, 0, 0, 100);
      rect(0, topEdge, windowWidth, windowHeight*.2);
    }
    
    
    void log(String message) {
      fill(255, 255, 255);
      text(message, padding, (topEdge + padding + currentHeight));
    }
  }

}


