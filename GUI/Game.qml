import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2

Rectangle {
    height: 860
    width: 484
    visible: true
    color: "#303030"
    Button
    {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width/2
        height: parent.height/8
        Text{
            width: parent.width
            height: parent.height
            text: qsTr("Go back")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.Wrap
            font.pointSize: 18
        }
        onClicked:
        {
            //nameModel.append({"name":contactName.text ,"phone":contactPhone.text});
            stack.pop();
        }
    }

}
