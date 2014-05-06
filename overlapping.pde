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

