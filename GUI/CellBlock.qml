import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Button{
    property int minDim: Math.min(rectID.height, rectID.width);
    height: minDim*0.08
    width : minDim*0.08
    onClicked:
    {

    }
}
