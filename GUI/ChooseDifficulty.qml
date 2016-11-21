import QtQuick 2.5
import QtQuick.Controls 1.4
import "qrc:/Styles/" 1.0

Rectangle {
    id:choice
    height: parent.height
    width: parent.width
    visible: true
    color: Style.color.background
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
            color: Style.color.text_On_Bar
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
        color: Style.color.text
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
                color: Style.color.android_Button_Text
                width: parent.width
                height: parent.height
                text: qsTr("Easy")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter + parent.height*0.3
                wrapMode: Text.Wrap
                font.pixelSize: parent.height*0.5
            }
            Text{
                color: Style.color.android_Button_Text
                width: parent.width
                height: parent.height*0.95
                text: qsTr("9x9 grid with 10 mines")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignBottom
                wrapMode: Text.Wrap
                font.pixelSize: parent.height*0.25
            }
            onClicked: {
                disableViewAddItems();
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
                color: Style.color.android_Button_Text
                width: parent.width
                height: parent.height
                text: qsTr("Medium")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter + parent.height*0.3
                wrapMode: Text.Wrap
                font.pixelSize: parent.height*0.5
            }
            Text{
                color: Style.color.android_Button_Text
                width: parent.width
                height: parent.height*0.95
                text: qsTr("16x16 grid with 40 mines")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignBottom
                wrapMode: Text.Wrap
                font.pixelSize: parent.height*0.25
            }

            onClicked: {
                disableViewAddItems();
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
                color: Style.color.android_Button_Text
                width: parent.width
                height: parent.height
                text: qsTr("Hard")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter + parent.height*0.3
                wrapMode: Text.Wrap
                font.pixelSize: parent.height*0.5
            }
            Text{
                color: Style.color.android_Button_Text
                width: parent.width
                height: parent.height*0.95
                text: root.height > root.width ? qsTr("16x30 grid with 99 mines") : qsTr("30x16 grid with 99 mines")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignBottom
                wrapMode: Text.Wrap
                font.pixelSize: parent.height*0.25
            }

            onClicked: {
                disableViewAddItems();
                if(root.height > root.width){
                    choice.rows= 30
                    choice.columns= 16
                } else {
                    choice.rows= 16
                    choice.columns= 30
                }
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
                }else{
                    customRectangle.state = "Visible"
                }
            }
            Text{
                color: Style.color.android_Button_Text
                width: parent.width
                height: parent.height
                text: qsTr("Custom")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter + parent.height*0.3
                wrapMode: Text.Wrap
                font.pixelSize: parent.height*0.5
            }
            Text{
                color: Style.color.android_Button_Text
                width: parent.width
                height: parent.height*0.95
                text: qsTr("Press to choose parameters")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignBottom
                wrapMode: Text.Wrap
                font.pixelSize: parent.height*0.25
            }

        }

        Rectangle{
            id: customRectangle
            state: "Invisible"
            color: Style.color.background
            anchors.top: custombutton.bottom
            anchors.topMargin: parent.height*0.02
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width*1.3
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
                               duration: 200
                               easing.type: Easing.OutQuad
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
                               duration: 200
                               easing.type: Easing.InQuad
                           }
                        }
                    }
                ]
            Text{
                id: fieldwidth
                anchors.top: parent.top
                anchors.left: parent.left
                height: parent.height*0.17
                color: Style.color.text
                text: qsTr("Width:")
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height*0.1/0.14
            }

            Text{
                id: fieldwidth_number
                anchors.top: parent.top
                anchors.left: fieldheight.right
                height: fieldwidth.height
                width: root.width*0.14
                color: Style.color.text
                text: Math.floor(widthSlider.value)
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: parent.height*0.1
            }

            AndroidSlider{
                id: widthSlider
                anchors.top: parent.top.bottom
                anchors.left: fieldwidth_number.right
                anchors.right: parent.right
                height: fieldwidth.height
                value: 5
                maximumValue: 50
                minimumValue : 5
                updateValueWhileDragging : true
                onValueChanged: {
                    parent.changeMineMax()
                }
            }
            Text{
                id: fieldheight
                anchors.top: fieldwidth.bottom
                anchors.left: parent.left
                height: fieldwidth.height
                color: Style.color.text
                text: qsTr("Height:")
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: parent.height*0.1
            }

            Text{
                id: fieldheight_number
                anchors.top: fieldwidth_number.bottom
                anchors.left: fieldheight.right
                height: fieldwidth.height
                width: root.width*0.14
                color: Style.color.text
                text: Math.floor(heightSlider.value)
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: parent.height*0.1
            }

            AndroidSlider{
                id: heightSlider
                anchors.top: widthSlider.bottom
                anchors.left: fieldheight_number.right
                anchors.right: parent.right
                height: fieldwidth.height
                value: 5
                maximumValue: 50
                minimumValue : 5
                updateValueWhileDragging : true

                onValueChanged: {
                    parent.changeMineMax()
                }
            }

            Text{
                id: fieldmines
                anchors.top: fieldheight.bottom
                anchors.left: parent.left
                height: fieldwidth.height
                color: Style.color.text
                text: qsTr("Mines:")
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: parent.height*0.1
            }

            Text{
                id: fieldmines_number
                anchors.top: fieldheight_number.bottom
                anchors.left: fieldheight.right
                height: fieldwidth.height
                width: root.width*0.14
                color: Style.color.text
                text: Math.floor(minesSlider.value)
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: parent.height*0.1
            }

            AndroidSlider{
                property int oldMaxValue: 8
                id: minesSlider
                anchors.top: heightSlider.bottom
                anchors.left: fieldmines_number.right
                anchors.right: parent.right
                height: fieldwidth.height
                value: 1
                maximumValue: 8
                minimumValue : 1
                updateValueWhileDragging : true
            }


            ToolButton
            {
                id: acceptButton
                Image
                {
                    id: acceptImage
                    width: parent.width*0.8
                    height: parent.height*0.8
                    source: Style.icons.f_arrow
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                }
                Text{
                    text: qsTr("Accept")
                    color: Style.color.text
                    horizontalAlignment: Text.AlignHCenter
                    anchors.left: acceptImage.left
                    anchors.right: acceptImage.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: parent.height*0.07
                    font.pixelSize: parent.height*0.2
                }

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: parent.height*0.1
                width: parent.height*0.4
                height:width

                onClicked: {
                    soundMngr.playSound();
                    disableViewAddItems();
                    choice.rows = Math.floor(parseInt(heightSlider.value));
                    choice.columns = Math.floor(parseInt(widthSlider.value));
                    choice.mines = Math.floor(parseInt(minesSlider.value));
                    mineField.initField(choice.columns, choice.rows, choice.mines);
                    if(choice.rows === 9 && choice.columns === 9 && choice.mines === 10){
                        difficulty = 1;
                    } else if(choice.rows === 16 && choice.columns === 16 && choice.mines === 40){
                        difficulty = 2;
                    } else if(((choice.rows === 30 && choice.columns === 16) || (choice.rows === 16 && choice.columns === 30)) && choice.mines === 99){
                        difficulty = 3;
                    } else{
                        customGame = true;
                    }
                    stack.push(game)
                }
            }
            function changeMineMax(){
                var tempMax = Math.floor((widthSlider.value*heightSlider.value - 9)/2);
                minesSlider.oldMaxValue = minesSlider.maximumValue;
                if(tempMax>999){
                    minesSlider.maximumValue = 999;
                } else {
                    minesSlider.maximumValue = tempMax;
                }
                minesSlider.value = minesSlider.value*(minesSlider.maximumValue/minesSlider.oldMaxValue);
            }
        }
    }
    function disableViewAddItems(){
        choice.enabled = false;
    }
    Component{
        id:game
        Game{}
    }
}
