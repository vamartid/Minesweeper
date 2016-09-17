import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "qrc:/Styles/" 1.0

Button
{
    id: darkButton
    property string buttonColor: darkButton.pressed ? Style.color.android_Button2_Pressed : Style.color.android_Button2_Released
    style: ButtonStyle{
        id:buttonStyle
        background: Rectangle {
            color: buttonColor
            radius: 2;
        }
    }
    function changeColor(pressed){
        if(pressed){
            buttonColor = Style.color.android_Button2_Pressed
        } else {
            buttonColor = Qt.binding(function() {return darkButton.pressed ? Style.color.android_Button2_Pressed : Style.color.android_Button2_Released})
        }
    }
}
