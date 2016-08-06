import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2

Window {
    modality: Qt.WindowModal
    id: nameInputWindow
    title: qsTr("You Won!")
    maximumHeight: 200
    minimumHeight: 200
    maximumWidth: 384
    minimumWidth: 384
    Rectangle{
        visible: true
        color: "#303030"
        anchors.fill: parent
        id: nameInputRectangle
        Text{
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            color: "white"
            text: qsTr("Please enter your name")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: parent.height*0.14
        }

        Rectangle{
            id: nameRect
            visible:true
            color: "#303030"
            height: parent.height*0.2
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.3
            anchors.left: parent.left
            anchors.right: parent.right
            Text{
                id: nameText
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                color: "white"
                width: parent.width*0.3
                text: qsTr("Name: ")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: parent.height*0.6
            }
            DarkTextField{
                anchors.top: parent.top
                anchors.left: nameText.right
                anchors.right: parent.right
                anchors.rightMargin: parent.width*0.1
                anchors.bottom: parent.bottom
                font.pixelSize: parent.height*0.6
            }
        }
        Rectangle{
            color: "#303030"
            anchors.top: nameRect.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: parent.height*0.2
            anchors.bottomMargin: parent.height*0.1
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width*0.6
            Button{
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
            }
            Button{
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
                onClicked: nameInputWindow.close();
            }
        }
    }
}
