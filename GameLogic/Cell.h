#ifndef CELL_H
#define CELL_H

using namespace std;

class Cell {
private:
	int bombNum;
	bool revealed, flagged, questionMarked;
public:
    Cell();
	~Cell();
    bool isRevealed();
    bool isFlagged();
    bool isQuestionMarked();
    int getBombNum();
	void setRevealed(bool);
	void setFlagged(bool);
	void setQuestionMarked(bool);
    void setBombNum(int);
};

#endif
