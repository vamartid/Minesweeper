import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2

Rectangle {
    property int mines: parseInt(choice.mines)
    property int rows: parseInt(choice.rows)
    property int columns: parseInt(choice.columns)
    property int remFlags: parseInt(choice.mines)
    property bool flagClick: false
    //property bool lost: false
    property string colorOne: "#0B0CA5"
    property string colorTwo: "#147116"
    property string colorThree: "#A92322"
    property string colorFour: "#080846"
    property string colorFive: "#4D1514"
    property string colorSix: "#1F7373"
    property string colorSeven: "#000000"
    property string colorEight: "#808080"
    property string cellColorPressed: "#D1D1D1"
    property string cellColorNotPressed: "#F4F4F4"
    property int moves: 0
    property int m: 0
    property int n: 0

    //A counter to count the seconds
    SecondCounter{
        id: secondCounter
    }
    id: game
    height: parent.height
    width: parent.width
    visible: true
    color: "#303030"
    Keys.enabled: true
    focus: true
    Component.onCompleted: {
        forceActiveFocus()
    }
    function back_game(){
        if(mineField.isGameWon() || mineField.isGameLost()){
            stack.pop(stack.get(0))
        } else {
            exitGameDialog.visible = true;
        }
    }
    Keys.onReleased: {
        if(event.key === Qt.Key_Back){
            event.accepted = true;
            back_game();
        }
    }
    AndroidToolbar{
        id: toolbar_game
        BackButton{
            id: backButton_game
            onClicked:{
                back_game();
            }
        }
        //The remaining flags
        Rectangle{
            border.color: parent.color
            border.width: parent.height*0.03
            radius: 6
            color: "#303030"
            anchors.left: backButton_game.right
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height*0.7
            width: height*1.4
            Text{
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height*0.7
                text: remFlags.toString()
                color: "white"
                font.family: "whatever"
            }
        }
        Rectangle{
            anchors.centerIn: parent
            height: parent.height*0.8
            width: parent.height*1.7
            color: parent.color

            //The reset button
            AndroidButton{
                id: resetButton
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height
                width: height
                Image {
                    anchors.margins: parent.height*0.1
                    id: resetButtonImage
                    anchors.fill: parent
                    source: "icons/smiling.png"
                    smooth: true
                }
                onClicked:{
                    //lost = false
                    for (m = 0; m < gridid.rows; m++) {
                        for (n = 0; n < gridid.columns; n++) {
                           repeaterId.itemAt(m*columns+n).reset();

                        }
                    }
                    flagButton.enabled = true;
                    timerText.text = Qt.binding(function() { return secondCounter.seconds})
                    timerRectangle.timer = true;
                    timerMouseArea.enabled = true;
                    secondCounter.stop();
                    secondCounter.seconds = 0;
                    gridid.enabled = true;
                    mineField.initField(columns, rows, mines);
                    moves = mineField.getMoves();
                    resetButtonImage.source = "icons/smiling.png"
                    remFlags = mines;
                    flagClick = false;
                    flagButtonImage.source = "icons/flag-greyed.png"
                }
            }
            //The flag button
            AndroidButton{
                id: flagButton
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height
                width: height
                Image {
                    anchors.margins: parent.height*0.1
                    id: flagButtonImage
                    anchors.fill: parent
                    source: "icons/flag-greyed.png"
                    smooth: true
                }
                onClicked:{
                    if(flagClick){
                        flagButtonImage.source = "icons/flag-greyed.png"
                        flagClick = false;
                    } else {
                        flagButtonImage.source = "icons/flag.png"
                        flagClick = true;
                    }
                }
            }
        }
        //Timer/move counter
        Rectangle{
            id: timerRectangle
            border.color: parent.color
            border.width: parent.height*0.03
            radius: 6
            color: "#303030"
            anchors.right: parent.right
            anchors.rightMargin: backButton_game.width
            anchors.verticalCenter: parent.verticalCenter
            width: height*1.4
            height: parent.height*0.7
            property bool timer: true
            Text{
                id: timerText
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height*0.7
                text: secondCounter.seconds
                //text: moves
                color: "white"
                font.family: "whatever"
            }
            MouseArea{
                id: timerMouseArea
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton
                onClicked:{
                    if(timerRectangle.timer){
                        timerText.text = Qt.binding(function() { return moves})
                        timerRectangle.timer = false;
                    } else {
                        timerText.text = Qt.binding(function() { return secondCounter.seconds})
                        timerRectangle.timer = true;
                    }
                }
            }
        }
    }
    //ScrollView containing a Grid, which holds all the cells of the minefield
    ScrollView {
        anchors.top: toolbar_game.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: parent.width*0.01
        Grid{
            id: gridid
            anchors.top: parent.top
            spacing: root.width*0.001
            columns: game.columns
            rows: game.rows
            Repeater{
                id: repeaterId
                model:gridid.rows*gridid.columns
                onItemAdded:{
                    itemAt(index).x_position = index/gridid.columns
                    itemAt(index).y_position = index % gridid.columns
                }
                CellBlock{
                }
            }
        }
    }

    //A rectangle that shows up when the game is won, to enter a name for the high scores
    //rectangle is used instead of window, so it works well on mobile platforms(modality is handled manually)
    NameInputDialog{
        id: nameInputDialog
        visible: false
        onVisibleChanged: {
            if(visible === true){
                resetButton.enabled = false;
                backButton_game.enabled = false;
                timerMouseArea.enabled = false;
                forceActiveFocus();
            } else {
                resetButton.enabled = true;
                backButton_game.enabled = true;
                timerMouseArea.enabled = true;
                game.forceActiveFocus();
            }
        }
    }
    //A rectangle that shows up when you try to exit the game and it is not yet finished
    //Similar functionality to NameInputDialog
    ExitGameDialog{
        id: exitGameDialog
        visible: false
        onVisibleChanged: {
            if(visible === true){
                resetButton.enabled = false;
                backButton_game.enabled = false;
                flagButton.enabled = false;
                timerMouseArea.enabled = false;
                forceActiveFocus();
                secondCounter.stop();
                gridid.enabled = false;
            } else {
                resetButton.enabled = true;
                backButton_game.enabled = true;
                flagButton.enabled = true;
                timerMouseArea.enabled = true;
                game.forceActiveFocus();
                secondCounter.start();
                gridid.enabled = true;
            }

        }
    }

    //functions for left, right and double click
    function leftClicked(x_position, y_position){
        if(mineField.getMoves()===0){
            mineField.bombGenerator(x_position, y_position);
            mineField.leftClickAction(x_position, y_position);
            secondCounter.start();
        }else{
           mineField.leftClickAction(x_position, y_position);
        }
        sound2Mngr.playSound();
        game.update();
        if(mineField.isGameWon() && !choice.customGame){
            nameInputDialog.visible = true;
        }
        game.moves = mineField.getMoves();
    }

    function rightClicked(x_position, y_position){
        if(mineField.getMoves() === 0){
            toast.show("Reveal a cell to start the game")
        } else {
            mineField.rightClickAction(x_position, y_position);
            sound2Mngr.playSound();
            if(!mineField.getisRevealed(x_position, y_position)){
                if(game.remFlags === 0 && mineField.getRemFlags() === 0){
                    toast.show("No more flags left!")
                }
                if(mineField.getisFlagged(x_position, y_position)){
                    repeaterId.itemAt(x_position*columns+y_position).setFlagImage();
                    repeaterId.itemAt(x_position*columns+y_position).cellText = "";
                }else{
                    repeaterId.itemAt(x_position*columns+y_position).clearImage();
                    repeaterId.itemAt(x_position*columns+y_position).cellText = " ";
                }
            }
            game.remFlags = mineField.getRemFlags();
            game.moves = mineField.getMoves();
        }
    }

    function doubleClicked(x_position, y_position){
        if(mineField.getisRevealed(x_position, y_position)){
            if(!(mineField.getBombNum(x_position, y_position)===9)){
                mineField.doubleClickAction(x_position, y_position);
                sound2Mngr.playSound();
                game.update();
                if(mineField.isGameWon() && !choice.customGame){
                    nameInputDialog.visible = true;
                }
            }
        }
        game.moves = mineField.getMoves();
    }

    //a function that updates the minefield grid
    function update() {
        if(mineField.isGameWon()){
            gameMove();
            winGame();
        }else if(mineField.isGameLost()){
            loseGame();
        } else {
            gameMove();
        }
    }

    //function that makes a normal move in the game, when one or more cells are revealed
    function gameMove(){
        for (m = 0; m < gridid.rows; m++) {
            for (n = 0; n < gridid.columns; n++) {
                if(mineField.getisRevealed(m,n)){
                    if (mineField.getBombNum(m,n) !== 0){
                        repeaterId.itemAt(m*columns+n).cellText = mineField.getBombNum(m,n).toString();
                        repeaterId.itemAt(m*columns+n).cellTextColor = getNumberColor(mineField.getBombNum(m,n));
                    }
                    repeaterId.itemAt(m*columns+n).cellColor = game.cellColorPressed;
                }
            }
        }
    }

    //function to call when the game is lost
    function loseGame(){
        flagButton.enabled = false;
        resetButtonImage.source = "icons/crying.png"
        secondCounter.stop();
        sound3Mngr.playSound();
        for (m = 0; m < gridid.rows; m++) {
            for (n = 0; n < gridid.columns; n++) {
                if(mineField.getBombNum(m,n) === 9){
                    if(mineField.getisFlagged(m, n)){
                        repeaterId.itemAt(m*columns+n).setFlaggedBombImage();
                    }else {
                        repeaterId.itemAt(m*columns+n).setBombImage();
                    }
                } else {
                    if (mineField.getBombNum(m,n) !== 0){
                        repeaterId.itemAt(m*columns+n).cellText = mineField.getBombNum(m,n).toString();
                        repeaterId.itemAt(m*columns+n).cellTextColor = getNumberColor(mineField.getBombNum(m,n));
                    }
                    if(mineField.getisFlagged(m,n)){
                        repeaterId.itemAt(m*columns+n).clearImage();
                    }
                    repeaterId.itemAt(m*columns+n).cellColor = game.cellColorPressed;
                }
            }
        }
        gridid.enabled = false;
    }

    //function to call when the game is won
    function winGame(){
        resetButtonImage.source = "icons/sunglasses.png"
        flagButton.enabled = false;
        secondCounter.stop();
        gridid.enabled = false;
    }

    //simple switch to get the correct number color
    function getNumberColor(number){
        switch(number) {
            case 1:
                return game.colorOne;
            case 2:
                return game.colorTwo;
            case 3:
                return game.colorThree;
            case 4:
                return game.colorFour;
            case 5:
                return game.colorFive;
            case 6:
                return game.colorSix;
            case 7:
                return game.colorSeven;
            case 8:
                return game.colorEight;
            default:
                return game.colorSeven;
        }
    }
}
