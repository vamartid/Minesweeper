import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2

Rectangle {


    property int mines: parseInt(choice.mines)
    property int rows: parseInt(choice.rows)
    property int columns: parseInt(choice.columns)

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

    ScrollView {
        anchors.top: toolbar_game.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: parent.width*0.01
        Grid{
            id: gridid
            anchors.top: parent.top
            spacing: parent.width*0.001
            columns: rectID.columns
            rows: rectID.rows
            Repeater{
                id: repeaterId
                model:gridid.rows*gridid.columns
                CellBlock{
                    id: cellBlock
                    Text{
                        //text: rectID.rows
                    }

                }
            }
        }
    }
}
