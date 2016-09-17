import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "qrc:/Styles/" 1.0

TextField{
    style: TextFieldStyle {
        textColor: Style.color.text
        selectionColor: Style.color.text_Selected
        background: Rectangle {
            radius: 5
            color: Style.color.dialog_Background
            border.color: Style.color.aboutPage_Rect_Border
            border.width: 1
        }
    }
}
