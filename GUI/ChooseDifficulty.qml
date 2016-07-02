import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2

Rectangle {
    height: 860
    width: 484
    visible: true
    color: "#303030"
    AndroidToolbar
    {
        id: toolbar_difficulty_menu
        BackButton{
        id: backbutton}
        Text{
            color: "#FFFFFF"
            text: qsTr("Minesweeper - Qt quick")
            width: parent.width
            anchors.left: backbutton.right
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: parent.height*0.45
            wrapMode: Text.Wrap
        }

    }
    Text{
        id: logotext
        anchors.top: toolbar_difficulty_menu.bottom
        width: parent.width
        height: parent.height*0.2
        color:"#FFFFFF"
        text: qsTr("Choose a difficulty")
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: height*0.3
        font.family: "droid sans"
        wrapMode: Text.Wrap
    }
    Button
    {
        id: easybutton
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: mediumbutton.top
        anchors.bottomMargin: height*0.14
        width: parent.width/2
        height: parent.height/16
        Text{
            width: parent.width
            height: parent.height
            text: qsTr("Easy")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter + parent.height*0.3
            wrapMode: Text.Wrap
            font.pixelSize: parent.height*0.5
        }
        Text{

            width: parent.width
            height: parent.height
            text: qsTr("9x9 grid with 10 mines")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            wrapMode: Text.Wrap
            font.pixelSize: parent.height*0.3
        }
        onClicked: {
            stack.push(game)
        }
    }

    Button
    {
        id: mediumbutton
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width/2
        height: parent.height/16
        Text{
            width: parent.width
            height: parent.height
            text: qsTr("Medium")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter + parent.height*0.3
            wrapMode: Text.Wrap
            font.pixelSize: parent.height*0.5
        }
        Text{

            width: parent.width
            height: parent.height
            text: qsTr("16x16 grid with 40 mines")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            wrapMode: Text.Wrap
            font.pixelSize: parent.height*0.3
        }

    }

    Button
    {
        id: hardbutton
        anchors.top: mediumbutton.bottom
        anchors.topMargin: height*0.14
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width/2
        height: parent.height/16
        Text{
            width: parent.width
            height: parent.height
            text: qsTr("Hard")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter + parent.height*0.3
            wrapMode: Text.Wrap
            font.pixelSize: parent.height*0.5
        }
        Text{

            width: parent.width
            height: parent.height
            text: qsTr("30x16 grid with 99 mines")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            wrapMode: Text.Wrap
            font.pixelSize: parent.height*0.3
        }

    }

    Button
    {
        id: custombutton
        anchors.top: hardbutton.bottom
        anchors.topMargin: height*0.14
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width/2
        height: parent.height/16
        Text{
            width: parent.width
            height: parent.height
            text: qsTr("Custom")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter + parent.height*0.3
            wrapMode: Text.Wrap
            font.pixelSize: parent.height*0.5
        }
        Text{

            width: parent.width
            height: parent.height
            text: qsTr("Choose your paremeters below")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            wrapMode: Text.Wrap
            font.pixelSize: parent.height*0.3
        }

    }
    Component{
        id:game
        Game{}
    }

}
