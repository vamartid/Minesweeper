#include "Minesweeper.h"

using namespace std;
/**
 * constructor of the cells
 * we set the width the height and the number of the cells
 * gives zero to all the values of the matrix
 */
Minesweeper::Minesweeper(int width, int height, int mineCounter) {
	this->width = width;
	this->height = height;
	this->mineCounter = mineCounter;
	//initializing the minefield array
	//cells = new Cell[width][height];
	cells.resize(height*width);
	/*for (int i = 0; i < width; i++) {
		cells[i] = new Cell[height];
		for (int j = 0; j < height; j += 1) {
			cells[i][j] = new Cell;
		}
	}*/
}

/**
 * destructor of the cells
 */
Minesweeper::~Minesweeper() {
	delete &cells;
}


Cell* Minesweeper::getCell(int x, int y){
	return  &cells[x * width + y];
}

/**
 * create the table place the bombs and the numbers to its neighbours
 * but dont give x1 and y1 bomb and nor its neighbours
 */
void Minesweeper::bombGenerator(int x1, int y1) {
	srand(time(NULL));
	for (int i = 0; i < mineCounter; i += 1) {
		bool checker = false;
		int x;
		int y;
		do {
			x = rand() % (height); //generate random x for the bomb
			y = rand() % (width); //generate random y for the bomb
			if (checkPlacement(x1, y1, x, y)) { //check if the random is not a neighbour of the selected
				if (getCell(x, y)->getBombNum() != 9) { //if its not a bomb
					getCell(x, y)->setBombNum(9); //make it bomb
					numberPlacement(x, y); //increase all neighbours by one
					checker = true; //declare that you made a bomb
				}
			}

		} while (!checker); //if we did not make a bomb we continue to the next random number
	} //we have the number of the bombs we like
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
			if ((x + i >= 0) && (x + i <= height - 1) && (y + j >= 0)
					&& (y + j <= width - 1)) {
				int bombNum = getCell(x + i, y + j)->getBombNum();
				if (bombNum != 9) {
					getCell(x + i, y + j)->setBombNum(bombNum + 1);
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
			if (getCell(i, j)->getBombNum() == 9) {
				cout << "*" << "\t";
			} else if (getCell(i, j)->getBombNum() == 0) {
				cout << ".." << "\t";
			} else {
				cout << getCell(i, j)->getBombNum() << "\t";
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
bool Minesweeper::checkPlacement(int x1, int y1, int x, int y) {
	for (int i = -1; i < 2; i += 1) {
		for (int j = -1; j < 2; j += 1) {
			if ((x + i >= 0) && (x + i <= height - 1) && (y + j >= 0)
					&& (y + j <= width - 1)) {
				if ((x + i == x1) && (y + j == y1)) {
					return false;
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
void Minesweeper::print2(int x, int y) {
	for (int i = 0; i < width; i += 1) {
		for (int j = 0; j < height; j += 1) {
			if ((x == i) && (y == j)) {
				cout << "..." << "\t";
			} else if (getCell(i, j)->getBombNum() == 9) {
				cout << "*" << "\t";
			} else if (getCell(i, j)->getBombNum() == 0) {
				cout << ".." << "\t";
			} else {
				cout << getCell(i, j)->getBombNum() << "\t";
			}
		}
		cout << endl << endl;
	}
}

/**
 *	checks if there are neighbours to be opened
 *	opens them
 */
void Minesweeper::openNeighboursRec(int x, int y) {
	for (int i = -1; i < 2; i += 1) {
		for (int j = -1; j < 2; j += 1) {
			if ((x + i >= 0) && (x + i <= height - 1) && (y + j >= 0)
					&& (y + j <= width - 1)) {
				if (!getCell(x + i, y + j)->isRevealed()) { //it is not open
					if (getCell(x + i, y + j)->getBombNum() != 9) {
						getCell(x + i, y + j)->setRevealed(true);
					}
					if (getCell(x + i, y + j)->getBombNum() == 0) {
						openNeighboursRec(x + i, y + j);
					}
				}
			}
		}
	}
}

/**
 * right Click action
 */
void Minesweeper::rightClickAction(int x, int y) {
	if (!getCell(x, y)->isRevealed()) { //if it is not open
		if (!getCell(x, y)->isFlagged()) { //if it is not flagged
			getCell(x, y)->setFlagged(true);
			cout << "flagged";
		} else { //it is flagged
			getCell(x, y)->setFlagged(false);
			getCell(x, y)->setQuestionMarked(true);
			cout << "add question mark";
		}
	}
}

/**
 * left Click action
 */
void Minesweeper::leftClickAction(int x, int y) {
	if (!getCell(x, y)->isRevealed()) { //if it is not open
		if (getCell(x, y)->getBombNum() == 9) { //it is bomb
			for (int i = 0; i < width; i++) { //open all cells
				for (int j = 0; j < height; j++) {
					getCell(i, j)->setRevealed(true);
				}
			}
		} else if (!getCell(x, y)->isFlagged()) { //it is flagged
			//you have to open the cell
			getCell(x, y)->setRevealed(true);			//open
			if (getCell(x, y)->getBombNum() == 0) {			//if its empty
				openNeighboursRec(x, y);			//check and open neighbours
			}
		} else {
			cout << "dont know what this is" << endl;
		}
	} else {
		cout << "i can not click this" << endl;
	}
}
