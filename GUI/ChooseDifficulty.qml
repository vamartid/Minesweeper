import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Rectangle {
    id:choice
    height: parent.height
    width: parent.width
    visible: true
    color: "#303030"
    property int rows: 9
    property int columns: 9
    property int mines: 10

    AndroidToolbar
    {
        id: toolbar_difficulty_menu
        BackButton{
        id: backbutton
        onClicked:
            {
                stack.pop();
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
    Text{
        id: logotext
        anchors.top: toolbar_difficulty_menu.bottom
        width: parent.width
        height: parent.height*0.2
        color:"#FFFFFF"
        text: qsTr("Choose a difficulty")
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: height*0.3
        font.family: "droid sans"
        wrapMode: Text.Wrap
    }
    Button
    {
        id: easybutton
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: mediumbutton.top
        anchors.bottomMargin: height*0.14
        width: parent.width/2
        height: parent.height/16
        Text{
            width: parent.width
            height: parent.height
            text: qsTr("Easy")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter + parent.height*0.3
            wrapMode: Text.Wrap
            font.pixelSize: parent.height*0.5
        }
        Text{

            width: parent.width
            height: parent.height
            text: qsTr("9x9 grid with 10 mines")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            wrapMode: Text.Wrap
            font.pixelSize: parent.height*0.3
        }
        onClicked: {
            mineField.initField(choice.columns, choice.rows, choice.mines);
            stack.push(game)
        }
    }

    Button
    {
        id: mediumbutton
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width/2
        height: parent.height/16
        Text{
            width: parent.width
            height: parent.height
            text: qsTr("Medium")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter + parent.height*0.3
            wrapMode: Text.Wrap
            font.pixelSize: parent.height*0.5
        }
        Text{

            width: parent.width
            height: parent.height
            text: qsTr("16x16 grid with 40 mines")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            wrapMode: Text.Wrap
            font.pixelSize: parent.height*0.3
        }

        onClicked: {
            choice.rows= 16
            choice.columns= 16
            choice.mines= 40
            mineField.initField(choice.columns, choice.rows, choice.mines);
            stack.push(game)
        }
    }

    Button
    {
        id: hardbutton
        anchors.top: mediumbutton.bottom
        anchors.topMargin: height*0.14
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width/2
        height: parent.height/16
        Text{
            width: parent.width
            height: parent.height
            text: qsTr("Hard")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter + parent.height*0.3
            wrapMode: Text.Wrap
            font.pixelSize: parent.height*0.5
        }
        Text{

            width: parent.width
            height: parent.height
            text: qsTr("30x16 grid with 99 mines")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            wrapMode: Text.Wrap
            font.pixelSize: parent.height*0.3
        }

        onClicked: {
            choice.rows= 30
            choice.columns= 16
            choice.mines= 99
            mineField.initField(choice.columns, choice.rows, choice.mines);
            stack.push(game)
        }
    }

    Button
    {
        id: custombutton
        anchors.top: hardbutton.bottom
        anchors.topMargin: height*0.14
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width/2
        height: parent.height/16
        onClicked:{
            if(asdf.state == "Visible"){
                 asdf.state = "Invisible"
            }else{
                asdf.state = "Visible"
            }
        }
        Text{
            width: parent.width
            height: parent.height
            text: qsTr("Custom")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter + parent.height*0.3
            wrapMode: Text.Wrap
            font.pixelSize: parent.height*0.5
        }
        Text{

            width: parent.width
            height: parent.height
            text: qsTr("Choose your paremeters below")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            wrapMode: Text.Wrap
            font.pixelSize: parent.height*0.3
        }

    }
    Rectangle{
        id: asdf
        state: "Invisible"
        color: "#303030"
        anchors.top: custombutton.bottom
        anchors.topMargin: parent.height*0.05
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width*0.7
        states: [
            State{
                name: "Visible"
                PropertyChanges{target: asdf; opacity: 1.0}
                PropertyChanges{target: asdf; visible: true}
            },
            State{
                name:"Invisible"
                PropertyChanges{target: asdf; opacity: 0.0}
                PropertyChanges{target: asdf; visible: false}
            }
        ]

        transitions: [
                Transition {
                    from: "Visible"
                    to: "Invisible"

                    SequentialAnimation{
                       NumberAnimation {
                           target: asdf
                           property: "opacity"
                           duration: 500
                           easing.type: Easing.InOutQuad
                       }
                       NumberAnimation {
                           target: asdf
                           property: "visible"
                           duration: 0
                       }
                    }
                },
                Transition {
                    from: "Invisible"
                    to: "Visible"
                    SequentialAnimation{
                       NumberAnimation {
                           target: asdf
                           property: "visible"
                           duration: 0
                       }
                       NumberAnimation {
                           target: asdf
                           property: "opacity"
                           duration: 500
                           easing.type: Easing.InOutQuad
                       }
                    }
                }
            ]
        Text{
            id: fieldwidth
            anchors.top: parent.top
            anchors.left: parent.left
            color: "#FFFFFF"
            text: qsTr("Width: ")
            font.pixelSize: parent.height*0.12
        }

        TextField {
            id: fieldwidth_input
            anchors.top:parent.top
            anchors.left: fieldheight.right
            anchors.right: parent.right
            horizontalAlignment: Text.AlignHCenter
            height: fieldwidth.height
            font.pixelSize: parent.height*0.1
            style: TextFieldStyle {
                textColor: "black"
                background: Rectangle {
                    radius: 2
                    border.color: "#303030"
                    border.width: 3
                }
            }
        }

        Text{
            id: fieldheight
            anchors.top: fieldwidth.bottom
            anchors.left: parent.left
            color: "#FFFFFF"
            text: qsTr("Height: ")
            font.pixelSize: parent.height*0.12
        }

        TextField {
            id: fieldheight_input
            anchors.top: fieldwidth_input.bottom
            anchors.left: fieldheight.right
            anchors.right: parent.right
            horizontalAlignment: Text.AlignHCenter
            height: fieldheight.height
            font.pixelSize: parent.height*0.1
            style: TextFieldStyle {
                textColor: "black"
                background: Rectangle {
                    radius: 2
                    border.color: "#303030"
                    border.width: 3
                }
            }
        }

        Text{
            id: fieldmines
            anchors.top: fieldheight.bottom
            anchors.left: parent.left
            color: "#FFFFFF"
            text: qsTr("Mines: ")
            font.pixelSize: parent.height*0.12
        }

        TextField {
            id: fieldmines_input
            anchors.top: fieldheight_input.bottom
            anchors.left: fieldheight.right
            anchors.right: parent.right
            horizontalAlignment: Text.AlignHCenter
            height: fieldmines.height
            font.pixelSize: parent.height*0.1
            style: TextFieldStyle {
                textColor: "black"
                background: Rectangle {
                    radius: 2
                    border.color: "#303030"
                    border.width: 3
                }
            }
        }
        ToolButton
        {
            Image
            {
                width: parent.width*0.8
                height: parent.height*0.8
                source: "icons/forward-arrow.png"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            Text{
                text: qsTr("Accept")
                color: "#FFFFFF"
                verticalAlignment: Text.AlignBottom
                horizontalAlignment: Text.AlignHCenter
                anchors.fill: parent
                font.pixelSize: parent.height*0.2
            }

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height*0.2
            width: parent.height*0.3
            height:width
            onClicked: {
                choice.rows= fieldheight_input.text
                choice.columns= fieldwidth_input.text
                choice.mines= fieldmines_input.text
                mineField.initField(choice.columns, choice.rows, choice.mines);
                stack.push(game)
            }
        }

    }

    Component{
        id:game
        Game{}
    }



}
