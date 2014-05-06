char mutation(char c) {

  float mutationRate = 0.005;
  char mutation = c;

  if (random(1) < mutationRate) {
    mutation = (char)((int)random(97, 123));
    output.println("MUTATION");
  }
  
  return mutation;
}

