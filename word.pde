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

