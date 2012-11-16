class Particle {
  float pos_x;
  float pos_y;
  float rad;
  boolean stuck = false;
  
  Particle(float _posX, float _posY, float maximumRadius) {
    pos_x = _posX;
    pos_y = _posY;
    rad = Math.random(0,maximumRadius);
  }

  void diffuse() {
    if (!stuck) {
      float probability = Math.floor(Math.random(0,4));
      switch(probability) {
      case 0:
        pos_x += Math.random();
        break;
      case 1:
        pos_x -= Math.random();
        break;
      case 2:
        pos_y += Math.random();
        break;
      case 3:
        pos_y -= Math.random();
        break;
      }
    }
  
    float Rsq = (pos_x - width/2)*(pos_x - width/2) + (pos_y - height/2)*(pos_y - height/2);
    if (Rsq >= 2*maxR*maxR) {
      float theta = Math.random(0,TWO_PI);
      pos_x = Math.floor(maxR*Math.cos(theta)) + width/2;
      pos_y = Math.floor(maxR*Math.sin(theta)) + height/2;
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
    
