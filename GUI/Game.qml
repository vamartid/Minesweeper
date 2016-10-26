import QtQuick 2.5
import QtQuick.Controls 1.4
import "qrc:/Styles/" 1.0

Rectangle {
    property int mines: parseInt(choice.mines)
    property int rows: parseInt(choice.rows)
    property int columns: parseInt(choice.columns)
    property int remFlags: parseInt(choice.mines)
    property bool flagClick: false

    property string cellColorPressed: Style.color.cellColorPressed
    property string cellColorNotPressed: Style.color.cellColorNotPressed

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
    color: Style.color.background
    Keys.enabled: true
    focus: true
    Component.onCompleted: {
        forceActiveFocus()
    }
    function back_game(){
        if(mineField.isGameWon() || mineField.isGameLost() || mineField.getMoves() === 0){
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
    Keys.onPressed: {
        switch(event.key) {
            case Qt.Key_Left:
                gameFlickable.flick(+500,0);
                break;
            case Qt.Key_A:
                gameFlickable.flick(+500,0);
                break;
            case Qt.Key_Right:
                gameFlickable.flick(-500,0);
                break;
            case Qt.Key_D:
                gameFlickable.flick(-500,0);
                break;
            case Qt.Key_Up:
                gameFlickable.flick(0,+500);
                break;
            case Qt.Key_W:
                gameFlickable.flick(0,+500);
                break;
            case Qt.Key_Down:
                gameFlickable.flick(0,-500);
                break;
            case Qt.Key_S:
                gameFlickable.flick(0,-500);
                break;
        }
    }

    onHeightChanged: {
        gridid.scale = 1
    }

    onWidthChanged: {
        gridid.scale = 1
    }

    AndroidToolbar{
        id: toolbar_game
        z: 10
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
            color: Style.color.background
            anchors.left: backButton_game.right
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height*0.7
            width: height*1.4
            Text{
                id: remFlagsText
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height*0.7
                text: remFlags
                color: Style.color.text
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
                    source: Style.icons.smile
                    smooth: true
                }
                onClicked:{
                    for (m = 0; m < gridid.rows; m++) {
                        for (n = 0; n < gridid.columns; n++) {
                           repeaterId.itemAt(m*columns+n).reset();

                        }
                    }
                    flagButton.enabled = true;
                    timerText.text = Qt.binding(function() { return secondCounter.seconds})
                    remFlagsText.text = Qt.binding(function() { return remFlags})
                    timerText.font.pixelSize = 0.7*timerText.height
                    remFlagsText.font.pixelSize = 0.7*remFlagsText.height
                    timerRectangle.timer = true;
                    timerMouseArea.enabled = true;
                    secondCounter.stop();
                    secondCounter.seconds = 0;
                    gridid.enabled = true;
                    mineField.initField(columns, rows, mines);
                    moves = mineField.getMoves();
                    resetButtonImage.source = Style.icons.smile
                    remFlags = mines;
                    flagClick = false;
                    flagButtonImage.source = Style.icons.flag_greyed
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
                    source: Style.icons.flag_greyed
                    smooth: true
                }
                onClicked:{
                    if(flagClick){
                        flagButtonImage.source = Style.icons.flag_greyed
                        flagClick = false;
                    } else {
                        flagButtonImage.source = Style.icons.flag
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
            color: Style.color.background
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
                color: Style.color.text
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
    Flickable {
        id: gameFlickable
        anchors.top: toolbar_game.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: Math.max(game.height, game.width)*0.0035
        boundsBehavior: Flickable.StopAtBounds
        contentHeight: gridid.height*gridid.scale > height ? gridid.height*gridid.scale : height
        contentWidth: gridid.width*gridid.scale > width ? gridid.width*gridid.scale : width
        clip: true
        focus: true
        z: 0
        MouseArea{
            id:flickMouseArea
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            onWheel: {
                if (wheel.modifiers && Qt.ControlModifier && !nameInputDialog.visible && !exitGameDialog.visible){
                    if (wheel.angleDelta.y > 0){
                        if(!(gridid.scale + 0.07 >= 2)){
                            gridid.scale += 0.07
                        }
                    }else {
                        if((gridid.scale - 0.07)*gridid.width > gameFlickable.width || (gridid.scale - 0.07)*gridid.height > gameFlickable.height){
                            gridid.scale -= 0.07
                        } else {
                            gridid.scale = gameFlickable.height/gridid.height > gameFlickable.width/gridid.width ? gameFlickable.width/gridid.width : gameFlickable.height/gridid.height;
                        }
                    }
                }else{
                    wheel.accepted=false
                }
            }
        }
        PinchArea{
            id: gamePinchArea
            anchors.fill: parent
            pinch.target: gridid
            pinch.minimumScale: gameFlickable.height/gridid.height > gameFlickable.width/gridid.width ? gameFlickable.width/gridid.width : gameFlickable.height/gridid.height
            pinch.maximumScale: 2
            onPinchStarted: {
                gameFlickable.interactive = false;
            }
            onPinchFinished: {
                gameFlickable.interactive = true;
            }
            Grid{
                id: gridid
                //scale: gameFlickable.height/gridid.height > gameFlickable.width/gridid.width ? gameFlickable.width/gridid.width : gameFlickable.height/gridid.height
                anchors.top: parent.top
                anchors.left: parent.left
                //anchors.horizontalCenter: parent.horizontalCenter
                //anchors.centerIn: parent
                spacing: Math.max(game.height, game.width)*0.001
                columns: game.columns
                rows: game.rows
                transformOrigin: Item.TopLeft

                //An animation when the game starts to show that the grid may be bigger than the window
                ScaleAnimator {
                        //id: zoomAnimation
                        running : gridid.height > gameFlickable.height || gridid.width > gameFlickable.width
                        target: gridid;
                        from: gameFlickable.height/gridid.height > gameFlickable.width/gridid.width ? gameFlickable.width/(1.3*gridid.width) : gameFlickable.height/(1.3*gridid.height)
                        to: 1;
                        duration: 1000
                        //easing.type: Easing.InCurve
                    }
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
    }

    //A rectangle that shows up when the game is won, to enter a name for the high scores
    //rectangle is used instead of window, so it works well on mobile platforms(modality is handled manually)
    NameInputDialog{
        id: nameInputDialog
        z: 11
        visible: false
        onVisibleChanged: {
            if(visible === true){
                resetButton.enabled = false;
                backButton_game.enabled = false;
                timerMouseArea.enabled = false;
                gameFlickable.interactive = false;
                gamePinchArea.enabled = false;
                forceActiveFocus();
            } else {
                resetButton.enabled = true;
                backButton_game.enabled = true;
                timerMouseArea.enabled = true;
                gameFlickable.interactive = true;
                gamePinchArea.enabled = true;
                game.forceActiveFocus();
            }
        }
    }
    //A rectangle that shows up when you try to exit the game and it is not yet finished
    //Similar functionality to NameInputDialog
    ExitGameDialog{
        id: exitGameDialog
        z: 11
        visible: false
        onVisibleChanged: {
            if(visible === true){
                resetButton.enabled = false;
                backButton_game.enabled = false;
                flagButton.enabled = false;
                timerMouseArea.enabled = false;
                gameFlickable.interactive = false;
                gamePinchArea.enabled = false;
                forceActiveFocus();
                secondCounter.stop();
                gridid.enabled = false;
            } else {
                resetButton.enabled = true;
                backButton_game.enabled = true;
                flagButton.enabled = true;
                timerMouseArea.enabled = true;
                gameFlickable.interactive = true;
                gamePinchArea.enabled = true;
                game.forceActiveFocus();
                if(mineField.getMoves() !== 0){
                    secondCounter.start();
                }
                gridid.enabled = true;
            }

        }
    }

    //functions for left, right and double click
    function leftClicked(x_position, y_position){
        if(!mineField.getisRevealed(x_position, y_position) && mineField.getBombNum(x_position, y_position) !== 9){
            sound2Mngr.playSound();
        }
        if(mineField.getMoves()===0){
            mineField.bombGenerator(x_position, y_position);
            mineField.leftClickAction(x_position, y_position);
            secondCounter.start();
        }else{
           mineField.leftClickAction(x_position, y_position);
        }
        game.update();
        if(mineField.isGameWon() && !choice.customGame){
            nameInputDialog.visible = true;
        }
        game.moves = mineField.getMoves();
    }

    function rightClicked(x_position, y_position){
        if(mineField.getMoves() === 0){
            toast.show("Reveal a block to start the game")
        } else {
            mineField.rightClickAction(x_position, y_position);
            if(!mineField.getisRevealed(x_position, y_position)){
                sound2Mngr.playSound();
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
        resetButtonImage.source = Style.icons.dazed
        secondCounter.stop();
        sound3Mngr.playSound();
        if(game.rows === 50 && game.columns === 50 && game.mines){
            remFlagsText.font.pixelSize = 0.6*remFlagsText.height;
            remFlagsText.text = qsTr("dick");
            timerText.font.pixelSize = 0.5*timerText.height;
            timerText.text = qsTr("butt");
        }

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
        resetButtonImage.source = Style.icons.sunglasses
        flagButton.enabled = false;
        secondCounter.stop();
        gridid.enabled = false;
    }

    //simple switch to get the correct number color
    function getNumberColor(number){
        switch(number) {
            case 1:
                return Style.color.colorOne;
            case 2:
                return Style.color.colorTwo;
            case 3:
                return Style.color.colorThree;
            case 4:
                return Style.color.colorFour;
            case 5:
                return Style.color.colorFive;
            case 6:
                return Style.color.colorSix;
            case 7:
                return Style.color.colorSeven;
            case 8:
                return Style.color.colorEight;
            default:
                return Style.color.colorSeven;
        }
    }
}
