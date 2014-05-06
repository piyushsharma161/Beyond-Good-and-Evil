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

