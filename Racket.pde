class Racket {
  color c;
  float width;
  float height;
  Racket(color c, float w, float h) {
    width = w;
    height = h;
    this.c = c;
  }

  void display() {
    noStroke();
    fill(255, 0, 0);
    rectMode(CENTER);
    rect(mouseX, mouseY, width, height);
  }
}
