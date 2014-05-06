import java.util.Random;
Random generator;
Word[] bgeList = new Word[1];
Word[] logList = new Word[1];
Word[] dqList = new Word[1];

int i;
int k;
int totalWordCount;
ArrayList<Cell> cells = new ArrayList<Cell>();
int spawnCount;

//titleScreen
int selection;
PFont fa, fb, fc, fd, fe, ff;
int ii;
int iiState;

//parent tracking
String maxParent;
int parentedMax;
int fontSize;

//printing
PrintWriter output;

int visualizationState;

//PGraphics test
PGraphics front;
PGraphics back;

// 3D Test
float angle;

void setup() 
{
  size(1366, 768, P3D);
  frameRate(24);
  generator = new Random();
  bgeList = parseWords("beyondGoodAndEvil.txt", bgeList); // max count = 3779, letterCount = 20
  logList = parseWords("leavesOfGrass.txt", logList); // max count = 10110, letterCount = 16
  dqList = parseWords("donQuixote.txt", dqList); 
  lights();
  
  i = 0;
  ii = 0;
  iiState = 0;
  spawnCount = 0;

  /*
  int max = 0;
   for (int i = 0; i < logList.length; i++) {
   if (logList[i].letterCount > max) {
   max = logList[i].letterCount;
   if (max == 16) println("word is " + logList[i].ww);
   } 
   }
   println(max);
   */

  fontSize = 32;

  //title screen
  fa = createFont("TrajanPro-Regular", 48, true);
  fb = createFont("LiSongPro", 48, true);
  fc = createFont("TrajanPro-Regular", fontSize, true);
  fd = createFont("LiSongPro", fontSize, true);
  fe = createFont("Papyrus", 48, true);
  ff = createFont("Papyrus", fontSize, true);

  //printing
  output = createWriter("lastRun.txt");

  visualizationState = 0;
  
  //PGraphicsTest
  front = createGraphics(width,height);
  back = createGraphics(width,height);
  
  vocabularyExhaustion(dqList, 3);
  vocabularyExhaustion(bgeList, 1);
  vocabularyExhaustion(logList, 2);

 

}

void draw()
{

  if (keyPressed) {
    if (key == 'q') {
      visualizationState = 0;
    }
    if (key == 'w') {
      visualizationState = 1;
    }
  }

  if (selection == 0) {
    textAlign(LEFT);

    if (keyPressed) {
      if (key == '1') {
        selection = 1;
      }
      if (key == '2') {
        selection = 2;
      }
      if (key == '3') {
        selection = 3;
      }
    }


    background(back);
    if (ii == 255 && iiState == 0) iiState = 1;
    if (ii == 0 && iiState == 1) iiState = 0;
    if (iiState == 0) ii++;
    if (iiState == 1) ii--;

 
    //image(back,0,0);
    
    front.beginDraw();
    front.background(0,0);
    front.textFont(fa);
    front.fill(0, 102, 153);
    front.text("beyond good and evil", width/5, (height/4));
    front.textFont(fe);
    front.fill(233, 94, 55);
    front.text("don quixote", width/5, (height/4)*2);
    front.textFont(fb);
    front.fill(33, 124, 15);
    front.text("leaves of grass", width/5, (height/4)*3);
    front.endDraw();
    image(front,0,0);  
  } 

  // Beyond Good And Evil is selected
  if (selection == 1) {
    runSelection(bgeList);
  }
  
  // Don Quixote is selected
  if (selection == 2) {
    runSelection(dqList);
  }
  
  // Leaves of Grass is selected
  if (selection == 3) {
    runSelection(logList);
  }
 
}

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

Word crossover(Cell a, Cell b) {
  Cell cell = a;
  Cell cell2 = b;
  ArrayList<Character> spawnConstructor = new ArrayList<Character>();
  String spawnWW = "";
  Word spawn;
  int coinflip;
  char x;
  char y;

  //output.println("mating: " + cell.word.ww + " and " + cell2.word.ww);
  for (int i = 0; i < cell.word.ww.length() && i < cell2.word.ww.length(); i++) {
    coinflip = (int)random(2);
    x = cell.word.ww.charAt(i);
    y = cell2.word.ww.charAt(i);
    if (isVowel(x) && isVowel(y)) {
      // both vowels
      if (coinflip == 1) {
        x = mutation(x);
        spawnConstructor.add(i, x);
      } else {
        y = mutation(y);
        spawnConstructor.add(i, y);
      }
    } else if (!isVowel(cell.word.ww.charAt(i)) && !isVowel(cell2.word.ww.charAt(i))) {
      // both consonants
      if (coinflip == 1) {
        x = mutation(x);
        spawnConstructor.add(i, x);
      } else {
        y = mutation(y);
        spawnConstructor.add(i, y);
      }
    } else {
      x = mutation(x);
      spawnConstructor.add(i, x);
    }
  }

  if (cell.word.ww.length() > cell2.word.ww.length()) {
    int leftToAdd = abs(cell.word.ww.length() - cell2.word.ww.length());
    for (int i = 1; i <= leftToAdd; i++) {
      char j = cell.word.ww.charAt(cell2.word.ww.length() - 1 + i);
      j = mutation(j);
      spawnConstructor.add(j);
    }
  }

  for (char s : spawnConstructor) {
    spawnWW += s;
  }

  spawn = new Word(spawnWW, spawnCount);
  spawn.letterCount = spawn.ww.length();
  spawnCount++;
  output.println(spawn.ww);

  return spawn;
}

