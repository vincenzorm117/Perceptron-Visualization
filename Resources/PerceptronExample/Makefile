# Copyright 1994, Brown University, Providence, RI
#
# See end of file for full copyright information
# This is a makefile for compiling C++ programs, although a quick change
# of a few lines will turn it into a makefile for compiling C programs.

# flags to pass to the C compiler such as the "-g" debugging flag
# CFLAGS = -g -DDEBUG
CFLAGS = -g

# Choose the appropriate C compiler. Use gcc for C code, g++ for C++.
# CC = g++
CC = CC

# The object files that we want to compile to build the program.
OBJS = Perceptron.o Function.o

# The name of the program I want to make
PROG = perceptron

all : $(PROG)

# Make this ".c.o" instead of ".C.o" for C programming.
.C.o:
	$(CC) $(CFLAGS) -c $<

# Create the executables from the object files
$(PROG) : $(OBJS)
	$(CC) -o $(PROG) $(OBJS)

clean :
	rm -f $(OBJS) $(PROG)

#
# Copyright 1994, Brown University, Providence, RI
#
# Permission to use and modify this software and its documentation for
# any purpose other than its incorporation into a commercial product is
# hereby granted without fee.  Permission to copy and distribute this
# software and its documentation only for non-commercial use is also
# granted without fee, provided, however, that the above copyright notice
# appear in all copies, that both that copyright notice and this permission
# notice appear in supporting documentation, that the name of Brown
# University not be used in advertising or publicity pertaining to
# distribution of the software without specific, written prior permission,
# and that the person doing the distribution notify Brown University of
# such distributions outside of his or her organization. Brown University
# makes no representations about the suitability of this software for
# any purpose.  It is provided "as is" without express or implied warranty.
# Brown University requests notification of any modifications to this
# software or its documentation.
#
# Send the following redistribution information:
#
#	Name:
#	Organization:
#	Address (postal and/or electronic):
#
# To:
#	Software Librarian
#	Computer Science Department, Box 1910
#	Brown University
#	Providence, RI 02912
#
#		or
#
#	brusd@cs.brown.edu
#
# We will acknowledge all electronic notifications.
