import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2

Rectangle {
    height: 860
    width: 484
    visible: true
    color: "#303030"
    Rectangle
    {
        width: parent.width
        height: parent.height*0.07
        id:toolbar
        color: "#FF5722"
        BackButton{}
    }
    Grid{
        spacing: 20
        columns : 3
        rows : 3
        Repeater{
            model:9
            Button{
            width: 20
            height: 20
                onClicked:
                {
                    stack.pop();
                }
            }
        }
    }

}
