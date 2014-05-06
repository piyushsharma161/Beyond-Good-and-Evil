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

