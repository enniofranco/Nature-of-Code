class NodeMaster {
  Node[][] nodes;
  int densityX, densityY, densityZ;
  PVector noiseNodeOff;
  float noiseFieldOff;
  float noiseScale;
  float noiseNodeOffInc;
  float zoff;

  NodeMaster(int _densityX, int _densityY, int _densityZ, float _x, float _y) {
    densityX = _densityX;
    densityY = _densityY;
    densityZ = _densityZ;
    int arraySize = densityX * densityY;
    nodes = new Node[densityZ][arraySize];
    noiseScale = 0.02;
    noiseNodeOffInc = 0.05;
    zoff = 0;

    float shapeSizeX = 4*densityX + (densityZ*2);
    float shapeSizeY = 4*densityY + (densityZ*2);
    _x = _x - shapeSizeX/2;
    _y = _y - shapeSizeY/2;

    for (int z = 0; z < densityZ; z++) {
      for (int x = 0; x < densityX; x++) {
        for (int y = 0; y < densityY; y++) {
          float _nodeX = (4*x+(z*2)) + _x;
          float _nodeY = (4*y+(z*2)) + _y;
          PVector pos = new PVector(_nodeX, _nodeY);
          nodes[z][x+y*densityX] = new Node(pos, 40);
        }
      }
    }
    noiseNodeOff = new PVector(10, 10000);
  }

  void update() {
    float _zoff = 0;
    for (int z = 0; z < densityZ; z++) {
      fill(100 + z * 5);

      for (int x = 0; x < densityX; x++) {
        for (int y = 0; y < densityY; y++) {
          noiseFieldOff = noise(x*noiseScale, y*noiseScale, zoff + _zoff);
          float fieldOff = map(noiseFieldOff, 0, 1, 0, 0.5);
          float noiseX = noise(noiseNodeOff.x + fieldOff);
          float noiseY = noise(noiseNodeOff.y + fieldOff);
          nodes[z][x+y*densityX].update(noiseX, noiseY);
          nodes[z][x+y*densityX].render();
        }
      }
      _zoff += 0.2;
    }
    noiseNodeOff.add(0.001, 0.001);
    zoff += 0.05;
  }
}