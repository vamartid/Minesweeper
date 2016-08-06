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
    property bool customGame: false

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
            if(customRectangle.state == "Visible"){
                 customRectangle.state = "Invisible"
            }else{
                fieldwidth_input.forceActiveFocus()
                customRectangle.state = "Visible"
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
        id: customRectangle
        state: "Invisible"
        color: "#303030"
        anchors.top: custombutton.bottom
        anchors.topMargin: parent.height*0.05
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width*0.4
        states: [
            State{
                name: "Visible"
                PropertyChanges{target: customRectangle; opacity: 1.0}
                PropertyChanges{target: customRectangle; visible: true}
            },
            State{
                name:"Invisible"
                PropertyChanges{target: customRectangle; opacity: 0.0}
                PropertyChanges{target: customRectangle; visible: false}
            }
        ]

        transitions: [
                Transition {
                    from: "Visible"
                    to: "Invisible"

                    SequentialAnimation{
                       NumberAnimation {
                           target: customRectangle
                           property: "opacity"
                           duration: 500
                           easing.type: Easing.InOutQuad
                       }
                       NumberAnimation {
                           target: customRectangle
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
                           target: customRectangle
                           property: "visible"
                           duration: 0
                       }
                       NumberAnimation {
                           target: customRectangle
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
            height: parent.height*0.14
            color: "#FFFFFF"
            text: qsTr("Width: ")
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: parent.height*0.1
        }

        DarkTextField {
            id: fieldwidth_input
            validator: IntValidator{}
            inputMethodHints: Qt.ImhDigitsOnly
            maximumLength: 2
            anchors.top:parent.top
            anchors.left: fieldheight.right
            anchors.right: parent.right
            horizontalAlignment: Text.AlignHCenter
            height: fieldwidth.height
            font.pixelSize: parent.height*0.1
            onAccepted: acceptButton.acceptCustom()
        }

        Text{
            id: fieldheight
            anchors.top: fieldwidth.bottom
            anchors.left: parent.left
            height: parent.height*0.14
            color: "#FFFFFF"
            text: qsTr("Height: ")
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: parent.height*0.1
        }

        DarkTextField {
            id: fieldheight_input
            validator: IntValidator{}
            inputMethodHints: Qt.ImhDigitsOnly
            maximumLength: 2
            anchors.top: fieldwidth_input.bottom
            anchors.left: fieldheight.right
            anchors.right: parent.right
            horizontalAlignment: Text.AlignHCenter
            height: fieldheight.height
            font.pixelSize: parent.height*0.1
            onAccepted: acceptButton.acceptCustom()
        }

        Text{
            id: fieldmines
            anchors.top: fieldheight.bottom
            anchors.left: parent.left
            height: parent.height*0.14
            color: "#FFFFFF"
            text: qsTr("Mines: ")
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: parent.height*0.1
        }

        DarkTextField {
            id: fieldmines_input
            validator: IntValidator{}
            inputMethodHints: Qt.ImhDigitsOnly
            maximumLength: 4
            anchors.top: fieldheight_input.bottom
            anchors.left: fieldheight.right
            anchors.right: parent.right
            horizontalAlignment: Text.AlignHCenter
            height: fieldmines.height
            font.pixelSize: parent.height*0.1
            onAccepted: acceptButton.acceptCustom()
        }
        ToolButton
        {
            id: acceptButton
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
            function acceptCustom(){
                if(parseInt(fieldwidth_input.text) >= 5 && parseInt(fieldheight_input.text) >= 5){
                    if(parseInt(fieldmines_input.text) <= parseInt(fieldheight_input.text)*parseInt(fieldwidth_input.text) - 9){
                        if(parseInt(fieldmines_input.text) > 0){
                            choice.rows = parseInt(fieldheight_input.text);
                            choice.columns = parseInt(fieldwidth_input.text);
                            choice.mines = parseInt(fieldmines_input.text);
                            mineField.initField(choice.columns, choice.rows, choice.mines);
                            customGame = true;
                            stack.push(game)
                        } else {
                            toast.show("Cannot have less than one mine")
                        }
                    } else {
                        toast.show("Cannot have that many mines!")
                    }
                } else {
                    toast.show("Height and Width have to be at least 5")
                }
            }
            onClicked: {
                acceptCustom();
            }
        }

    }

    Component{
        id:game
        Game{}
    }
}
