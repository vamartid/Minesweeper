import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2

Rectangle {
    property int mines: parseInt(choice.mines)
    property int rows: parseInt(choice.rows)
    property int columns: parseInt(choice.columns)
    property int remFlags: parseInt(choice.mines)
    property bool flagClick: false
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
    property int m: 0
    property int n: 0
    SecondCounter{
        id: secondCounter
    }
    id: game
    height: parent.height
    width: parent.width
    visible: true
    color: "#303030"

    AndroidToolbar{
        id: toolbar_game
        BackButton{
            id: backButton_game
            onClicked:{
                gridid.moves=0
                stack.pop(stack.get(0))
            }
        }
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
                font.family: "droid-sans-mono"
            }
        }
        Rectangle{
            anchors.centerIn: parent
            height: parent.height*0.8
            width: parent.height*1.7
            color: parent.color

            AndroidButton{
                id: resetButton
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height
                width: height
                //anchors.margins: width*0.05
                Image {
                    anchors.margins: parent.height*0.1
                    id: resetButtonImage
                    anchors.fill: parent
                    source: "icons/smiling.png"
                    smooth: true
                }
                onClicked:{
                    for (m = 0; m < gridid.rows; m++) {
                        for (n = 0; n < gridid.columns; n++) {
                           repeaterId.itemAt(m*columns+n).reset();

                        }
                    }
                    gridid.moves=0
                    secondCounter.seconds = 0;
                    secondCounter.restart();
                    mineField.initField(columns, rows, mines);
                    resetButtonImage.source = "icons/smiling.png"
                    remFlags = mines;
                    flagClick = false;
                    flagButtonImage.source = "icons/flag-greyed.png"
                }
            }
            AndroidButton{
                id: flagButton
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height
                width: height
                //anchors.margins: width*0.05
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
        Rectangle{
            border.color: parent.color
            border.width: parent.height*0.03
            radius: 6
            color: "#303030"
            anchors.right: parent.right
            anchors.rightMargin: backButton_game.width
            anchors.verticalCenter: parent.verticalCenter
            width: height*1.4
            height: parent.height*0.7
            Text{
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height*0.7
                text: secondCounter.seconds
                color: "white"
                font.family: "droid-sans-mono"
            }
        }
    }

    ScrollView {
        anchors.top: toolbar_game.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: parent.width*0.01
        Grid{
            property int moves: 0
            id: gridid
            anchors.top: parent.top
            spacing: parent.width*0.001
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
    NameInputDialog{
        id: nameInputDialog
        visible: false
        onVisibleChanged: {
            if(visible == true){
                resetButton.enabled = false;
                backButton_game.enabled = false;
                flagButton.enabled = false;
            } else {
                resetButton.enabled = true;
                backButton_game.enabled = true;
                flagButton.enabled = true;
            }
        }
    }
}
