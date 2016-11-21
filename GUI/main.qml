import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

ApplicationWindow {
    id: root
    visible: true
    width: 432
    height: 768
    title: qsTr("Minesweeper - Qt")
    minimumHeight: 640
    minimumWidth: 360
    property double keepS: 50.0
    property double keepM: 0.0
//    onWidthChanged: {
//        height=width*1.77777777778
//    }
//    onHeightChanged: {
//        width=height/1.77777777778
//    }
    maximumHeight: width*16/9
    maximumWidth: height*2.2

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
