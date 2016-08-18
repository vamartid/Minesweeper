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
    AndroidButton {
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
    AndroidButton {
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
    AndroidButton {
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

    FocusScope {
        id:labelsForList
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: easyScores.bottom
        height: root.height/18
        anchors.leftMargin: 13
        anchors.topMargin: 10
        anchors.rightMargin: 13
        Label {
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            width:parent.width* (2/4)
            anchors.left:parent.left
            text:"Name"
            font.pixelSize: parent.height*0.7
            color: "#FFFFFF"
            //color: "#FF5722"
            font.family: "droid sans mono"
            height: root.height/13
            //font.bold : true
            //font.family: "droid sans"
        }//wrapMode: Text.Wrap
        Label {
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            width:parent.width* (1/3)
            anchors.right:parent.right
            text:"Time"
            font.pixelSize: parent.height*0.7
            color: "#FFFFFF"
            font.family: "droid sans mono"
            height: root.height/13
            //font.bold : true
            //font.family: "droid sans"
        }
    }
    Rectangle {
        id:spliter
        anchors.top: labelsForList.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: root.height/25
        color: "#303030"
    }
    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: spliter.bottom
        width:parent.width
        height:parent.height*3/4
        anchors.leftMargin: 13
        anchors.bottomMargin: 7
        anchors.rightMargin: 13
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
                id : item
                width:parent.width
                height:40

                FocusScope {
                    anchors.fill: parent
                    anchors.right: parent.right
                    anchors.left: parent.left

                    Label{
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment:  Text.AlignHCenter
                        font.family: "droid sans"
                        width:parent.width* (2/4)
                        id: nameLabel
                        anchors.left:parent.left
                        text:name
                        font.pixelSize: parent.height*0.625
                        color: "#FF5722"
                    }
                    Label{
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment:  Text.AlignHCenter
                        font.family: "droid sans"
                        width:parent.width* (1/3)
                        id: scoreLabel
                        anchors.right:parent.right
                        text:scoreId
                        font.pixelSize: parent.height*0.625
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
