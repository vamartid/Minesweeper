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
#include "Sound/soundmanager.h"

using namespace std;

class Minesweeper : public QObject {
    Q_OBJECT
private:
	int width;
	int height;
	int mineCounter;
    int remFlags;
    int winCounter = 0;
    bool gameLost = false;
	std::vector<Cell> cells;
    void openNeighboursRec(int, int);
    bool checkPlacement(int, int, int, int);
    void numberPlacement(int, int);
    void openAllCells();

    SoundManager *musicMngr;
    SoundManager *soundMngr;

public:
    explicit Minesweeper(QObject *parent = 0);
	~Minesweeper();
    Cell * getCell(int, int);
	void print();
    void print2(int, int);
    //SoundManager getSound();
    //SoundManager getMusic();
public slots:
    void initField(int, int, int);
    void leftClickAction(int, int);
    void doubleClickAction(int, int);
    void rightClickAction(int, int);
    void bombGenerator(int, int);
    int getBombNum(int, int);
    int getRemFlags();
    bool getisFlagged(int, int);
    bool getisQuestionMarked(int, int);
    bool getisRevealed(int, int); 
    bool isGameWon();
    bool isGameLost();
//    Cell returnCell(int, int);
};

#endif
