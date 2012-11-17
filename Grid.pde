class Grid {
  float binSize;
  int noBinsX;
  int noBinsY;
  ArrayList<Particle>[][] particleBuckets;
  
  Grid(float _binSize, int windowWidth, int windowHeight) {
    binSize = _binSize;
    noBinsX = ceil(windowWidth / _binSize);
    noBinsY = ceil(windowHeight / _binSize);
    particleBuckets = new ArrayList[noBinsX][noBinsY];
    for(int i = 0; i < noBinsX; i++) {
      for(int j = 0; j < noBinsY; j++) {
        particleBuckets[i][j] = new ArrayList<Particle>();
      }
    }
  }
 
 ArrayList<Particle> getParticles(int binX, int binY) {
  ArrayList<Particle> particlesInBin = particleBuckets[clamp(binX, 0, noBinsX - 1)][clamp(binY, 0, noBinsY - 1)];
  return particlesInBin;
 }
 int[] getBinNumbers(float pos_x, float pos_y) {
   //given a particle's position, return the bin number that it is currently in.
   int indexX = floor(pos_x / binSize);
   int indexY = floor(pos_y / binSize);
   int[] binNumbers = {indexX,indexY};
   return binNumbers;
 }
 
 void addParticle(Particle particle) {
   //Add a new particle to the grid.
   int indexX = floor(particle.pos_x / binSize);
   int indexY = floor(particle.pos_y / binSize);
   particleBuckets[clamp(indexX, 0, noBinsX - 1)][clamp(indexY, 0, noBinsY - 1)].add(particle);
 }
  
}

int clamp(int value, int minVal, int maxVal) {
  return max(minVal, min(value,maxVal));
}
