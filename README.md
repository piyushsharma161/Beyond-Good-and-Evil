# Beyond Good and Evil

A dynamic visualization of a genetic algorithm applied to a collection of unique words extracted from novel length texts. The texts are Beyond Good and Evil by Friedrich Nietzsche, Leaves of Grass by Walt Whitman, and Don Quixote by Cervantes. The genetic algorithm is applied without a goal or target state. Fitness for mating word pairs is determined by how similar the words are to each other, and whether or not this fitness test takes place is determined by the movement of associated, invisible cell objects within a simple 2D physics system. The associated words are displayed as moving rather than the cells. New words that are spawned immediately create new cell objects.

The words from the two texts are first brought into the program and parsed into arrays. The array
only stores the first instance of any given word, and then increments it’s associated count variable when it encounters it again. It does, however, keep track of each words absolute index. The graphics of my title screen take advantage of this by drawing circles at the given index (with each index being a pixel, from left to right), and drawing a circle whose radius is based on the number of occurences of the word, and whose opacity is based on the length. My initial idea was for this to be a visual representation of when the authors begin to exhaust their vocabulary in the text, assuming that they would use fewer new words as the book went along, but it turned out to not be the case with Nietzsche & Whitman. It was recommended that I try Gertrude Stein’s A Rose Is A Rose Is A Rose, but I could not find the text file. Once parsed into arrays, each word object is then associated with a cell object that moves through the 2D physics system. Cell speed is tied to word length.

Overlapping cells change their trajectory, but their new trajectory is based on a gaussian distribution, so a frequent number of interactions causes an overall tendency of all cell objects to move towards the center (deviant trajectories are “corrected” quickly). Overlapping cells also initiate the fitness function, which is based on the “class” of associated words. Short words are low class, medium length words are middle class, and any word over ten characters is upper class. Cells tied to low class words move the fastest but have the shortest life span. Upper class words move the slowest but live longer. The fitness of a word pair for reproduction is based on the difference in age, as well as the difference in class. Words that share class are more likely to mate with each other. If mating is successful, there is an 0.5% chance of mutation. Spawned words are immediately tied to a new cell, which is then fed into the particle system. The process of reproduction itself, or “crossover”, treats the string of the associated word as DNA. If the characters at a given index are both consonants or both vowels, then each has a 50% chance of being passed on, otherwise the algorithm uses the DNA of the first cell read by the for loop, which is also based on chance. If word lengths do not match, then there’s
a 50/50 chance of the trailing letters being tacked on to the DNA of the spawned word.

## Notes
* This project was originally developed in Processing. As I'm currently working mostly in JavaScript, I foresee wanting to port the project to P5. I'll likely be wanting to rewrite all of the code, having recently learned more about software development.
