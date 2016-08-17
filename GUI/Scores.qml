import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2

Rectangle {
    property bool easyFlag: true
    property bool mediumFlag: false
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
            easyFlag: true
            mediumFlag: false

      //      easyFlag: 0
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
            easyFlag: false
            mediumFlag: true
       //     MainMenu.homePageOfDificultyInHichScores == 1
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
            easyFlag: false
            mediumFlag: false
         //   MainMenu.homePageOfDificultyInHichScores == 2
        }
    }
    Row
    {
        anchors.bottom: parent.bottom
        id:myrow
        width:parent.width
        Button
        {
            id:myButton
            text:"add"
            onClicked: {
                if (easyFlag) {
                    mediator.insertScore(babis.text+" "+3, 3, 0);
                } else if (mediumFlag){
                    mediator.insertScore(babis.text+" "+3, 10, 1);
                } else {
                    mediator.insertScore(babis.text+" "+3, 3, 2);
                }
            }
        }
        Button
        {
            id:myButton2
            text:"delete"
            onClicked:  {
                if (easyFlag) {
                    mediator.deleteScore(myView.currentIndex, 0);
                } else if (mediumFlag){
                    mediator.deleteScore(myView.currentIndex, 1);
                } else {
                    mediator.deleteScore(myView.currentIndex, 2);
                }
            }
        }
        TextField
        {
            id:babis
        }
    }

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: easyScores.bottom
        anchors.bottom: myrow.top
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
            anchors.margins: 7
            /*/
            highlight: Rectangle{
                width: parent.width
                color: "#303030"
            }// */
            model: {
                //
                if (easyFlag) {
                    mediator.myModel1
                } else if (mediumFlag){
                    mediator.myModel2
                } else {
                    mediator.myModel3
                }// */
            }

            delegate: Item{
                width:parent.width
                height:50

                Row
                {
                    anchors.fill: parent
                    Label{
                        id: nameLabel
                        anchors.left:parent.left
                        width:parent.width*4/5
                        text:name
                        font.pixelSize: parent.height*0.5
                        color: "#FF5722"
                    }
                    Label{
                        anchors.left:nameLabel.right
                        anchors.right:scoreLabel.left
                        text:"|"
                        font.pixelSize: parent.height*0.5
                        color: "#FF5722"
                    }
                    Label{
                        id: scoreLabel
                        anchors.right:parent.right
                        width:parent.width/5
                        text:score
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
