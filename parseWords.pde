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
