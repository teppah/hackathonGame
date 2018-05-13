import java.util.ArrayList;

Ball b;
Racket r;
PFont f;
float gravity = 1.2;
float airFriction = 0.001;
float friction = 0.07;
int gameState;
float ballWidth = 30;
float racketWidth = 100;
float racketHeight = 10;
float pillarSize = 60;
float pillarInterval = 350;
float pillarGap = 300;
float pillarSpeed = 5;
ArrayList<Pillar> pillars;


void setup() {
  size(800, 800);
  noStroke();
  frameRate(60);
  b = new Ball(color(0, 255, 0), width/2, height/2, ballWidth);
  r = new Racket(color(255, 0, 0), racketWidth, racketHeight);
  gameState = 0;
  pillars = new ArrayList();
  f = createFont("Arial", 50, true);
  textFont(f, 50);
}

void draw() {
  switch(gameState) {
  case 0:
    initScreen();
    break;
  case 1:
    gameScreen();
    break;
  case 2:
    gameOver();
  }
}

void keyPressed() {
  if (key == 'r') {
    gameState = 0;
    pillars.clear();
  }
}

void gameOver() {
  textFont(f, 50);
  textAlign(CENTER);
  background(0);
  fill(255);
  text("GAME OVER", height/2, width/3);
  int score = pillars.size();
  String s = "Score: " + (score-2);
  text(s, width/2, 2*height/3);
  textFont(f,30);
  text("Press r to restart", width/2 ,3*height/4);
}

void initScreen() {
  textFont(f, 50);
  background(0);
  textAlign(CENTER);
  fill(255);
  text("Click to Start", height/2, width/2);
}

void gameScreen() {
  background(255);
  b.display();
  r.display();
  applyGravity();
  keepInFrame();
  racketBounce();
  drawPillars();
  collisionDetect();
  println(pillars.size());
}

void mousePressed() {
  if (gameState == 0) {
    gameState++;
  }
}

void applyGravity() {
  b.yspeed += gravity;
  b.y += b.yspeed;
  b.yspeed -= b.yspeed * airFriction;
}

void collisionDetect() {
  for (int i = 0; i < pillars.size(); i++) {
    Pillar p = pillars.get(i);
    if ((b.x >= p.x && b.x <= p.x + p.w) && ((b.y >= 0 && b.y <= p.yBegin) ||
      (b.y >= p.yEnd && b.y <= p.h))) {
      gameState = 2;
    }
  }
}

//void collisionDetect() {
//  for (int i = 0; i < pillars.size(); i++) {
//    Pillar p = pillars.get(i);
//    if ((b.x >= p.x && b.x <= p.x + p.w) && (b.y >= 0 && b.y <= p.yBegin) ||
//      (b.x >= p.x && b.x <= b.x + p.w) && (b.y >= p.yEnd && b.y <= p.h)) {
//      gameState = 2;
//    }
//  }
//}

void keepInFrame() {
  if (b.y + b.d/2 > height) {
    bounceBottom(height);
  }
  if (b.y- b.d/2 < 0) {
    bounceTop(0);
  }
}

void drawPillars() {
  if (pillars.isEmpty()) {
    println(1);
    pillars.add(new Pillar(width, 0, pillarSize, height, color(0), pillarGap));
  } else {
    if (abs(pillars.get(pillars.size()-1).x - width) >= pillarInterval) {
      pillars.add(new Pillar(width, 0, pillarSize, height, color(0), pillarGap));
    }
  }
  translatePillars();
}


void translatePillars() {
  for (int i = 0; i < pillars.size(); i++) {
    pillars.get(i).display();
    pillars.get(i).x -= pillarSpeed;
  }
}

void racketBounce() {
  float overhead = mouseY - pmouseY;
  if ((b.x + ballWidth/2) < (mouseX + racketWidth/2) && (b.x + ballWidth/2) > (mouseX - racketWidth/2)) {
    if (dist(b.x, b.y, b.x, mouseY) <= (ballWidth/2 + abs(overhead))) {
      bounceBottom(mouseY);
      if (overhead < 0) {
        b.y += overhead;
        b.yspeed += overhead;
      }
    }
  }
}

void bounceBottom(float surface) {
  b.y = surface - b.d/2;
  b.yspeed *= -1;
  b.yspeed -= b.yspeed * friction;
}

void bounceTop(float surface) {
  b.y = surface + b.d/2;
  b.yspeed *= 0.1;
  b.yspeed -= b.yspeed * friction;
}
