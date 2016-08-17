import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2

Rectangle {
    id: scoreView
    height: 860
    width: 484
    visible: true
    color: "#303030"
    AndroidToolbar{
        id: toolbar_game
        BackButton{
            id: backbutton
            onClicked:{
                stack.pop(stack.pop())
            }
        }
        Text{
            color: "#FFFFFF"
            text: qsTr("Minesweeper - Qt quick")
            width: parent.width
            anchors.left: backbutton.right
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: parent.height*0.45
            wrapMode: Text.Wrap
        }
    }
    AndroidButton
    {
        id: easyScores
        anchors.top: toolbar_game.bottom
        anchors.topMargin: height*0.34
        anchors.left: parent.left
        anchors.leftMargin: height*0.34
        width: (parent.width-height*0.34*4)/3
        height: root.height/20
        Text{
            width: parent.width
            height: parent.height
            text: qsTr("Easy")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.Wrap
            font.pixelSize: parent.height*0.5
            color: "#FF5722"
        }
        onClicked:
        {
            myView.model=mediator.myModel1
        }
    }
    AndroidButton
    {
        id: mediumScores
        anchors.top: toolbar_game.bottom
        anchors.topMargin: height*0.34
        anchors.left: easyScores.right
        anchors.leftMargin: height*0.34
        width: (parent.width-height*0.34*4)/3
        height: root.height/20
        Text{
            width: parent.width
            height: parent.height
            text: qsTr("Medium")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.Wrap
            font.pixelSize: parent.height*0.5
            color: "#FF5722"
        }
        onClicked:
        {
            myView.model=mediator.myModel2
        }
    }
    AndroidButton
    {
        id: hardScores
        anchors.top: toolbar_game.bottom
        anchors.topMargin: height*0.34
        anchors.right: parent.right
        anchors.rightMargin: height*0.34
        width: (parent.width-height*0.34*4)/3
        height: root.height/20
        Text{
            width: parent.width
            height: parent.height
            text: qsTr("Hard")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.Wrap
            font.pixelSize: parent.height*0.5
            color: "#FF5722"
        }
        onClicked:
        {
            myView.model=mediator.myModel3
        }
    }

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: easyScores.bottom
        width:parent.width
        height:parent.height*3/4
        anchors.margins: 7
        color: "#303030"
        ListView
        {
            id:myView
            width:parent.width
            height:parent.height
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.margins: 7
            /*/
            highlight: Rectangle{
                width: parent.width
                color: "#303030"
            }// */
            model: {
                mediator.myModel1
            }

            delegate: Item{
                width:parent.width
                height:50
                FocusScope {
                    anchors.fill: parent
                    anchors.right: parent.right
                    anchors.left: parent.left

                    Label{
                        width:parent.width* (2/3)
                        id: nameLabel
                        anchors.left:parent.left
                        text:name
                        font.pixelSize: parent.height*0.5
                        color: "#FF5722"
                    }
                    Label{
                        width:(1/3)/3
                        anchors.left:nameLabel.right
                        anchors.right:scoreLabel.left
                        text:"|"
                        font.pixelSize: parent.height*0.5
                        color: "#FF5722"
                    }
                    Label{
                        width:parent.width* ((1/3)-((1/3)/3))
                        id: scoreLabel
                        anchors.right:parent.right
                        text:scoreId
                        font.pixelSize: parent.height*0.5
                        color: "#FF5722"
                    }
                }

                MouseArea
                {
                    anchors.fill: parent
                    onClicked: myView.currentIndex=index
                }
            }
        }
    }
}
