import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Button{
    id: cellBlock
    property int minDim: Math.min(rectID.height, rectID.width);
    height: minDim*0.08
    width : minDim*0.08
    property string cellText
    property int x_position
    property int y_position
    property int m: 0
    property int n: 0


    Text{
        anchors.fill: parent
        text: cellText
        font.pixelSize: parent.height*0.7
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
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
                    if(mineField.getBombNum(m,n)===9){
                        for (m = 0; m < gridid.rows; m++) {
                            for (n = 0; n < gridid.columns; n++) {
                                if(mineField.getBombNum(m,n)===9){
                                    repeaterId.itemAt(m*columns+n).setBombImage();
                                }
                            }
                        }
                    }
                }
                reveal();
            }else if(mouse.button & Qt.RightButton) {
                mineField.rightClickAction(x_position, y_position);
                rectID.remFlags = mineField.getRemFlags();
                reveal();
            }

            if(mineField.isGameWon()){
                resetText.text = "😎";
                secondCounter.stop();
                for (m = 0; m < gridid.rows; m++) {
                    for (n = 0; n < gridid.columns; n++) {
                        repeaterId.itemAt(m*columns+n).enabled = false;
                    }
                }
            }
        }

        onDoubleClicked: {
           if(mineField.getisRevealed(x_position, y_position)){
               if(!(mineField.getBombNum(x_position, y_position)===9)){
                   mineField.doubleClickAction(x_position, y_position);
                   reveal();
               }
           }
           if(mineField.isGameWon()){
               resetText.text = "😎";
               secondCounter.stop();
               for (m = 0; m < gridid.rows; m++) {
                   for (n = 0; n < gridid.columns; n++) {
                       repeaterId.itemAt(m*columns+n).enabled = false;
                   }
               }
           }
        }
    }




    function reveal() {
        for (m = 0; m < gridid.rows; m++) {
            for (n = 0; n < gridid.columns; n++) {
                if(mineField.getisRevealed(m,n)){
                    if(mineField.getBombNum(m,n)===9){
                        if(mineField.getisFlagged(m,n)){
                            repeaterId.itemAt(m*columns+n).cellText = "^"; //proxeiri lisi, prepei na exei kapoio bug kapou
                        } else {
                            //repeaterId.itemAt(m*columns+n).cellText = "@";
                            resetText.text = "😢";//"☹";
                            secondCounter.stop();
                    }
                    }else{
                        repeaterId.itemAt(m*columns+n).cellText = mineField.getBombNum(m,n).toString();
                    }
                    //repeaterId.itemAt(m*columns+n).enabled = false;
                }else if(mineField.getisFlagged(m,n)){
                    repeaterId.itemAt(m*columns+n).cellText = "^";
                }else if(!mineField.getisFlagged(m,n)){
                    if(mineField.getisQuestionMarked(m,n)){
                        repeaterId.itemAt(m*columns+n).cellText = "?";
                    }else{
                        repeaterId.itemAt(m*columns+n).cellText = " ";
                    }
                }else{
                    repeaterId.itemAt(m*columns+n).cellText = " ";
                }
            }
        }
    }

    function setBombImage() {
        backgroundImage.source = "icons/mine-grey.png";
    }

    function reset() {
        cellText = "";
        enabled = true;
        backgroundImage.source = "";
    }
}

