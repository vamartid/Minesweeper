#include "GameLogic/Minesweeper.h"

using namespace std;

/**
 * constructor of the cells
 * we set the width the height and the number of the cells
 * gives zero to all the values of the matrix
 */


Minesweeper::Minesweeper(QObject *parent): QObject(parent){
    /*musicMngr = new SoundManager();
    musicMngr->initFields(50,true,QUrl("qrc:/Sounds/Rob Hubbard - Nemesis The Warlock (Maf464 remix).mp3"));
    musicMngr->playSound();

    soundMngr = new SoundManager();
    soundMngr->initFields(50,false,QUrl("qrc:/Sound/crash_padle.wav"));*/
}

void Minesweeper::initField(int width, int height, int mineCounter) {
        this->width = width;
        this->height = height;
        this->mineCounter = mineCounter;
        remFlags = mineCounter;
        winCounter = 0;
        gameLost = false;
        //resizing the minefield array
        cells.resize(height * width);
        moves = 0;
        for(int i = 0; i < height*width; i++){
            cells[i].setRevealed(false);
            cells[i].setFlagged(false);
            cells[i].setBombNum(0);
        }
}

/**
 * destructor of the cells
 */
Minesweeper::~Minesweeper() {
    delete &cells;
}

Cell* Minesweeper::getCell(int x, int y) {
    return &cells[x * width + y];
}

/**
 * create the table place the bombs and the numbers to its neighbours
 * but dont give x1 and y1 bomb and nor its neighbours
 */
