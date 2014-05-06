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
