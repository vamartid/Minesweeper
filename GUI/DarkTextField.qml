import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

TextField{
    style: TextFieldStyle {
        textColor: "white"
        selectionColor: "#FF774C"
        background: Rectangle {
            radius: 7
            color: "#303030"
            border.color: "#F4F4F4"
            border.width: 1
        }
    }
}
