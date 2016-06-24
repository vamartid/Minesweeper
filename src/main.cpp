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
	/*
	int x = 0;
	if (argc == 2) {
		printf("%d\n", atoi(argv[1]));
		switch (x)
		{
		case 1: cout << "3";
			break;
		case 2: cout << "2";
			break;
		case 3: cout << "1";
			break;
		default: cout << "qwerty";
			break;
		}
		
	}*/
	
	Minesweeper *table = new Minesweeper(8,8,10);
	int fsX=5;
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

	if ( choose== 1) { //check if next character is newline
		table->rightClickAction(a,b); //and assign the default
	} else if (choose == 2) { //be sure to handle invalid input
		table->leftClickAction(a,b);
	}
	table -> print();






































	delete table;
	return 0;
}
