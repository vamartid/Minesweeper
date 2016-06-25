#ifndef MINESWEEPER_H
#define MINESWEEPER_H

#include <iostream>
#include <string>
#include <stdlib.h>
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <vector>
#include <math.h>
#include <string.h>
#include "Cell.h"

using namespace std;

class Minesweeper {
private:
	int width;
	int height;
	int mineCounter;
	//Cell ** cells;
	std::vector<Cell> cells;
public:
	Minesweeper(int, int, int);
	~Minesweeper();
	void bombGenerator(int, int);
	bool checkPlacement(int, int, int, int);
	void numberPlacement(int, int);
	Cell * getCell(int, int);

	void openNeighboursRec(int, int);

	void rightClickAction(int, int);
	void leftClickAction(int, int);

	void print();
	void print2(int, int);
};

#endif
