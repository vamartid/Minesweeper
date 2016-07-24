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
#include <QObject>

using namespace std;

class Minesweeper : public QObject {
    Q_OBJECT
private:
	int width;
	int height;
	int mineCounter;
	//Cell ** cells;
	std::vector<Cell> cells;
public:
    explicit Minesweeper(QObject *parent = 0);
    //Minesweeper(int, int, int);
	~Minesweeper();
//    void bombGenerator(int, int);
	bool checkPlacement(int, int, int, int);
	void numberPlacement(int, int);
    Cell * getCell(int, int);
	void openNeighboursRec(int, int);
    void rightClickAction(int, int);
    //, int);

	void print();
    void print2(int, int);
public slots:


    void initField(int, int, int);
    void leftClickAction(int, int);
    void doubleClickAction(int, int);

    void bombGenerator(int, int);
    int getBombNum(int, int);
    bool getisFlagged(int, int);
    bool getisQuestionMarked(int, int);
    bool getisRevealed(int, int);
//    Cell returnCell(int, int);
};

#endif
