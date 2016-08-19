import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Button
{
    id: darkButton
    property string buttonColor: darkButton.pressed ? "#4c4c4c" : "#303030"
    style: ButtonStyle{
        id:buttonStyle
        background: Rectangle {
            //id: buttonColor
            //border.width: control.activeFocus ? 2 : 1
            border.width: 0
            border.color: "#888"
            color: buttonColor
            radius: 2;
        }
    }
    function changeColor(pressed){
        if(pressed){
            buttonColor = "#4c4c4c"
        } else {
            buttonColor = Qt.binding(function() {return darkButton.pressed ? "#4c4c4c" : "#303030"})
        }
    }
}
