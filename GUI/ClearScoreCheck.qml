import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import "qrc:/Styles/" 1.0


Rectangle{
    id: clearScoreCheck
    property int minDim: Math.min(parent.height, parent.width);
    width: minDim*0.9
    height: minDim*0.5
    visible: true
    color: Style.color.dialog_Background
    anchors.centerIn: parent
    DropShadow {
        anchors.fill: clearScoreCheck
        cached: true
        verticalOffset: clearScoreCheck.height*0.03
        horizontalOffset: clearScoreCheck.height*0.03
        samples: 16
        color: Style.color.dialog_Shadow
        source: clearScoreCheck
    }
    radius: 4
    Keys.enabled: true
    Keys.onReleased: {
        if(event.key === Qt.Key_Back){
            event.accepted = true;
            clearScoreCheck.visible = false;
        }
    }
    Rectangle {
        id: recktangle
        visible:true
        color: Style.color.dialog_Background
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
            color: Style.color.dialog_Text
            width: parent.width
            text: qsTr("Are you sure you want to clear all the high scores?")
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: parent.height*0.3
            wrapMode: Text.Wrap
        }
    }
    Rectangle{
        color: Style.color.dialog_Background
        anchors.top: recktangle.bottom
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
                color: Style.color.android_Button_Text
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
                mediator.clearScores()
                stack.pop(stack.get(0))
            }
        }
        AndroidButton{
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            width: parent.width*0.4
            Text{
                color: Style.color.android_Button_Text
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
                clearScoreCheck.visible = false
            }
        }
    }
}
