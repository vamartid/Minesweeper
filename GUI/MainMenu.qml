import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2

Rectangle {
    height: 860
    width: 484
    visible: true
    color: "#303030"

    Text{
        color: "#FFFFFF"
        text: qsTr("Minesweeper - built with QtQuick")
        width: parent.width
        anchors.margins: 26
        anchors.top: parent.top
        horizontalAlignment: Text.AlignHCenter
        //anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: 36
        wrapMode: Text.Wrap
    }

    Button
    {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width/2
        height:parent.height/8
        Text{
            width: parent.width
            height: parent.height
            text: qsTr("New game")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.Wrap
            font.pointSize: 18
        }
        onClicked:
        {
            stack.push(game);
        }
    }
    Component
    {
        id:game
        Game{}
    }

}
