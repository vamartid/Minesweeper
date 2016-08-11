import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2

Rectangle {
    height: parent.height
    width: parent.width
    visible: true
    color: "#303030"

    AndroidToolbar
    {
        id: toolbar_main_menu
        Text{
            color: "#FFFFFF"
            text: qsTr("Minesweeper - Qt quick")
            width: parent.width
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.04
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: parent.height*0.37
            wrapMode: Text.Wrap
        }
    }

    //Game logo!!
    Rectangle{
        id: logo
        anchors.topMargin: root.height*0.04
        anchors.top: toolbar_main_menu.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: parent.height*0.3
        visible:true
        color: parent.color

        Image{
            id: img1
            anchors.right: logotext.left
            width: parent.height*0.5
            height: parent.height*0.5
            source: "icons/mine-white.png"
            //anchors.verticalCenter: parent.verticalCenter
        }
        Text{
            id: logotext
            color:"#FFFFFF"
            text: qsTr("mine\nsweeper")
            width: height*0.88
            height: parent.height
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignTop
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: parent.height*0.2
            font.family: "droid sans mono"
            //font.family: "deja vu sans mono"
            wrapMode: Text.Wrap
        }
        Image{
            id: img2
            anchors.left: logotext.right
            width: parent.height*0.5
            height: parent.height*0.5
            source: "icons/mine-white.png"
            //anchors.verticalCenter: parent.verticalCenter
        }
    }
    Rectangle{
        color: parent.color
        width:parent.width/1.5
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: parent.height*0.35
        //New game button, other buttons will go below it.
        AndroidButton
        {
            id: new_game
            anchors.top: parent.top
            width: parent.width
            height: root.height/10
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
                stack.push(chooseDifficulty);
            }
        }

        AndroidButton
        {
            id: high_scores
            anchors.top: new_game.bottom
            anchors.topMargin: height*0.14
            width: parent.width
            height: root.height/10
            Text{
                width: parent.width
                height: parent.height
                text: qsTr("High scores")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
                font.pixelSize: parent.height*0.5
            }
            onClicked:
            {
                stack.push(scores);
            }
        }
        AndroidButton
        {
            id: about
            anchors.top: high_scores.bottom
            anchors.topMargin: height*0.14
            width: parent.width/2 - height*0.07
            height: root.height/10
            Text{
                width: parent.width
                height: parent.height
                text: qsTr("About")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
                font.pixelSize: parent.height*0.5
            }
            onClicked:
            {
                stack.push(aboutPage);
            }
        }
        AndroidButton
        {
            id: help
            anchors.top: high_scores.bottom
            anchors.topMargin: height*0.14
            anchors.right: parent.right
            width: parent.width/2 - height*0.07
            height: root.height/10
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
    }
    Text{
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width*0.9
        color: "#FFFFFF"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: parent.height*0.0186
        text: qsTr("Aristotle University of Thessaloniki - 2016")
    }

    Component
    {
        id:chooseDifficulty
        ChooseDifficulty{}
    }

    Component
    {
        id:scores
        Scores{}
    }

    Component
    {
        id: aboutPage
        AboutPage{}
    }

}
