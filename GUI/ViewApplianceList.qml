import QtQuick 2.5
import QtQuick.Controls 1.4

Rectangle {
    visible: true
    width:484
    height:860
    Component
    {
        id:addAppliance
        AddAppliance {}
    }

    Button
    {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width/2
        height:parent.height/8
        text: qsTr("Add an appliance")
        onClicked:
        {
            stack.push(addAppliance);
        }
    }
}
