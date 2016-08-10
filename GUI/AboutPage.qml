import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2

Rectangle {
    id: aboutPage
    height: parent.height
    width: parent.width
    visible: true
    color: "#303030"
    AndroidToolbar{
        id: toolbar_about
        BackButton{
            id: backbutton
            onClicked:{
                stack.pop()
            }
        }
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
        id: about_header
        anchors.top: toolbar_about.bottom
        width: parent.width
        height: parent.height*0.1
        color:"#FFFFFF"
        text: qsTr("About this program:")
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: height*0.5
        font.family: "droid sans"
        wrapMode: Text.Wrap
    }

    Text{
        id: about_body
        anchors.top: about_header.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: parent.width*0.05
        anchors.rightMargin: parent.width*0.05
        color:"#FFFFFF"
        text: qsTr("This program was created for a project in a mobile development course, in the Aristotle University of Thessaloniki.<br><br>
        It is licensed under GNU GPL v3 and the code is available  <a href=\"http://i.imgur.com/27nLhLy.gif\">on github</a>.<br><br>
        The main contributors are:
        <br>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"https://github.com/vamartid\">vamartid</a> - Vasilis Martidis<br>
        &nbsp;&nbsp;&nbsp;&nbsp;<a href=\"https://github.com/rigopoui\">rigopoui</a> - Yanis Rigopoulos<br>
        &nbsp;&nbsp;&nbsp;&nbsp;<a href=\"https://github.com/GeorgeKirm\">GeorgeKirm</a> - Giorgos Kirmitsakis")
        linkColor: "#3b85b0"
        horizontalAlignment: Text.AlignJustify
        font.pixelSize: height*0.026
        font.family: "droid sans"
        wrapMode: Text.Wrap
        onLinkActivated: Qt.openUrlExternally(link)
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.NoButton // we don't want to eat clicks on the Text
            cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
        }
    }

    Text{
        //visible:false
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width*0.9
        color: "#FFFFFF"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: parent.height*0.0186
        text: qsTr("Aristotle University of Thessaloniki - 2016")
    }
}