void Minesweeper::bombGenerator(int x1, int y1) {
    if((this->height==50)&(this->width==50)&(this->mineCounter==999)){
        readAsciiDbt();
    }else{
        srand(time(NULL));
        //moves++;
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
    if (abs(x1 - x) <= 1 && abs(y1 - y) <= 1) {
        return false;
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
                if (!getCell(x + i, y + j)->isRevealed() && !getCell(x + i, y + j)->isFlagged()) { //it is not open
                    if (getCell(x + i, y + j)->getBombNum() != 9) {
                        getCell(x + i, y + j)->setRevealed(true);
                        winCounter++;
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
        if(!getCell(x, y)->isFlagged()){//if it is not flagged
            if (remFlags != 0) { //if there are flags left
                getCell(x, y)->setFlagged(true);
                remFlags -= 1;
                moves++;
            }
        } else {//it is flagged
            getCell(x, y)->setFlagged(false);
            remFlags += 1;
        }
    }
}

/**
 * left Click action
 */

void Minesweeper::leftClickAction(int x, int y) {
    if (!getCell(x, y)->isRevealed()) { //if it is not open
        if (!getCell(x, y)->isFlagged()) { //it is flagged
            if (getCell(x, y)->getBombNum() == 9) { //it is bomb
                gameLost = true;
                openAllCells();
            } else if (getCell(x, y)->getBombNum() == 0) { //if its empty
                moves++;
                openNeighboursRec(x, y); //check and open neighbours
            } else {
                moves++;
                getCell(x, y)->setRevealed(true);
                winCounter++;
            }
        }
    }
}


/**
 * double Click action
 */
void Minesweeper::doubleClickAction(int x, int y) {
    if (getCell(x, y)->isRevealed()) { //if it is open
        int rightFlaggedBombs = 0;
        int wrongFlaggedBombs = 0;
        for (int i = -1; i < 2; i += 1) {
            for (int j = -1; j < 2; j += 1) {
                if ((x + i >= 0) && (x + i <= height - 1) && (y + j >= 0)
                        && (y + j <= width - 1)){
                    if (getCell(x + i, y + j)->isFlagged()) { //it is flagged
                        if (getCell(x + i, y + j)->getBombNum() != 9) { //it is not bomb
                            wrongFlaggedBombs++;
                        } else { //it is bomb
                            //flagged and bomb
                            rightFlaggedBombs++; //count how many
                        }
                    }
                }
            }
        }
        if (rightFlaggedBombs == getCell(x, y)->getBombNum() && wrongFlaggedBombs == 0) {
            //if the cell value is equal to the number of the flagged bombs
            bool moveFlag = false;
            for (int i = -1; i < 2; i += 1) {
                for (int j = -1; j < 2; j += 1) {
                    if ((x + i >= 0) && (x + i <= height - 1) && (y + j >= 0)
                            && (y + j <= width - 1)){
                        if (getCell(x + i, y + j)->getBombNum() != 9 && !getCell(x + i, y + j)->isFlagged() && !getCell(x + i, y + j)->isRevealed()) { //it is not a bomb
                            moveFlag = true;
                            if (getCell(x + i, y + j)->getBombNum() != 0){
                                getCell(x + i, y + j)->setRevealed(true);
                                winCounter++;
                            } else {
                                openNeighboursRec(x + i, y + j);
                            }
                        }
                    }
                }
            }
            if(moveFlag){
                moves++;
            }
        //else he have a wrong placed flag among all the rights one so do nothing
        } else if(rightFlaggedBombs + wrongFlaggedBombs == getCell(x,y)->getBombNum()) { //if he didn't marked all the bombs
            gameLost = true;
            openAllCells();
        }
    }
}

int Minesweeper::getBombNum(int x, int y){
    return getCell(x,y)->getBombNum();
}
int Minesweeper::getRemFlags(){
    return remFlags;
}
bool Minesweeper::getisFlagged(int x, int y){
    return getCell(x,y)->isFlagged();
}
bool Minesweeper::getisRevealed(int x, int y){
    return getCell(x,y)->isRevealed();
}
int Minesweeper::getMoves(){
    return moves;
}

//checks if game is won
bool Minesweeper::isGameWon(){
    if (winCounter == height*width - mineCounter){
        return true;
    }
    return false;
}
//checks if game is lost
bool Minesweeper::isGameLost(){
    return gameLost;
}

//opens all cells
void Minesweeper::openAllCells(){
    for (int i = 0; i < height; i++) { //open all cells
        for (int j = 0; j < width; j++) {
            getCell(i, j)->setRevealed(true);
        }
    }
}

void Minesweeper::readAsciiDbt(){
    const char *dickbutt[50]={"                                                  ",
                        "                                                  ",
                        "                                                  ",
                        "                  jEt.                            ",
                        "                ##W t###K                         ",
                        "              ##        ##                        ",
                        "             ##          #                        ",
                        "            #L            #                       ",
                        "           ##             #                       ",
                        "          ####      .##   .D                      ",
                        "         #### #    ####;t .#                      ",
                        "         #### ##  ####  # ##                      ",
                        "         ##  ##   ###D  # ,#                      ",
                        "         #:i:#  #  # .##  G#                      ",
                        "         #   #WE#   ,     #                       ",
                        "         #         E####  #;                      ",
                        "        ;#########K       #             #G#:      ",
                        "        #j                #:           #.  #      ",
                        "        #W                #j           #   f.     ",
                        "        K#                ##          ##   #j     ",
                        "        ##             j  .#          #    #      ",
                        "        #K           ;K#:  #         ;#    #      ",
                        "        #f           tD#i  #      t  #   # W      ",
                        "        j#            t#:  #Lf##Gf,##:    #       ",
                        "         #           .j,K  ##E     i#    #:##     ",
                        "         #             #L   #  G#####   G## ##    ",
                        "         #           tj#D   #  ##    ###  # ###   ",
                        "          #           E#j     #         #  ###    ",
                        "          #           ##W                #    #   ",
                        "          ##         #, ;#:       D      ##  ##   ",
                        "           #        Di G# #j             W####.   ",
                        "           ##       # # #t       #       #  #     ",
                        "            #        # #                 #        ",
                        "             #                   :      #K        ",
                        "              #:                       ##         ",
                        "               ##                     ##          ",
                        "                ###                 ##j           ",
                        "                  #####D   ;## ######             ",
                        "                  # # D##### # ##                 ",
                        "                  # #     ,  # #                  ",
                        "             ##L .# #    ##### #                  ",
                        "             # i## #t     #  # #                  ",
                        "              # :# #      ;#   #                  ",
                        "              .#  D#        ## #                  ",
                        "                ###          :##                  ",
                        "                                                  ",
                        "                                                  ",
                        "                                                  ",
                        "                                                  ",
                        "                                                  "};

    char space = ' ';
    for(int i=0;i<50;i++){
        for(int j=0;j<50;j++){
            if(dickbutt[i][j]==  space){
                getCell(i, j)->setBombNum(9); //make it bomb
                mineCounter++;
                //numberPlacement(i, j); //increase all neighbours by one
            }
        }
    }
}

/*SoundManager Minesweeper::getSound(){
    return *soundMngr;
}

SoundManager Minesweeper::getMusic(){
    return *musicMngr;
}*/
