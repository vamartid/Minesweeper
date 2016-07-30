import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2

Rectangle {


    property int mines: parseInt(choice.mines)
    property int rows: parseInt(choice.rows)
    property int columns: parseInt(choice.columns)
    property int remMines: parseInt(choice.mines)

//    property string rows:console.log(easybutton.rows)
//    property string collums:console.log(easybutton.colums)

    id: rectID
    height: parent.height
    width: parent.width
    visible: true
    color: "#303030"
    AndroidToolbar{
        id: toolbar_game
        BackButton{
            id: backButton
            onClicked:{
                gridid.moves=0
                stack.pop(stack.get(0))
            }
        }
        Rectangle{
            border.color: "#FF5722"
            border.width: parent.height*0.03
            radius: 6
            color: "#303030"
            anchors.left: backButton.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: height*1.4
            Text{
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height*0.7
                text: remMines.toString()
                color: "white"
                font.family: "droid-sans-mono"
            }
        }
        Button{
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height
            width: height
            anchors.margins: width*0.05
            Text{
                id: resetText
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height
                //text: "☺"
                text: "😏"
                font.pixelSize: parent.height*0.75
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
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
            columns: rectID.columns
            rows: rectID.rows
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
