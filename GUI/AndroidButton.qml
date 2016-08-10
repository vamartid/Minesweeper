import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Button
{
    id: androidButton
    style: ButtonStyle{
        background: Rectangle {
            border.width: control.activeFocus ? 2 : 1
            border.color: "#888"
            gradient: Gradient {
                GradientStop { position: 0 ; color: control.pressed ? "#E2E2E2" : "#F2F2F2" }
                GradientStop { position: 1 ; color: control.pressed ? "#D2D2D2" : "#E2E2E2" }
            }
            radius: 2;
        }
    }
}
