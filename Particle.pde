class Particle {
  float pos_x;
  float pos_y;
  float rad;
  boolean stuck = false;
  
  Particle(float _posX, float _posY, float maximumRadius, float minimumRadius) {
    pos_x = _posX;
    pos_y = _posY;
    rad = random(0,maximumRadius-minimumRadius) + minimumRadius;
  }

  void diffuse(float maxR) {
    if (!stuck) {
      int probability = floor(random(0,4));
      switch(probability) {
      case 0:
        pos_x += random(0,1);
        break;
      case 1:
        pos_x -= random(0,1);
        break;
      case 2:
        pos_y += random(0,1);
        break;
      case 3:
        pos_y -= random(0,1);
        break;
      }
    }
  
    float Rsq = (pos_x - width/2)*(pos_x - width/2) + (pos_y - height/2)*(pos_y - height/2);
    if (Rsq >= 2*maxR*maxR) {
      float theta = random(0,TWO_PI);
      pos_x = floor(maxR*cos(theta)) + width/2;
      pos_y = floor(maxR*sin(theta)) + height/2;
    }
  }

  void intersect(Particle testParticle) {
    float radSum = (rad + testParticle.rad)*(rad + testParticle.rad);
    float centralDistance = (pos_x - testParticle.pos_x)*(pos_x - testParticle.pos_x) + (pos_y - testParticle.pos_y)*(pos_y - testParticle.pos_y);
    if (centralDistance <= radSum) {
      stuck = true;
    }
  }
  
  void render() {
    ellipse(pos_x,pos_y,rad,rad);
  }
}