import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Button{
    id: cellBlock
    property int minDim: Math.min(rectID.height, rectID.width);
    height: minDim*0.08
    width : minDim*0.08
    property string cellText
    property string cellTextColor: "#000000"
    property string backgroundColor: rectID.backgroundColorNotPressed
    property int x_position
    property int y_position
    property int m: 0
    property int n: 0


    Text{
        //id: cellTextArea
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
               color: innerMouseArea.pressed ? rectID.backgroundColorPressed : backgroundColor;
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
        onClicked:
        {
            if(mouse.button & Qt.LeftButton){
                if(gridid.moves==0){
                    mineField.bombGenerator(x_position, y_position);
                    mineField.leftClickAction(x_position, y_position);
                    gridid.moves++;
                }else{
                   mineField.leftClickAction(x_position, y_position);
                }
                reveal();
            }else if(mouse.button & Qt.RightButton) {
                mineField.rightClickAction(x_position, y_position);
                rectID.remFlags = mineField.getRemFlags();
                if(!mineField.getisRevealed(x_position, y_position)){
                    if(mineField.getisFlagged(x_position, y_position)){
                        repeaterId.itemAt(x_position*columns+y_position).setFlagImage();
                        repeaterId.itemAt(x_position*columns+y_position).cellText = "";
                    }else{
                        if(mineField.getisQuestionMarked(x_position, y_position)){
                            repeaterId.itemAt(x_position*columns+y_position).clearImage();
                            repeaterId.itemAt(x_position*columns+y_position).cellText = "?";
                            repeaterId.itemAt(x_position*columns+y_position).cellTextColor = rectID.colorOne;
                        }else{
                            repeaterId.itemAt(x_position*columns+y_position).cellText = " ";
                        }
                    }
                }
            }
        }

        onDoubleClicked: {
            if(mouse.button & Qt.LeftButton){
               if(mineField.getisRevealed(x_position, y_position)){
                   if(!(mineField.getBombNum(x_position, y_position)===9)){
                       mineField.doubleClickAction(x_position, y_position);
                       reveal();
                   }
               }
            }
        }
    }




    function reveal() {
        for (m = 0; m < gridid.rows; m++) {
            for (n = 0; n < gridid.columns; n++) {
                if(mineField.isGameWon()){
                    repeaterId.itemAt(m*columns+n).enabled = false;
                    resetText.text = "😎";
                    secondCounter.stop();
                }else if(mineField.isGameLost()){
                    if(mineField.getisFlagged(m, n)){
                        repeaterId.itemAt(m*columns+n).clearImage();
                    }
                    repeaterId.itemAt(m*columns+n).enabled = false;
                    resetText.text = "😢";
                    secondCounter.stop();
                }

                if(mineField.getisRevealed(m,n)){
                    if(mineField.getBombNum(m,n)===9){
                        //if(mineField.getisFlagged(m,n)){
                            //repeaterId.itemAt(m*columns+n).setFlagImage(); //proxeiri lisi, prepei na exei kapoio bug kapou
                        //}else{
                            repeaterId.itemAt(m*columns+n).setBombImage();
                        //}
                    }else{
                        if (mineField.getBombNum(m,n) !== 0){
                            repeaterId.itemAt(m*columns+n).cellText = mineField.getBombNum(m,n).toString();
                            repeaterId.itemAt(m*columns+n).cellTextColor = getNumberColor(mineField.getBombNum(m,n));
                        }
                        repeaterId.itemAt(m*columns+n).backgroundColor = rectID.backgroundColorPressed;
                    }
                }
                /*}else if(mineField.getisFlagged(m,n)){
                    repeaterId.itemAt(m*columns+n).setFlagImage();
                    repeaterId.itemAt(m*columns+n).cellText = "";
                }else if(!mineField.getisFlagged(m,n)){
                    if(mineField.getisQuestionMarked(m,n)){
                        repeaterId.itemAt(m*columns+n).cellText = "?";
                        repeaterId.itemAt(m*columns+n).cellTextColor = rectID.colorOne;
                    }else{
                        repeaterId.itemAt(m*columns+n).cellText = " ";
                    }
                }else{
                    repeaterId.itemAt(m*columns+n).cellText = "";
                }*/
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
                return rectID.colorOne;
            case 2:
                return rectID.colorTwo;
            case 3:
                return rectID.colorThree;
            case 4:
                return rectID.colorFour;
            case 5:
                return rectID.colorFive;
            case 6:
                return rectID.colorSix;
            case 7:
                return rectID.colorSeven;
            case 8:
                return rectID.colorEight;
            default:
                return rectID.colorSeven;
        }
    }

    function reset() {
        cellText = "";
        enabled = true;
        backgroundImage.source = "";
        backgroundColor = rectID.backgroundColorNotPressed;
        cellTextColor = "#000000"
    }
}
