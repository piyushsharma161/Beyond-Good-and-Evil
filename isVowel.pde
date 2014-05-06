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

