import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

Rectangle {
    id: aboutPage
    height: parent.height
    width: parent.width
    visible: true
    color: "#303030"
    AndroidToolbar{
        id: toolbar_about
        BackButton{
            id: backButton_aboutPage
            onClicked:{
                stack.pop()
            }
        }
        Text{
            color: "#FFFFFF"
            text: qsTr("Minesweeper - Qt quick")
            width: parent.width
            anchors.left: backButton_aboutPage.right
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: parent.height*0.37
            wrapMode: Text.Wrap
        }
    }
    ScrollView{
        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
        anchors.top: toolbar_about.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        ColumnLayout{
            spacing: root.height*0.02
            width: aboutPage.width
            Rectangle{
                color: "#303030"
                Layout.preferredHeight: 1
            }
            Text{
                id: about_header
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: aboutPage.width*0.9
                Layout.preferredHeight: aboutPage.height*0.05
                color:"#FFFFFF"
                text: qsTr("How to play:")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: Layout.preferredHeight
                font.family: "droid sans"
                wrapMode: Text.Wrap
            }
            Image{
                source: "icons/screenshot.jpg"
                Layout.preferredWidth: aboutPage.width*0.9
                Layout.alignment: Qt.AlignCenter
                fillMode: Image.PreserveAspectFit
            }
            //reset button description
            Rectangle{
                color: "#303030"
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
                            source: "icons/smiling.png"
                            smooth: true
                        }
                        property int clicks: 0
                        onClicked:{
                            if(clicks === 0){
                                resetButtonImage.source = "icons/sunglasses.png"
                                clicks = 1;
                            } else if (clicks === 1) {
                                resetButtonImage.source = "icons/crying.png"
                                clicks = 2;
                            } else if (clicks === 2){
                                resetButtonImage.source = "icons/smiling.png"
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
                        color: "#FFFFFF"
                        font.family: "droid sans"
                    }
                }
            }
            //flag button description
            Rectangle{
                color: "#303030"
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
                            source: "icons/flag.png"
                            smooth: true
                        }
                        property bool flagClick: true
                        onClicked:{
                            if(flagClick){
                                flagButtonImage.source = "icons/flag-greyed.png"
                                flagClick = false;
                            } else {
                                flagButtonImage.source = "icons/flag.png"
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
                        color: "#FFFFFF"
                        font.family: "droid sans"
                    }
                }
            }
            //second counter description
            Rectangle{
                color: "#303030"
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
                        border.color: "#9e9e9e"
                        border.width: parent.height*0.03
                        radius: 6
                        color: "#303030"
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
                            color: "white"
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
                        color: "#FFFFFF"
                        font.family: "droid sans"
                    }
                }
            }
            //remaining flags description
            Rectangle{
                color: "#303030"
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
                        border.color: "#9e9e9e"
                        border.width: parent.height*0.03
                        radius: 6
                        color: "#303030"
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
                            color: "white"
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
                        color: "#FFFFFF"
                        font.family: "droid sans"
                    }
                }
            }
            //game instructions
            Text{
                Layout.alignment: Qt.AlignCenter
                Layout.preferredHeight: aboutPage.height*0.55
                Layout.preferredWidth: aboutPage.width*0.9
                color:"#FFFFFF"
                text: qsTr("-  The reset button starts a new game.<br><br>
                -  The flag mode button changes your mode from reveal mode to flag mode.<br><br>
                -  In reveal mode, left click reveals blocks and right click / left hold flags a block.<br><br>
                -  Clicking the seconds timer will change it to display the number of moves you have made.<br><br>
                -  In flag mode, left click flags blocks and right click/ left hold reveals a block.<br><br>
                -  A block's number represents the amount of mines in neighbouring blocks.<br><br>
                -  Double clicking a block, which has as many neighbouring flagged blocks as its number, will reveal the rest of its neighbouring blocks.")
                horizontalAlignment: Text.AlignJustify
                font.pixelSize: Layout.preferredHeight*0.045
                font.family: "droid sans"
                wrapMode: Text.Wrap
            }
            Text{
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: aboutPage.width*0.9
                Layout.preferredHeight: aboutPage.height*0.05
                color:"#FFFFFF"
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
                Layout.preferredHeight: aboutPage.height*0.3
                Layout.preferredWidth: aboutPage.width*0.9
                color:"#FFFFFF"
                text: qsTr("This program was created for a project in a mobile development course, in the Aristotle University of Thessaloniki.<br><br>
                It is licensed under GNU GPL v3 and the code is available  <a href=\"http://i.imgur.com/27nLhLy.gif\">on github</a>.<br><br>
                The main contributors are:
                <br>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"https://github.com/vamartid\">vamartid</a> - Vasilis Martidis<br>
                &nbsp;&nbsp;&nbsp;&nbsp;<a href=\"https://github.com/rigopoui\">rigopoui</a> - Yanis Rigopoulos<br>
                &nbsp;&nbsp;&nbsp;&nbsp;<a href=\"https://github.com/GeorgeKirm\">GeorgeKirm</a> - Giorgos Kirmitsakis")
                linkColor: "#3b85b0"
                horizontalAlignment: Text.AlignJustify
                font.pixelSize: Layout.preferredHeight*0.08
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
                //visible:false
                Layout.alignment: Qt.AlignCenter
                width: parent.width*0.9
                color: "#FFFFFF"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: root.height*0.0186
                text: qsTr("Aristotle University of Thessaloniki - 2016")
            }
        }
    }
}
