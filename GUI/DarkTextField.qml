import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

TextField{
    style: TextFieldStyle {
        textColor: "white"
        selectionColor: "#ff7043"
        background: Rectangle {
            radius: 5
            color: "#3f3f3f"
            border.color: "#9e9e9e"
            border.width: 1
        }
    }
}
