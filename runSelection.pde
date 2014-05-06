void runSelection(Word[] wordlist) {
  
    // Set up some different colored lights
    pointLight(51, 102, 255, 65, 60, 100); 
    pointLight(200, 40, 60, -65, -60, -150);
  
    // Raise overall light in scene 
    ambientLight(70, 70, 10); 
  
    // Center geometry in display windwow.
    // you can changlee 3rd argument ('0')
    // to move block group closer(+) / further(-)
    //translate(width/2, height/2, -200 + mouseX * 0.65);
    translate(0,0,-200 + mouseX * 0.65);
  
    // Rotate around y and x axes
    rotateY(radians(mouseY));
    //rotateX(radians(mouseY));
    
  
    if (visualizationState == 0) {
      background(back);
      if (ii == 255 && iiState == 0) iiState = 1;
      if (ii == 0 && iiState == 1) iiState = 0;
      if (iiState == 0) ii++;
      if (iiState == 1) ii--;
    }


    textAlign(CENTER);

    //image(back,0,0);

    if (i < wordlist.length) {
      cells.add(new Cell(wordlist[i], 0));
    }

    if (cells.isEmpty()) {
      i = 0;
      selection = 0;
      output.println(maxParent + " spawned the most offspring.");
      output.flush();
      output.close();
    }

    for (int i = 0; i < cells.size(); i++) {
      Cell cell = cells.get(i);
      cell.update();
      overlapping(i);
      cell.display();
    }

    println(i);
    i++;
    
    //!
    angle += 0.2;
  
}
