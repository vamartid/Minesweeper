import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2

Rectangle {
    height: 860
    width: 484
    visible: true
    color: "#303030"
    Rectangle
    {
        width: parent.width
        height: parent.height*0.07
        id:toolbar
        color: "#FF5722"
        opacity: 100

        ToolButton
        {
            Image
            {
                width: parent.width*0.5
                height: parent.height*0.5
                source: "icons/back-arrow.png"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.left: parent.left
            anchors.top: parent.top
            width: parent.height
            height:width
            onClicked:
            {
                stack.pop();
            }
        }

    }
    Button
    {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width/2
        height: parent.height/16
        Text{
            width: parent.width
            height: parent.height
            text: qsTr("Go back")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.Wrap
            font.pixelSize: parent.height*0.5
        }

        onClicked:
        {
            //nameModel.append({"name":contactName.text ,"phone":contactPhone.text});
            stack.pop();
            //stack.push(menu);
        }
    }

}
