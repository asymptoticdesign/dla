//  Title: Diffusion Limited Aggregation
//  Description: Tiles the entire image with quad-symmetric tiles sampled from the input image to create a wallpaper.
//  Date Started: Nov 2012
//  Last Modified: Nov 2012
//  http://www.asymptoticdesign.org/
//  This work is licensed under a Creative Commons 3.0 License.
//  (Attribution - NonCommerical - ShareAlike)
//  http://creativecommons.org/licenses/by-nc-sa/3.0/
//
//  In summary, you are free to copy, distribute, edit, and remix the work.
//  Under the conditions that you attribute the work to me, it is for
//  noncommercial purposes, and if you build upon this work or otherwise alter
//  it, you may only distribute the resulting work under this license.
//
//  Of course, the conditions may be waived with permission from the author.

//-----------------Globals
ArrayList particleList;
Grid particleGrid;
float maxRad = 10;
float minRad = 2;
float maxEnclosingRad = 3*maxRad;
Particle currentParticle;

//-----------------Setup
void setup() {
  background(0);
  stroke(255);
  noFill();
  size(1200,900);
  particleGrid = new Grid(25,width,height);
  particleList = new ArrayList();
  particleList.add(new Particle(width/2,height/2,maxRad,minRad));
  currentParticle = (Particle)particleList.get(0);
  currentParticle.stuck = true;
  currentParticle.render();
  particleGrid.addParticle(currentParticle);
}

//-----------------Main Loop
void draw() {
  if (maxEnclosingRad < width/2) {
    while(!currentParticle.stuck) {
      currentParticle.diffuse(maxEnclosingRad);
      int[] centralBins = particleGrid.getBinNumbers(currentParticle.pos_x,currentParticle.pos_y);
      for(int i = -1; i < 2; i++) {
        for(int j = -1; j < 2; j++) {
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
    currentParticle.render();
    particleGrid.addParticle(currentParticle);
    //determine new maximum enclosing radius
    float currentDistance = dist(width/2,height/2,currentParticle.pos_x,currentParticle.pos_y) + currentParticle.rad;
    maxEnclosingRad = max(currentDistance,maxEnclosingRad);
    //create new particle
    float theta = random(0,TWO_PI);
    currentParticle = new Particle(floor(maxEnclosingRad*cos(theta)) + width/2, floor(maxEnclosingRad*sin(theta)) + height/2, maxRad, minRad);
    particleList.add(currentParticle);
  }
}

//-----------------Defined Functions

