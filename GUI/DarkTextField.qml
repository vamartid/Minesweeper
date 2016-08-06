import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

TextField{
    style: TextFieldStyle {
        textColor: "white"
        selectionColor: "#ff7043"
        background: Rectangle {
            radius: 5
            color: "#303030"
            border.color: "#9e9e9e"
            border.width: 1
        }
    }
}
