import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "qrc:/Styles/" 1.0

ToolButton
{
    Image
    {
        width: parent.width*0.8
        height: parent.height*0.8
        source: Style.icons.b_arrow
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    width: parent.height*0.7
    height:width
    onClicked:{
        soundMngr.playSound()
    }
}
