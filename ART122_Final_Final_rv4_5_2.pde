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

