#include <iostream>
#include <string>
#include <stdlib.h>
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <string.h>
#include "Minesweeper.h"

using namespace std;

int main (int argc, char const* argv[]) {
	int chooseDifficulty = 0;
	int stX, stY, stB;
	switch (chooseDifficulty) {
	case 0: 
		stX = 8;
		stY = 8;
		stB = 10;
		break;
	case 1:
		stX = 16;
		stY = 16;
		stB = 40;
		break;
	case 2:
		stX = 30;
		stY = 16;
		stB = 99;
		break;
	default:
		do {
			cout << "give height" <<endl;
			cin >> stX;
		} while (stX < 4);
		do {
			cout << "give width" <<endl;
			cin >> stY;
		} while (stY < 4);
		do {
			cout << "give bombs" <<endl;
			cin >> stB;
		} while (stB >= stX*stY-9);
		break;
	}
	Minesweeper *table = new Minesweeper(stX,stY,stB);
	int fsX=2;
	int fsY=2;
	table -> bombGenerator(fsX,fsY);
	table -> print2(fsX,fsY);
	cout << "give x" <<endl;
	int a;
	cin >> a;
	cout << "give y" <<endl;
	int b;
	cin >> b;
	cout << "choose" <<endl;
	int choose;
	cin >> choose;
	if ( choose== 1) { //check if next character is newline
		table->rightClickAction(a,b); //and assign the default
	} else if (choose == 2) { //be sure to handle invalid input
		table->leftClickAction(a,b);
	}
	table -> print();

	cout << "give x" <<endl;
	cin >> a;
	cout << "give y" <<endl;
	cin >> b;
	cout << "choose" <<endl;
	cin >> choose;
	if ( choose== 1) { //check if next character is newline
		table->rightClickAction(a,b); //and assign the default
	} else if (choose == 2) { //be sure to handle invalid input
		table->leftClickAction(a,b);
	}
	table -> print();

	delete table;
	return 0;
}
