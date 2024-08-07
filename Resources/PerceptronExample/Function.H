/* Function.H
 *
 * A function is a mapping from inputs to a boolean output. We read
 * this is from a file. Note the weird syntax "int (*function)(int input[])"
 * refers to a pointer to a C++ function that takes an array of inputs
 * and returns a boolean. This function pointer is called "function"
 * and can be executed by calling "int x = (*function)(inputs);".
 */

/*
 * Copyright 1994, Brown University, Providence, RI
 * See end of file for full copyright information
 */

class Function {
   int num_inputs;                 // The number of inputs this function takes
   int (* function)(int input[]);   // An actual C++ function

public:
   Function(int _num_inputs, int (* _function)(int input[]));  // constructor
   ~Function();                    // Destroy the function
   int execute(int *input);        // Execute the function, returning a boolean
   int get_num_inputs();           // Get the number of inputs for the function
};

/*
 * Copyright 1994, Brown University, Providence, RI
 *
 * Permission to use and modify this software and its documentation for
 * any purpose other than its incorporation into a commercial product is
 * hereby granted without fee.  Permission to copy and distribute this
 * software and its documentation only for non-commercial use is also
 * granted without fee, provided, however, that the above copyright notice
 * appear in all copies, that both that copyright notice and this permission
 * notice appear in supporting documentation, that the name of Brown
 * University not be used in advertising or publicity pertaining to
 * distribution of the software without specific, written prior permission,
 * and that the person doing the distribution notify Brown University of
 * such distributions outside of his or her organization. Brown University
 * makes no representations about the suitability of this software for
 * any purpose.  It is provided "as is" without express or implied warranty.
 * Brown University requests notification of any modifications to this
 * software or its documentation.
 *
 * Send the following redistribution information:
 *
 *	Name:
 *	Organization:
 *	Address (postal and/or electronic):
 *
 * To:
 *	Software Librarian
 *	Computer Science Department, Box 1910
 *	Brown University
 *	Providence, RI 02912
 *
 *		or
 *
 *	brusd@cs.brown.edu
 *
 * We will acknowledge all electronic notifications.
 */

