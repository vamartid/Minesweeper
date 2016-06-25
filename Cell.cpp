#include "Cell.h"
/**
* Constructor for square class
* marks revealed, flagged, questionMarked as false
*/
Cell::Cell(){
	bombNum = 0;
	revealed = false;
	flagged = false;
	questionMarked = false;
}

bool Cell::isRevealed(){
	return revealed;
}

bool Cell::isFlagged(){
	return flagged;
}

bool Cell::isQuestionMarked(){
	return questionMarked;
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

void Cell::setQuestionMarked(bool questionMarked){
	this->questionMarked = questionMarked;
}

void Cell::setBombNum(int bombNum){
	this->bombNum = bombNum;
}

Cell::~Cell(){
	//default destructor
}