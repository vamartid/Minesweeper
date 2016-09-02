#ifndef CELL_H
#define CELL_H

using namespace std;

class Cell {
private:
	int bombNum;
    bool revealed, flagged;
public:
    Cell();
	~Cell();
    bool isRevealed();
    bool isFlagged();
    int getBombNum();
	void setRevealed(bool);
	void setFlagged(bool);
    void setBombNum(int);
};

#endif
