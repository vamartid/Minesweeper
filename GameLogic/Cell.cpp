#include "Cell.h"
/**
* Constructor for square class
* marks revealed, flagged as false
*/
Cell::Cell(){
	bombNum = 0;
    revealed = false;
	flagged = false;
}

bool Cell::isRevealed(){
	return revealed;
}

bool Cell::isFlagged(){
	return flagged;
}

int Cell::getBombNum(){
	return bombNum;
}

void Cell::setRevealed(bool revealed){
	this->revealed = revealed;
}

void Cell::setFlagged(bool flagged){
	this->flagged = flagged;
}

void Cell::setBombNum(int bombNum){
	this->bombNum = bombNum;
}

Cell::~Cell(){
	//default destructor
}
