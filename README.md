# Perceptron-Visualization
This project lets you visualize what a perceptron does. It is interactive and provides examples.




#### Language: 
Swift


#### Files
1. Xcode 6 Project: Perceptron/Perceptron.xcodeproj
2. Source Code: Perceptron/Perceptron/


#### CLI Version: 
Perceptron/Perceptron/perceptronCLI.swift



[exm]: https:github.com/vincenzorm117/Perceptron-Visualization/Perceptron/Previews/workingExample.png
[and]: https:github.com/vincenzorm117/Perceptron-Visualization/Perceptron/Previews/andExample.png
[xor]: https:github.com/vincenzorm117/Perceptron-Visualization/Perceptron/Previews/xorExample.png

### How to use the GUI
- The examples drop down menu on the right contians some prebuilt examples. Selecting one will load the points on to the graph.
- The slider controls how fast the perceptrons take steps in learning. The slider can go from 0 to 1.
- The box containing text field accepts numbers only. Recommend numbers 100-10,000.
- The **Learn** button, if there is input, will invoke the perceptron to learn a boundary or hyperplane that will separate the data. Note it does not draw the boundary though, for that use the **Update Graph** button.
- The **Update Graph** button gives you 10 instances of the perceptrons weights as it was learning. Every time you click it, the graph is updated with the next set of weights that the perceptron discovered over the iterations it spent learning. If the perceptron learns the weights on a step before the last then updating the graph won't do anything.
- The numbers below show the total number of points. The number of incorrectly labeled points and the percentage of error.
- The **Clear** button clears the graph.


Previews
-------

Here is an exmple of a set of points set by the user with the hyperplane separating them.
![Interactive Example picture missing][exm]
Here is an example of the and function mapped in the space (although it has been shifted).
![And Example picture missing][and]
Here is an example of the limitations of a perceptron. The xor is like the and mapped in the space but shifted.
![Xor Example picture missing][xor]


Current Issues
-------
1. Examples are too small or close together
2. Points cannot be moved
3. Number field crashes when non-numeric characters are entered
4. Number field formats numbers 1000 or greater with comma
5. Window cannot be resized




