import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

ApplicationWindow {
    id: root
    visible: true
    width: 406
    height: 768
    title: qsTr("Minesweeper - Qt")
    minimumHeight: 640
    minimumWidth: 360
    maximumHeight: width*16/9

    Component{
        id: menu
        MainMenu{}
    }
    ToastManager{
        id: toast
    }

    StackView
    {
        anchors.fill: parent
        initialItem: menu
        id: stack
    }
}
