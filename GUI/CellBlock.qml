import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Button{
    id: cellBlock
    //property int minDim: Math.min(rectID.height, rectID.width);
    height: game.height*0.057
    //width : minDim*0.08
    width: game.height*0.057
    property string cellText
    property string cellTextColor: "#000000"
    property string cellColor: game.cellColorNotPressed
    property int x_position
    property int y_position
    property int m: 0
    property int n: 0


    Text{
        id: cellTextArea
        anchors.fill: parent
        text: cellText
        color: cellTextColor
        font.pixelSize: parent.height*0.7
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    style: ButtonStyle {
       background:
            Rectangle {
               color: innerMouseArea.pressed ? game.cellColorPressed : cellColor;
                radius: 1;
            }
    }

    MouseArea {
        id: innerMouseArea
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        Image {
            id: backgroundImage
            anchors.fill: parent
            source: ""
            smooth: true
        }
        onPressAndHold: {
            if(mouse.button & Qt.LeftButton){
                cellBlock.rightClicked()
            }
        }

        onClicked:
        {
            if(mouse.button & Qt.LeftButton){
                cellBlock.leftClicked()
            }else if(mouse.button & Qt.RightButton) {
                cellBlock.rightClicked()
            }
        }

        onDoubleClicked: {
            if(mouse.button & Qt.LeftButton){
               cellBlock.doubleClicked()
            }
        }
    }




    function reveal() {
        for (m = 0; m < gridid.rows; m++) {
            for (n = 0; n < gridid.columns; n++) {
                if(mineField.isGameWon()){
                    repeaterId.itemAt(m*columns+n).enabled = false;
                    //resetText.text = "😎";
                    resetButtonImage.source = "icons/sunglasses.png"
                    secondCounter.stop();
                }else if(mineField.isGameLost()){
                    if(mineField.getisFlagged(m, n)){
                        repeaterId.itemAt(m*columns+n).clearImage();
                    }
                    repeaterId.itemAt(m*columns+n).enabled = false;
                    //resetText.text = "😢";
                    resetButtonImage.source = "icons/crying.png"
                    secondCounter.stop();
                }

                if(mineField.getisRevealed(m,n)){
                    if(mineField.getBombNum(m,n)===9){
                        repeaterId.itemAt(m*columns+n).setBombImage();
                    }else{
                        if (mineField.getBombNum(m,n) !== 0){
                            repeaterId.itemAt(m*columns+n).cellText = mineField.getBombNum(m,n).toString();
                            repeaterId.itemAt(m*columns+n).cellTextColor = getNumberColor(mineField.getBombNum(m,n)); 
                        }
                        repeaterId.itemAt(m*columns+n).clearImage();
                        repeaterId.itemAt(m*columns+n).cellColor = game.cellColorPressed;
                    }
                }
            }
        }
    }

    function leftClicked(){
        if(gridid.moves==0){
            mineField.bombGenerator(x_position, y_position);
            mineField.leftClickAction(x_position, y_position);
            gridid.moves++;
        }else{
           mineField.leftClickAction(x_position, y_position);
        }
        reveal();
        if(mineField.isGameWon() && !choice.customGame){
            nameInputDialog.visible = true;
        }
    }

    function rightClicked(){
        mineField.rightClickAction(x_position, y_position);
        game.remFlags = mineField.getRemFlags();
        if(!mineField.getisRevealed(x_position, y_position)){
            if(mineField.getisFlagged(x_position, y_position)){
                repeaterId.itemAt(x_position*columns+y_position).setFlagImage();
                repeaterId.itemAt(x_position*columns+y_position).cellText = "";
            }else{
                if(mineField.getisQuestionMarked(x_position, y_position)){
                    repeaterId.itemAt(x_position*columns+y_position).clearImage();
                    repeaterId.itemAt(x_position*columns+y_position).cellText = "?";
                }else{
                    repeaterId.itemAt(x_position*columns+y_position).cellText = " ";
                }
            }
        }
    }

    function doubleClicked(){
        if(mineField.getisRevealed(x_position, y_position)){
            if(!(mineField.getBombNum(x_position, y_position)===9)){
                mineField.doubleClickAction(x_position, y_position);
                reveal();
                if(mineField.isGameWon() && !choice.customGame){
                    nameInputDialog.visible = true;
                }
            }
        }
    }

    function setBombImage() {
        backgroundImage.source = "icons/mine-red.png";
    }

    function setFlagImage() {
        backgroundImage.source = "icons/flag.png";
    }

    function clearImage(){
        backgroundImage.source = "";
    }

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

    function reset() {
        cellText = "";
        enabled = true;
        backgroundImage.source = "";
        cellColor = game.cellColorNotPressed;
        cellTextColor = "#000000"
    }
}
