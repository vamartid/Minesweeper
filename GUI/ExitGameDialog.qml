import QtQuick 2.5
import QtQuick.Controls 1.4
import "qrc:/Styles/" 1.0

Item{
    id: exitGameDialog
    height: root.height
    width: root.width
    Rectangle{
        id: opacityBox
        anchors.fill: parent
        color: "black"
        opacity: 0
        OpacityAnimator {
            id: opacityAnimation
            target: opacityBox
            from: 0
            to: 0.7
            duration: 200
            running: false
            easing.type: Easing.OutQuad
        }
        onVisibleChanged: {
            if(visible === true){
                opacityAnimation.running = true
            } else {
                opacity = 0;
                opacityAnimation.running = false
            }
        }
    }

    Rectangle{
        property int minDim: Math.min(parent.height, parent.width);
        width: minDim*0.9
        height: minDim*0.5
        visible: true
        color: Style.color.dialog_Background
        anchors.centerIn: parent
        Keys.enabled: true
        Keys.onReleased: {
            if(event.key === Qt.Key_Back){
                event.accepted = true;
                exitGameDialog.visible = false;
            }
        }
        Rectangle {
            id: exitTextRectangle
            visible:true
            color: Style.color.dialog_Background
            anchors.topMargin: parent.height*0.01
            height: parent.height*0.5
            anchors.top: parent.top
            width: parent.width*0.9
            anchors.horizontalCenter: parent.horizontalCenter
            Label {
                id: label1
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                color: Style.color.dialog_Text
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
            color: Style.color.dialog_Background
            anchors.top: exitTextRectangle.bottom
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
                    exitGameDialog.visible = false
                }
            }
        }
    }
}
