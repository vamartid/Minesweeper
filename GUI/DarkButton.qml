import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Button
{
    id: darkButton
    style: ButtonStyle{
        background: Rectangle {
            //border.width: control.activeFocus ? 2 : 1
            border.width: 0
            border.color: "#888"
            color: darkButton.pressed ? "#4c4c4c" : "#303030";//"#4f4f4f";
            radius: 2;
        }
    }
}