void fitness(Cell a, Cell b) {

  Cell cell = a;
  Cell cell2 = b;
  Word cWord;
  int class1 = cell.word.wordClass;
  int class2 = cell2.word.wordClass;
  int life1 = cell.lifeRemaining;
  int life2 = cell2.lifeRemaining;
  int lifeDiff = abs(life1 - life2);
  float sexChance = (float) generator.nextGaussian();

  //fitness evaluation
  if ( (class1 == class2) && (lifeDiff < 25) ) {
    if (sexChance >= 0.45 && sexChance <= 0.55) {
      cell.word.parented++;
      cell2.word.parented++;
      cWord = crossover(cell, cell2);
      cells.add(new Cell(cWord, 25));
    } else {
      // if cells don't succeed in mating, then they lose vitality
      cell.lifeRemaining = cell.lifeRemaining - 2;
      cell2.lifeRemaining = cell2.lifeRemaining - 2;
    }
  } else if ( (abs(class1 - class2) == 1) && (lifeDiff < 50) ) {

    if (sexChance >= 0.47 && sexChance <= 0.53) {
      cell.word.parented++;
      cell2.word.parented++;
      cWord = crossover(cell, cell2); 
      cells.add(new Cell(cWord, 25));
    } else {
      // if cells don't succeed in mating, then they lose vitality
      cell.lifeRemaining = cell.lifeRemaining - 2;
      cell2.lifeRemaining = cell2.lifeRemaining - 2;
    }
  } else if ( (abs(class1 - class2) == 2) && (lifeDiff < 75) ) {

    if (sexChance >= 0.49 && sexChance <= 0.51) {
      cell.word.parented++;
      cell2.word.parented++;
      cWord = crossover(cell, cell2); 
      cells.add(new Cell(cWord, 25));
    } else {
      // if cells don't succeed in mating, then they lose vitality
      cell.lifeRemaining = cell.lifeRemaining - 2;
      cell2.lifeRemaining = cell2.lifeRemaining - 2;
    }
  }
}

boolean isVowel(char a) {

  char c = a;
  int v = (int) c;
  if (v == 97 || v == 101 || v == 105 || v == 111 || v == 117) {
    return true;
  } else {
    return false;
  }

  /* vowels:
   a = 97
   e = 101
   i = 105
   o = 111
   u = 117
   */
}

char mutation(char c) {

  float mutationRate = 0.005;
  char mutation = c;

  if (random(1) < mutationRate) {
    mutation = (char)((int)random(97, 123));
    output.println("MUTATION");
  }
  
  return mutation;
}

void overlapping(int i) {
  for (int j = 0; j < cells.size(); j++) {
    if (i == j) {
      j++;
    } else {
      Cell cell = cells.get(i);
      Cell cell2 = cells.get(j);
      float distance = sqrt(sq(cell.location.x - cell2.location.x) + sq(cell.location.y - cell2.location.y));
      if (distance <= (cell.radius + cell2.radius)) {

        fitness(cell, cell2);

        //change direction
        float num = (float) generator.nextGaussian();
        float num2 = (float) generator.nextGaussian();
        float num3 = (float) generator.nextGaussian();
        float num4 = (float) generator.nextGaussian();

        cell.targetX  = map(num,-1.5,1.5,0,width);
        cell.targetY = map(num2,-1.5,1.5,0,height);
        cell2.targetX = map(num3,-1.5,1.5,0,width);
        cell2.targetY = map(num4,-1.5,1.5,0,height);
      }
    }
  }
}

