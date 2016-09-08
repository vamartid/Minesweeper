import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0


Rectangle{
    id: exitGameDialog
    property int minDim: Math.min(parent.height, parent.width);
    width: minDim*0.9
    height: minDim*0.5
    visible: true
    color: "#3f3f3f"
    anchors.centerIn: parent
    DropShadow {
        anchors.fill: exitGameDialog
        cached: true
        verticalOffset: exitGameDialog.height*0.03
        horizontalOffset: exitGameDialog.height*0.03
        samples: 16
        color: "#282828"
        source: exitGameDialog
    }
    radius: 4
    Keys.enabled: true
    Keys.onReleased: {
        if(event.key === Qt.Key_Back){
            event.accepted = true;
            exitGameDialog.visible = false;
        }
    }
    Rectangle {
        id: exitRectangle
        visible:true
        color: "#3f3f3f"
        anchors.topMargin: parent.height*0.01
        height: parent.height*0.5
        anchors.top: parent.top
        //anchors.topMargin: parent.height*0.5
        width: parent.width*0.9
        anchors.horizontalCenter: parent.horizontalCenter
        Label {
            id: label1
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            color: "white"
            width: parent.width
            text: qsTr("Are you sure you want to exit the game?")
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.Wrap
            font.pixelSize: parent.height*0.3
        }
    }
    Rectangle{
        color: "#3f3f3f"
        anchors.top: exitRectangle.bottom
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height*0.1
        anchors.topMargin: parent.height*0.15
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width*0.7
        AndroidButton{
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            width: parent.width*0.4
            Text{
                width: parent.width
                height: parent.height
                text: qsTr("Accept")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
                font.pixelSize: parent.height*0.5
            }
            onClicked: {
                soundMngr.playSound()
                stack.pop(stack.get(0))
            }
        }
        AndroidButton{
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            width: parent.width*0.4
            Text{
                width: parent.width
                height: parent.height
                text: qsTr("Cancel")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
                font.pixelSize: parent.height*0.5
            }
            onClicked: {
                soundMngr.playSound()
                exitGameDialog.visible = false
            }
        }
    }
}
