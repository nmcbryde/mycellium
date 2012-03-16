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

Score getColour(float px, float py, PImage src) {
  int tx = floor(px);
  int ty = floor(py);
  
  int index = ((tx * 4) + ((ty * 4) * src.width));
  
  color c = src.get(tx, ty);
  
  int tr = (int)red(c);
  int tg = (int)green(c);
  int tb = (int)blue(c);
  
  int ts = tr + tg + tb + 1;
  
  return new Score(tr, tg, tb, 1, ts);
}
