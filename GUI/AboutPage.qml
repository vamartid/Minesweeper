import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import "qrc:/Styles/" 1.0

Rectangle {
    id: aboutPage
    height: parent.height
    width: parent.width
    visible: true
    color: Style.color.background
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
    Keys.onPressed: {
        if(event.key === Qt.Key_Down || event.key === Qt.Key_S){
            flickArea.flick(0,-500);
        }
        else if(event.key === Qt.Key_Up|| event.key === Qt.Key_W){
            flickArea.flick(0,500);
        }
    }
    AndroidToolbar{
        id: toolbar_about
        BackButton{
            id: backButton_aboutPage
            onClicked:{
                back();
            }
        }
        Text{
            color: Style.color.text_On_Bar
            text: qsTr("Minesweeper - Qt quick")
            width: parent.width
            anchors.left: backButton_aboutPage.right
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: parent.height*0.37
            wrapMode: Text.Wrap
        }
        z: 10
    }
    Rectangle {
        anchors.top: toolbar_about.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: Style.color.background
        z: 0
        Flickable{
            //horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
            id: flickArea
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            boundsBehavior: Flickable.StopAtBounds
            contentHeight: collumnId.height
            contentWidth: aboutPage.width
            clip: true
            focus: true

            ColumnLayout{
                id: collumnId
                spacing: root.height*0.02
                width: aboutPage.width
                Rectangle{
                    id: firstRect
                    color: Style.color.background
                    Layout.preferredHeight: 1
                }
                Text{
                    id: about_header
                    Layout.alignment: Qt.AlignCenter
                    Layout.preferredWidth: aboutPage.width*0.9
                    Layout.preferredHeight: aboutPage.height*0.05
                    color: Style.color.text
                    text: qsTr("How to play:")
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: Layout.preferredHeight
                    font.family: "droid sans"
                    wrapMode: Text.Wrap
                }
                Image{
                    id: screenshot
                    source: Style.icons.screenshot
                    Layout.preferredWidth: aboutPage.width*0.9
                    Layout.preferredHeight: aboutPage.width*0.9
                    Layout.alignment: Qt.AlignCenter
                    Layout.maximumWidth: implicitWidth
                    Layout.maximumHeight: implicitHeight
                    fillMode: Image.PreserveAspectFit
                }
                //reset button description
                Rectangle{
                    id : secondRectangle
                    color: Style.color.background
                    Layout.alignment: Qt.AlignCenter
                    Layout.preferredWidth: aboutPage.width*0.9
                    Layout.preferredHeight: aboutPage.height*0.2/3
                    Rectangle{
                        color: parent.color
                        width: parent.width
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: parent.height
                        AndroidButton{
                            id: resetReference
                            anchors.right: parent.horizontalCenter
                            anchors.rightMargin: resetDescription.width*0.7
                            height: parent.height
                            width: height
                            Image {
                                id: resetButtonImage
                                anchors.margins: parent.height*0.1
                                anchors.fill: parent
                                source: Style.icons.smile
                                smooth: true
                            }
                            property int clicks: 0
                            onClicked:{
                                if(clicks === 0){
                                    resetButtonImage.source = Style.icons.sunglasses
                                    clicks = 1;
                                } else if (clicks === 1) {
                                    resetButtonImage.source = Style.icons.dazed
                                    clicks = 2;
                                } else if (clicks === 2){
                                    resetButtonImage.source = Style.icons.smile
                                    clicks = 0;
                                }
                            }
                        }
                        Text{
                            id: resetDescription
                            anchors.left: resetReference.right
                            anchors.leftMargin: aboutPage.width*0.05
                            height: parent.height
                            text: "The reset button"
                            font.pixelSize: parent.height*0.5
                            horizontalAlignment: Text.AlignJustify
                            verticalAlignment: Text.AlignVCenter
                            color: Style.color.text
                            font.family: "droid sans"
                        }
                    }
                }
                //flag button description
                Rectangle{
                    id: thirdRectungle
                    color: Style.color.background
                    Layout.alignment: Qt.AlignCenter
                    Layout.preferredWidth: aboutPage.width*0.9
                    Layout.preferredHeight: aboutPage.height*0.2/3
                    Rectangle{
                        color: parent.color
                        width: parent.width
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: parent.height
                        AndroidButton{
                            id: flagReference
                            anchors.right: parent.horizontalCenter
                            anchors.rightMargin: resetDescription.width*0.7
                            height: parent.height
                            width: height
                            //anchors.margins: width*0.05
                            Image {
                                id: flagButtonImage
                                anchors.margins: parent.height*0.1
                                anchors.fill: parent
                                source: Style.icons.flag
                                smooth: true
                            }
                            property bool flagClick: true
                            onClicked:{
                                if(flagClick){
                                    flagButtonImage.source = Style.icons.flag_greyed
                                    flagClick = false;
                                } else {
                                    flagButtonImage.source = Style.icons.flag
                                    flagClick = true;
                                }
                            }
                        }
                        Text{
                            anchors.left: flagReference.right
                            anchors.leftMargin: aboutPage.width*0.05
                            height: parent.height
                            text: "The flag mode button"
                            font.pixelSize: parent.height*0.5
                            horizontalAlignment: Text.AlignJustify
                            verticalAlignment: Text.AlignVCenter
                            color: Style.color.text
                            font.family: "droid sans"
                        }
                    }
                }
                //second counter description
                Rectangle{
                    id: fourthRectungle
                    color: Style.color.background
                    Layout.alignment: Qt.AlignCenter
                    Layout.preferredWidth: aboutPage.width*0.9
                    Layout.preferredHeight: aboutPage.height*0.2/3
                    Rectangle{
                        color: parent.color
                        width: parent.width
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: parent.height
                        Rectangle{
                            id: secCounterReference
                            border.color: Style.color.aboutPage_Rect_Border
                            border.width: parent.height*0.03
                            radius: 6
                            color: Style.color.background
                            anchors.right: parent.horizontalCenter
                            anchors.rightMargin: resetDescription.width*0.7
                            anchors.verticalCenter: parent.verticalCenter
                            height: parent.height*0.7
                            width: parent.height
                            property bool timer: true
                            Text{
                                id: secCounterReferenceText
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pixelSize: height*0.7
                                text: sampleSecondCounter.seconds
                                color: Style.color.text
                                font.family: "droid-sans-mono"
                            }
                            MouseArea{
                                //id: timerReferenceArea
                                anchors.fill: parent
                                acceptedButtons: Qt.LeftButton
                                onClicked:{
                                    if(secCounterReference.timer){
                                        secCounterReferenceText.text = "4"
                                        secCounterReference.timer = false;
                                    } else {
                                        secCounterReferenceText.text = Qt.binding(function() { return sampleSecondCounter.seconds})
                                        secCounterReference.timer = true;
                                    }
                                }
                            }
                        }
                        SecondCounter{
                            id: sampleSecondCounter
                            running: true
                            seconds: 15
                        }

                        Text{
                            anchors.left: secCounterReference.right
                            anchors.leftMargin: aboutPage.width*0.05
                            height: parent.height
                            text: "The seconds timer"
                            font.pixelSize: parent.height*0.5
                            horizontalAlignment: Text.AlignJustify
                            verticalAlignment: Text.AlignVCenter
                            color: Style.color.text
                            font.family: "droid sans"
                        }
                    }
                }
                //remaining flags description
                Rectangle{
                    id: fifthRectungle
                    color: Style.color.background
                    Layout.alignment: Qt.AlignCenter
                    Layout.preferredWidth: aboutPage.width*0.9
                    Layout.preferredHeight: aboutPage.height*0.2/3
                    Rectangle{
                        color: parent.color
                        width: parent.width
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: parent.height
                        Rectangle{
                            id: remFlagsReferrence
                            border.color: Style.color.aboutPage_Rect_Border
                            border.width: parent.height*0.03
                            radius: 6
                            color: Style.color.background
                            anchors.right: parent.horizontalCenter
                            anchors.rightMargin: resetDescription.width*0.7
                            anchors.verticalCenter: parent.verticalCenter
                            height: parent.height*0.7
                            width: parent.height
                            Text{
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pixelSize: height*0.7
                                text: "7"
                                color: Style.color.text
                                font.family: "droid-sans-mono"
                            }
                        }
                        Text{
                            anchors.left: remFlagsReferrence.right
                            anchors.leftMargin: aboutPage.width*0.05
                            height: parent.height
                            text: "The remaining flags"
                            font.pixelSize: parent.height*0.5
                            horizontalAlignment: Text.AlignJustify
                            verticalAlignment: Text.AlignVCenter
                            color: Style.color.text
                            font.family: "droid sans"
                        }
                    }
                }
                //game instructions
                Text{
                    id: instructionText
                    Layout.alignment: Qt.AlignCenter
                    Layout.preferredHeight: contentHeight
                    Layout.preferredWidth: aboutPage.width*0.9
                    color: Style.color.text
                    text: qsTr("-  The reset button starts a new game.<br><br>
                    -  The flag mode button changes your mode from reveal mode to flag mode.<br><br>
                    -  In reveal mode, left click reveals blocks and right click / left hold flags a block.<br><br>
                    -  In flag mode, left click flags blocks and right click/ left hold reveals a block.<br><br>
                    -  A block's number represents the amount of mines in neighbouring blocks.<br><br>
                    -  Double clicking a block, which has as many neighbouring flagged blocks as its number, will reveal the rest of its neighbouring blocks.<br><br>
                    -  Clicking the seconds timer will change it to display the number of moves you have made.")
                    horizontalAlignment: Text.AlignJustify
                    font.pixelSize: aboutPage.height*0.025
                    font.family: "droid sans"
                    wrapMode: Text.Wrap
                }
                Text{
                    id:aboutT
                    Layout.alignment: Qt.AlignCenter
                    Layout.preferredWidth: aboutPage.width*0.9
                    Layout.preferredHeight: aboutPage.height*0.05
                    color: Style.color.text
                    text: qsTr("About this program:")
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: Layout.preferredHeight
                    font.family: "droid sans"
                    wrapMode: Text.Wrap
                }
                Text{
                    id: about_body
                    Layout.alignment: Qt.AlignCenter
                    Layout.preferredHeight: contentHeight
                    Layout.preferredWidth: aboutPage.width*0.9
                    color: Style.color.text
                    text: qsTr("This program was created for a project in a mobile development course, in the Aristotle University of Thessaloniki.<br><br>
                    It is licensed under <a href=\"https://www.gnu.org/licenses/gpl.html\">GNU GPL v3</a> and the code is available  <a href=\"http://i.imgur.com/27nLhLy.gif\">on github</a>.<br><br>
                    The main contributors are:
                    <br>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"https://github.com/vamartid\">vamartid</a> - Vasilis Martidis<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;<a href=\"https://github.com/rigopoui\">rigopoui</a> - Yanis Rigopoulos<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;<a href=\"https://github.com/GeorgeKirm\">GeorgeKirm</a> - Giorgos Kirmitsakis<br><br>
                    The emojis used in the game are modified versions of <a href=\"http://emojione.com\">EmojiOne</a>, licensed under <a href=\"https://creativecommons.org/licenses/by/4.0\">Creative Commons BY 4.0</a>")
                    linkColor: Style.color.text_Link
                    horizontalAlignment: Text.AlignJustify
                    font.pixelSize: aboutPage.height*0.025
                    font.family: "droid sans"
                    wrapMode: Text.Wrap
                    onLinkActivated: Qt.openUrlExternally(link)
                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.NoButton // we don't want to eat clicks on the Text
                        cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                    }
                }
                Text{
                    id: downT
                    //visible:false
                    Layout.alignment: Qt.AlignCenter
                    width: parent.width*0.9
                    color: Style.color.text_Epiloge
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: root.height*0.0186
                    text: qsTr("Aristotle University of Thessaloniki - 2016")
                }
            }
        }
    }
}
