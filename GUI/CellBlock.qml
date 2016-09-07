import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Button{
    id: cellBlock
    property int minDim: Math.min(game.height, game.width);
    //height: game.height*0.057
    width : minDim*0.108
    height : minDim*0.108
    //width: game.height*0.057
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
        font.family: "whatever"
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
            smooth: true
        }
        onPressAndHold: {
            if(mouse.button & Qt.LeftButton){
                if(game.flagClick){
                    game.leftClicked(x_position, y_position)
                } else {
                    game.rightClicked(x_position, y_position)
                }
            }
        }
        //if statements for checking for flag mode/reveal mode
        onClicked:
        {
            if(mouse.button & Qt.LeftButton){
                if(game.flagClick){
                    game.rightClicked(x_position, y_position)
                } else {
                    game.leftClicked(x_position, y_position)
                }
            }else if(mouse.button & Qt.RightButton) {
                if(game.flagClick){
                    game.leftClicked(x_position, y_position)
                } else {
                    game.rightClicked(x_position, y_position)
                }
            }
        }
        onPressed: {
            //if(!(mineField.getisRevealed(x_position, y_position) || mineField.getisFlagged(x_position, y_position))){
            if(!mineField.getisFlagged(x_position, y_position)){
                resetButtonImage.source = "icons/open-mouth.png"
            }
        }

        onReleased: {
            if(!(mineField.isGameLost() || mineField.isGameWon())){
                resetButtonImage.source = "icons/smiling.png"
            }
        }

        onDoubleClicked: {
            if(mouse.button & Qt.LeftButton){
               game.doubleClicked(x_position, y_position)
            }
        }
    }

    //functions for setting the cell image
    function setBombImage() {
        backgroundImage.source = "icons/mine-red.png";
    }

    function setFlagImage() {
        backgroundImage.source = "icons/flag.png";
    }

    function clearImage(){
        backgroundImage.source = "";
    }

    function setFlaggedBombImage() {
        backgroundImage.source = "icons/mine-greyflagged.png";
    }

    //resets this particular cell
    function reset() {
        cellText = "";
        enabled = true;
        backgroundImage.source = "";
        cellColor = game.cellColorNotPressed;
        cellTextColor = "#000000"
    }
}
