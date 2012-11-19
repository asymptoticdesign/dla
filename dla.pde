//  Title: Diffusion Limited Aggregation
//  Description: 
//  Date Started: Nov 2012
//  Last Modified: Nov 2012
//  http://www.asymptoticdesign.org/
//
//

//-----------------Globals
ArrayList particleList;
Grid particleGrid;
float maxRad = 10;
float minRad = 2;
float maxEnclosingRad;
Particle currentParticle;
float strokeHue = random(TWO_PI);

//-----------------Setup
void setup() {
  size(1200,900);
  background(0);
  colorMode(HSB,TWO_PI,1.0,1.0);
  stroke(strokeHue,1.0,1.0);
  noFill();
  reset();
}

//-----------------Main Loop
void draw() {
  if (maxEnclosingRad < height/2) {
    strokeHue = (strokeHue + TWO_PI / 1800) % TWO_PI;
    while(!currentParticle.stuck) {
      currentParticle.diffuse(maxEnclosingRad);
      int[] centralBins = particleGrid.getBinNumbers(currentParticle.pos_x,currentParticle.pos_y);
      for(int i = -1; i <= 1; i++) {
        for(int j = -1; j <= 1; j++) {
          ArrayList<Particle> neighboringParticles = particleGrid.getParticles(centralBins[0]+i,centralBins[1]+j);
          for(int k = 0; k < neighboringParticles.size(); k++) {
            currentParticle.intersect(neighboringParticles.get(k));
            if(currentParticle.stuck) {
              break;
            }
          }
        }
      }
    }
    //draw particle
    currentParticle.render(strokeHue);
    particleGrid.addParticle(currentParticle);
    //determine new maximum enclosing radius
    float currentDistance = dist(width/2,height/2,currentParticle.pos_x,currentParticle.pos_y) + currentParticle.rad;
    maxEnclosingRad = max(1.2*currentDistance,maxEnclosingRad);
    //create new particle
    float theta = random(0,TWO_PI);
    currentParticle = new Particle(floor(maxEnclosingRad*cos(theta)) + width/2, floor(maxEnclosingRad*sin(theta)) + height/2, maxRad, minRad);
    particleList.add(currentParticle);
  }
  else {
    reset();
  }
}

//-----------------Defined Functions
void reset() {
  background(0);
  maxEnclosingRad = 3*maxRad; 
  particleGrid = new Grid(15,width,height);
  particleList = new ArrayList();
  particleList.add(new Particle(width/2,height/2,maxRad,minRad));
  currentParticle = (Particle)particleList.get(0);
  currentParticle.stuck = true;
  currentParticle.render(strokeHue);
  particleGrid.addParticle(currentParticle);
}
