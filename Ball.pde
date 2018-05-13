class Ball {
  float x;
  float y;
  float d;
  color c;
  float yspeed;
  float xspeed;

  Ball(color c, float x, float y, float d) {
    this.c = c;
    this.x = x;
    this.y = y;
    this.d = d;
    this.yspeed = 0;
    this.xspeed = 0;
  }

  void display() {
    fill(c);
    ellipse(x, y, d, d);
  }
}
