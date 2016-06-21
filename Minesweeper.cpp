#include "Minesweeper.h"

Minesweeper::Minesweeper(int width, int height, int mineCounter) {
    srand(time(NULL));
	this -> width = width;
	this -> height = height;
	this -> mineCounter = mineCounter;
	mines = new int* [width];
	for (int i = 0; i < width; i++) {
		mines[i] = new int [height];
	}
	
}

Minesweeper::~Minesweeper() {
	delete mines;
}

void Minesweeper::bombGenerator() {
	for (int i = 0; i < mineCounter; i += 1) {
		int checker = 0;
		int x;
		int y;
		do {
			x = rand()%(height);
			y = rand()%(width);
			if (mines[x][y] != -1) {
				mines[x][y] = -1;
				numberPlacement(x, y);
				checker = 1;
			}
		} while (checker == 0);
	}
}

void Minesweeper::numberPlacement(int x, int y) {
	for (int i = -1; i < 2; i += 1) {
		for (int j = -1; j < 2; j += 1) {
			if ((x+i >= 0)&&(x+i <= height-1) && (y+j >= 0)&&(y+j <= width-1)) {
				if ((mines[x+i][y+j] != -1)) {
					mines[x+i][y+j]++;
				}
			}
		}
	}
}

void Minesweeper::print() {
	for (int i = 0; i < width; i += 1) {
		for (int j = 0; j < height; j += 1) {
			cout << mines[i][j] << "\t";
		}
		cout << endl << endl;
	}
}



















