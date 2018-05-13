import java.util.Random;
class Pillar {
  float x;
  float y;
  float w;
  float h;
  color c;
  float yBegin;
  float yEnd;
  float gap;

  Pillar(float x, float y, float w, float h, color c, float gap) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
    this.gap = gap;
    Random r = new Random();
    yBegin = r.nextInt((int)(h-gap));
    yEnd = yBegin + gap;
  }

  void display() {
    noStroke();
    fill(c);
    //rectMode(CORNER);
    //rect(x,0,w,h);
    rectMode(CORNERS);
    rect(x, 0, x + w, yBegin);
    rect(x, yEnd, x + w, h);
  }
}