Word[] parseWords(String textFile, Word[] wordList) 
{
  k = 0;

  String[] lines = loadStrings(textFile);
  wordList[0] = new Word("", 0);
  boolean started = false;

  for (int i = 0; i < lines.length; i++) {

    String separators = WHITESPACE + ",;.:!?()\"-1234567890";
    String[] thisLine = splitTokens(lines[i], separators);

    for (int j = 0; j < thisLine.length; j++) {

      String word = thisLine[j].toLowerCase();

      boolean newWord = true;

      for (int w = 0; w < wordList.length; w++) {
        if (word.equals(wordList[w].ww)) {
          newWord = false;
          k++;
          wordList[w].count++;
          break;
        }
      }

      if (newWord == true) {
        Word next = new Word(word, k);
        k++;
        wordList = (Word[])append(wordList, next);
        wordList[wordList.length-1].letterCount = word.length();
      }
    }
  }
  
  return wordList;
}
void printGaussianWords(Word[] j, int x, int y) {
  float num = (float) generator.nextGaussian();
  float num2 = (float) generator.nextGaussian();

  float x2 = 80 * num + x; //sd * num * mean
  float y2 = 60 * num2 + y;   //sd * num * mean

  float z = (abs(x-x2) + abs(y-y2))/2;

  textSize(j[i].count);
  fill(34, random(255), random(255), (255-j[i].count));
  text(j[i].ww, x2, y2);
  i++;
}
void runSelection(Word[] wordlist) {
  
    // Set up some different colored lights
    pointLight(51, 102, 255, 65, 60, 100); 
    pointLight(200, 40, 60, -65, -60, -150);
  
    // Raise overall light in scene 
    ambientLight(70, 70, 10); 
  
    // Center geometry in display windwow.
    // you can changlee 3rd argument ('0')
    // to move block group closer(+) / further(-)
    //translate(width/2, height/2, -200 + mouseX * 0.65);
    translate(0,0,-200 + mouseX * 0.65);
  
    // Rotate around y and x axes
    rotateY(radians(mouseY));
    //rotateX(radians(mouseY));
    
  
    if (visualizationState == 0) {
      background(back);
      if (ii == 255 && iiState == 0) iiState = 1;
      if (ii == 0 && iiState == 1) iiState = 0;
      if (iiState == 0) ii++;
      if (iiState == 1) ii--;
    }


    textAlign(CENTER);

    //image(back,0,0);

    if (i < wordlist.length) {
      cells.add(new Cell(wordlist[i], 0));
    }

    if (cells.isEmpty()) {
      i = 0;
      selection = 0;
      output.println(maxParent + " spawned the most offspring.");
      output.flush();
      output.close();
    }

    for (int i = 0; i < cells.size(); i++) {
      Cell cell = cells.get(i);
      cell.update();
      overlapping(i);
      cell.display();
    }

    println(i);
    i++;
    
    //!
    angle += 0.2;
  
}
void vocabularyExhaustion(Word[] wordlist, int a) {
  
  float pos;
  
  back.beginDraw();
  
  if (a == 1)
  {
    for (int i = 0; i < wordlist.length; i++) 
    {
      pos = (float) wordlist[i].wordPosition;
      int count = wordlist[i].letterCount;
      back.point(pos % width, pos/width - ((pos % width)/width));
      if (i%2 == 0) back.fill(255, wordlist[i].letterCount*6);
      if (i%2 != 0) back.fill(0, wordlist[i].letterCount*6);
      back.noStroke();
      back.ellipse(pos % width, pos/width - ((pos % width)/width), wordlist[i].count, wordlist[i].count);
    }
  }
  
  if (a == 2)
  {
    for (int i = 0; i < wordlist.length; i++) 
    {
      pos = (float) wordlist[i].wordPosition;
      int count = wordlist[i].letterCount;
      back.point(pos % width, pos/width - ((pos % width)/width));
      if (i%2 == 0) back.fill(255, wordlist[i].letterCount*6);
      if (i%2 != 0) back.fill(0, wordlist[i].letterCount*6);
      back.noStroke();
      back.ellipse(width - (pos % width), height - (pos/width - ((pos % width)/width)), wordlist[i].count, wordlist[i].count);
    }
  }
  
  if (a == 3)
  {
    for (int i = 0; i < wordlist.length; i++) 
    {
      pos = (float) wordlist[i].wordPosition;
      int count = wordlist[i].letterCount;
      back.point(pos % width, pos/width - ((pos % width)/width));
      if (i%2 == 0) back.fill(255, wordlist[i].letterCount*6);
      if (i%2 != 0) back.fill(random(255), random(255), random(255), wordlist[i].letterCount*6);
      back.noStroke();
      back.ellipse(width - (pos % width), (height - (pos/width - ((pos % width)/width)))/2, wordlist[i].count, wordlist[i].count);
    }
  }
  
  back.endDraw();

}
class Word {

  String ww;
  int count = 1;
  int letterCount = 0;
  int wordPosition = 0;
  int wordClass;
  int parented;

  Word(String txt, int p) 
  {
    ww = txt;
    wordPosition = p;
    if (txt.length() >= 0 && txt.length() <= 5) {
      wordClass = 1;
    } else if (txt.length() >= 6 && txt.length() <= 10) {
      wordClass = 2; 
    } else {
      wordClass = 3;
    }
  }

}


