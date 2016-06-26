import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2

Rectangle {
    height: 860
    width: 484
    visible: true
    color: "#303030"

    Rectangle
    {
        id: toolbar_main_menu
        width: parent.width
        height: parent.height*0.07
        color: "#FF5722"
        Text{
            color: "#FFFFFF"
            //text: qsTr("<a href=\"http://qt-project.org\">Minesweeper - built with QtQuick</a>")
            text: qsTr("Minesweeper - Qt quick")
            width: parent.width
            //anchors.margins: parent.height*0.03
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.04
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: parent.height*0.45
            wrapMode: Text.Wrap
            linkColor: "#FFFFFF"
            //onLinkActivated:
            //{
              //  stack.push(game)
            //}
        }
    }

    //Game logo!!
    Rectangle{
        id: logo
        anchors.top: toolbar_main_menu.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: parent.height*0.3
        visible:true
        color: parent.color

        Image{
            id: img1
            width: parent.height*0.5
            height: parent.height*0.5
            source: "icons/mine-white.png"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }
        Text{
            color:"#FFFFFF"
            text: qsTr("mine\nsweeper")
            anchors.left: img1.right
            anchors.right:img2.left
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: parent.height*0.2
            font.family: "droid sans mono"
            //font.family: "deja vu sans mono"
            wrapMode: Text.Wrap
        }
        Image{
            id: img2
            width: parent.height*0.5
            height: parent.height*0.5
            source: "icons/mine-white.png"
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    Rectangle{
        color: parent.color
        width:parent.width/2
        anchors.top: logo.bottom
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: parent.height*0.1
        //New game button, other buttons will go below it.
        Button
        {
            id: new_game
            anchors.top: parent.top
            width: parent.width
            height:parent.height/9
            Text{
                width: parent.width
                height: parent.height
                text: qsTr("New game")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
                font.pixelSize: parent.height*0.5
            }
            onClicked:
            {
                stack.push(game);
            }
        }

        Button
        {
            id: high_scores
            anchors.top: new_game.bottom
            anchors.topMargin: parent.height*0.017
            width: parent.width
            height:parent.height/9
            Text{
                width: parent.width
                height: parent.height
                text: qsTr("High scores")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
                font.pixelSize: parent.height*0.5
            }
        }
        Button
        {
            id: about
            anchors.top: high_scores.bottom
            anchors.topMargin: parent.height*0.017
            width: parent.width/2.06
            height:parent.height/9
            Text{
                width: parent.width
                height: parent.height
                text: qsTr("About")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
                font.pixelSize: parent.height*0.5
            }
        }
        Button
        {
            id: help
            anchors.top: high_scores.bottom
            anchors.topMargin: parent.height*0.017
            anchors.right: parent.right
            width: parent.width/2.06
            height:parent.height/9
            Text{
                width: parent.width
                height: parent.height
                text: qsTr("?")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
                font.pixelSize: parent.height*0.5
            }
        }
        //this text should go to the about page
        Text{
            visible:false
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width*0.9
            color: "#FFFFFF"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: parent.height*0.035
            text: qsTr("License: GPL v3, Aristotle University of Thessaloniki 2016")
        }
    }

    Component
    {
        id:game
        Game{}
    }

}
