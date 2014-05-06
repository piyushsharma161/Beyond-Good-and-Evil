class Cell {
  Word word;
  int lifeRemaining;
  int lifeStart;
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  float radius = 8;
  float opacity = 255;
  float num = (float) generator.nextGaussian();
  float num2 = (float) generator.nextGaussian();
  float num3 = (float) generator.nextGaussian();
  float targetX  = map(num, -3, 3, 0, width);
  float targetY = map(num2, -3, 3, 0, height);
  float targetZ = map(num3, -3, 3, 0, -height);
  



  Cell(Word w, int m) {
    word = w;
    location = new PVector(random(width), random(height), random(-200, -100));
    velocity = new PVector(0, 0, 0);
    topspeed = 20 - word.ww.length();
    if (word.wordClass == 1) lifeStart = 50*2;
    if (word.wordClass == 2) lifeStart = 75*2;
    if (word.wordClass == 3) lifeStart = 100*2;
    lifeRemaining = lifeStart + m;
  }

  void update() {

    PVector target = new PVector(targetX, targetY, targetZ);
    PVector direction = PVector.sub(target, location);

    direction.normalize();
    direction.mult(0.5);
    acceleration = direction;

    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
    
  }

  void display() {
    
    if (lifeRemaining >= 0) 
    {
      if (selection == 1) textFont(fc);
      if (selection == 2) textFont(fd);
      if (word.wordClass == 1 && lifeRemaining > 50) fill(6, 206, 14);
      if (word.wordClass == 2 && lifeRemaining > 75) fill(6, 188, 206);
      if (word.wordClass == 3 && lifeRemaining > 100) fill(255, 215, 0);
      textSize(fontSize + word.parented*5);
      text(word.ww, location.x, location.y, location.z);
    } else 
    {
      if (word.parented > parentedMax) {
        parentedMax = word.parented;
        maxParent = word.ww;
      }
      cells.remove(this);
      //output.println("died: " + word.ww);
    }
    lifeRemaining--;
  }

  void borders() {
    if (location.x > width || location.x < 0) {
      location.x = width;
    }

    if (location.y > height || location.y < 0) {
      location.y = height;
    }
  }
}

