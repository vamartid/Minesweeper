#include "Minesweeper.h"
/**
 * constructor of the mines
 * we set the width the height and the number of the mines
 * gives zero to all the values of the matrix
 */
Minesweeper::Minesweeper(int width, int height, int mineCounter) {
	this -> width = width;
	this -> height = height;
	this -> mineCounter = mineCounter;
	mines = new int* [width];
	for (int i = 0; i < width; i++) {
		mines[i] = new int [height];
		for (int j = 0; j < height; j += 1) {
			mines[i][j] = 0;
		}
	}
}

/**
 * destructor of the mines
 */
Minesweeper::~Minesweeper() {
	delete mines;
}

/**
 * create the table place the bombs and the numbers to it's neighbours
 * but dont give x1 and y1 bomb and nor it's neighbours
 */
void Minesweeper::bombGenerator(int x1,int y1) {
	srand(time(NULL));
	for (int i = 0; i < mineCounter; i += 1) {
		int checker = 0;
		int x;
		int y;
		do {
			x = rand()%(height);//generate random x for the bomb
			y = rand()%(width);//generate random y for the bomb
			if (checkPlacement(x1,y1,x,y)) {//check if the random is not a neighbour of the selected
				if (mines[x][y] != -1) {//if its not a bomb
					mines[x][y] = -1;//make it bomb
					numberPlacement(x, y);//increase all neighbours for one
					checker = 1;//declare that you made a bomb
				}
			}

		} while (checker == 0);//if we did not make a bomb we continue to the next random number
	}//we have the number of the bombs we like
}

/**
 * numberPlacement
 * increases all the neighbours of the [x][y] cell for 1
 * we call it every time we place a bomb
 * this way we keep updated the values of  the neighbours
 * on how many bombs are around them
 */
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

/**
 * print the matrix whitch has the values which declares bombs,neighbours etc.
 */
void Minesweeper::print() {
	for (int i = 0; i < width; i += 1) {
		for (int j = 0; j < height; j += 1) {
			if ( mines[i][j]==-1 ){
				cout << "*" << "\t";
			}else if ( mines[i][j]==0 ){
				cout << ".." << "\t";
			}else{
				cout << mines[i][j] << "\t";
			}
		}
		cout << endl << endl;
	}
}

/**
 *  checks if [x][y] is a neigbour of the [x1][y1] cell
 *  returns false if it is
 *  and returns true if it is not
 */
bool Minesweeper::checkPlacement(int x1, int y1,int x,int y) {
	for (int i = -1; i < 2; i += 1) {
		for (int j = -1; j < 2; j += 1) {
			// check if cells between borders
			if ((x+i >= 0)&&(x+i <= height-1) && (y+j >= 0)&&(y+j <= width-1)) {
				if ((x+i == x1) && (y+j == y1)) { // check if starting cell
					for (int ii = -1; ii < 2; ii += 1) {
						for (int jj = -1; jj < 2; jj += 1) {
							// starting cell must be 0, so check cells arround it
							if ((x+i == x1+ii) && (y+j == y1+jj)) {
								return false;
							}
						}
					}
				}
			}
		}
	}
	return true;
}

/**
 * print the matrix whitch has the values which declares bombs,neighbours etc.
 * but print the first selected with a <>
 */
void Minesweeper::print2(int x,int y) {
	for (int i = 0; i < width; i += 1) {
		for (int j = 0; j < height; j += 1) {
			if ((x==i)&&(y==j)) {
				cout << "..." << "\t";
			}else if ( mines[i][j]==-1 ){
				cout << "*" << "\t";
			}else if ( mines[i][j]==0 ){
				cout << ".." << "\t";
			}else{
				cout << mines[i][j] << "\t";
			}
		}
		cout << endl << endl;
	}
}
