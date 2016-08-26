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
    property int difficulty: 0
    property bool customGame: false
    Keys.enabled: true
    focus: true
    Component.onCompleted: {
        forceActiveFocus()
    }
    Keys.onReleased: {
        if(event.key === Qt.Key_Back){
            event.accepted = true;
            back();
        }
    }
    AndroidToolbar
    {
        id: toolbar_difficulty_menu
        BackButton{
            id: backbutton_choice
            onClicked:
            {
                back();
            }
        }
        Text{
            color: "#FFFFFF"
            text: qsTr("Minesweeper - Qt quick")
            width: parent.width
            anchors.left: backbutton_choice.right
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: parent.height*0.37
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
        font.pixelSize: height*0.3
        font.family: "droid sans"
        wrapMode: Text.Wrap
    }
    Rectangle{
        id: choiceButtonsRect
        color: parent.color
        width:parent.width/1.5
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: parent.height*0.20
        //Difficulty choice buttons
        AndroidButton
        {
            id: easybutton
            anchors.top: parent.top
            width: parent.width
            height: root.height/10
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
                height: parent.height*0.95
                text: qsTr("9x9 grid with 10 mines")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignBottom
                wrapMode: Text.Wrap
                font.pixelSize: parent.height*0.25
            }
            onClicked: {
                choice.difficulty= 1
                mineField.initField(choice.columns, choice.rows, choice.mines);
                stack.push(game)
            }
        }

        AndroidButton
        {
            id: mediumbutton
            anchors.top: easybutton.bottom
            anchors.topMargin: height*0.14
            width: parent.width
            height: root.height/10
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
                height: parent.height*0.95
                text: qsTr("16x16 grid with 40 mines")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignBottom
                wrapMode: Text.Wrap
                font.pixelSize: parent.height*0.25
            }

            onClicked: {
                choice.rows= 16
                choice.columns= 16
                choice.mines= 40
                choice.difficulty= 2
                mineField.initField(choice.columns, choice.rows, choice.mines);
                stack.push(game)
            }
        }

        AndroidButton
        {
            id: hardbutton
            anchors.top: mediumbutton.bottom
            anchors.topMargin: height*0.14
            width: parent.width
            height: root.height/10
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
                height: parent.height*0.95
                text: qsTr("30x16 grid with 99 mines")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignBottom
                wrapMode: Text.Wrap
                font.pixelSize: parent.height*0.25
            }

            onClicked: {
                choice.rows= 30
                choice.columns= 16
                choice.mines= 99
                choice.difficulty= 3
                mineField.initField(choice.columns, choice.rows, choice.mines);
                stack.push(game)
            }
        }

        AndroidButton
        {
            id: custombutton
            anchors.top: hardbutton.bottom
            anchors.topMargin: height*0.14
            width: parent.width
            height: root.height/10
            onClicked:{
                if(customRectangle.state == "Visible"){
                    customRectangle.state = "Invisible"
                    choice.forceActiveFocus()
                }else{
                    customRectangle.state = "Visible"
                    fieldwidth_input.forceActiveFocus()
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
                height: parent.height*0.95
                text: qsTr("Choose your paremeters below")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignBottom
                wrapMode: Text.Wrap
                font.pixelSize: parent.height*0.25
            }

        }

    Rectangle{
        id: customRectangle
        state: "Invisible"
        color: "#303030"
        anchors.top: custombutton.bottom
        anchors.topMargin: parent.height*0.02
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width*0.65
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
            maximumLength: 3
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
                soundMngr.playSound();
                acceptCustom();
            }
        }

    }
    }

    Component{
        id:game
        Game{}
    }
}
