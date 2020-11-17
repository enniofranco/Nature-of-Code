class Node {
  PVector iniPos;
  PVector amplitude;
  PVector[] pos;
  float angle;
  float velocity;
  float acceleration;
  float nodeSize;
  int nodes;

  Node() {
    angle = 0;
    velocity = 0;
    acceleration = 0;
    iniPos = new PVector(width/2, height/2);
    amplitude = new PVector(200, 0);

    nodes = 28;
    nodeSize = 16;

    pos = new PVector[nodes];
    for (int i = 0; i < pos.length; i++) {
      pos[i] = new PVector();
    }
  }

  void update() {
    velocity += acceleration;
    angle += velocity;
    acceleration = 0;
  }

  void render() {

    int arrayLast = nodes - 1;
    pos[0].x = cos(angle) * amplitude.x + iniPos.x;
    pos[0].y = sin(angle) * amplitude.y + iniPos.y;

    pos[arrayLast].x = cos(angle + PI) * amplitude.x + iniPos.x;
    pos[arrayLast].y = sin(angle + PI) * amplitude.y + iniPos.y;

    float spacesX = (pos[arrayLast].x - pos[0].x) / (nodes-1);
    float spacesY = (pos[arrayLast].y - pos[0].y) / (nodes-1);

    for (int i = 1; i < nodes-1; i++) {
      fill(255, 255, 0, 200);
      pos[i].x = pos[i-1].x + spacesX;
      pos[i].y = pos[i-1].y + spacesY;
    }

    noStroke();
    rectMode(CENTER);


    float testAngle = angle % TWO_PI;
    if (testAngle >= 0 && testAngle <= PI) {
      //TOP HALF
      for (int i = 0; i < pos.length; i++) {
        if (i == 0 || i == pos.length-1) {
          fill(0, 200);
        } else {
          fill(255, 255, 20, 200);
        }
        rect(pos[i].x, pos[i].y, nodeSize, nodeSize);
      }
    } else if (testAngle > PI && testAngle <=TWO_PI) {
      //BOTTOM HALF
      for (int i = arrayLast; i >= 0; i--) {
        if (i == 0 || i == pos.length-1) {
          fill(0, 200);
        } else {
          fill(255, 255, 20, 200);
        }
        rect(pos[i].x, pos[i].y, nodeSize, nodeSize);
      }
    }
  }

}
