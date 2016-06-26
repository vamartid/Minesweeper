import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

ApplicationWindow {
    visible: true
    width: 484
    height: 860
    title: qsTr("Minesweeper - Qt")
    minimumHeight: 860
    minimumWidth: 484

    Component{
        id: menu
        MainMenu{}
    }

    StackView
    {
        anchors.fill: parent
        initialItem: menu
        id: stack
    }
}
