import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2

Rectangle {
    id: game
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
        columns : 16
        rows : 30
        Repeater{
            model:480
            Button{
                height: (game.width
                         -(gridid.spacing*(gridid.columns-1))
                         -(gridid.anchors.leftMargin)
                         -(gridid.anchors.rightMargin)
                         )/gridid.columns
                width : (game.width
                    -(gridid.spacing*(gridid.columns-1))
                    -(gridid.anchors.leftMargin)
                    -(gridid.anchors.rightMargin)
                    )/gridid.columns
                onClicked:
                {
                    stack.pop();
                }
            }
        }
    }
}
