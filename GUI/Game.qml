import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2

Rectangle {


    property int mines: 0
    property string rows:easybutton.rows
    property string columns:easybutton.columns


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
            onClicked:{
                stack.pop(stack.get(0))
            }
        }
    }

    Grid{
        id: gridid
        anchors.top: toolbar_game.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: parent.width*0.01
        spacing: parent.width*0.001
        columns:    9
        rows:       9
        Repeater{
            id: repeaterId
            model:gridid.rows*gridid.columns
            CellBlock{
                id: cellBlock
                Text{
                    text: rectID.rows
                }

            }
        }
    }
}
