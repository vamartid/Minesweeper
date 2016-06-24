#ifndef MINESWEEPER_H
#define MINESWEEPER_H

#include <iostream>
#include <string>
#include <stdlib.h>
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <string.h>

using namespace std;

class Minesweeper {
	private:
		int width;
		int height;
		int mineCounter;
		int ** mines;
	public:
		Minesweeper(int, int, int);
		~Minesweeper();
		void bombGenerator(int ,int);
		bool checkPlacement(int , int ,int ,int );
		void numberPlacement(int, int);
		void print();
		void print2(int, int);
};

#endif
