import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

ToolButton
{
    Image
    {
        width: parent.width*0.6
        height: parent.height*0.6
        source: "icons/back-arrow.png"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
    anchors.left: parent.left
    anchors.top: parent.top
    width: parent.height
    height:width
}
