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
