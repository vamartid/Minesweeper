import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Button{
    property int minDim: Math.min(rectID.height, rectID.width);
    height: minDim*0.08
    width : minDim*0.08
    property int x_position
    property int y_position
    Text{
        anchors.fill: parent
        id: cellText
        font.pixelSize: parent.height*0.8
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    onClicked:
    {
        mineField.leftClickAction(x_position, y_position);
        cellText.text = mineField.getBombNum(x_position, y_position).toString();
        this.enabled = false;
    }
}
