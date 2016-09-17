import QtQuick 2.5
import QtQuick.Controls 1.4
import "qrc:/Styles/" 1.0

Rectangle {
    id: settingsPage
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
    property double volumeS: 0.0
    property double volumeM: 0.0
    property bool temp: false

    AndroidToolbar{
        id: toolbar_settings
        BackButton{
            id: backButton_settingsPage
            onClicked:{
                back();
            }
        }
        Text{
            color: Style.color.text_On_Bar
            text: qsTr("Minesweeper - Qt quick")
            width: parent.width
            anchors.left: backButton_settingsPage.right
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: parent.height*0.37
            wrapMode: Text.Wrap
        }
    }
    Text{
        id: settings_header
        anchors.top: toolbar_settings.bottom
        width: parent.width
        height: parent.height*0.1
        color: Style.color.text
        text: qsTr("Settings")
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: height*0.5
        font.family: "droid sans"
        wrapMode: Text.Wrap
    }
    Text{
        id: musicText
        anchors.top: settings_header.bottom
        width: parent.width
        height: root.height/13
        color:Style.color.text
        text: qsTr("Music:")
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: height*0.5
        font.family: "droid sans"
        wrapMode: Text.Wrap
    }
    AndroidSlider{
        id: musicSlider
        anchors.top: musicText.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width-parent.width/3
        height: parent.height*0.06
        value: 0.0
        maximumValue: 100.0
        minimumValue : 0.0
        stepSize: 1.0
        updateValueWhileDragging : true

        onValueChanged: {
            musicMngr.setSoundVolume(value)
        }
    }
    Text{
        id: soundsText
        anchors.top: musicSlider.bottom
        width: parent.width
        height: root.height/13
        color:Style.color.text
        text: qsTr("Sounds:")
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: height*0.5
        font.family: "droid sans"
        wrapMode: Text.Wrap
    }
    AndroidSlider{
        id: soundsSlider
        anchors.top: soundsText.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width-parent.width/3
        height: parent.height*0.06
        value: 50.0
        maximumValue: 100.0
        minimumValue : 0.0
        stepSize: 1.0
        updateValueWhileDragging : true

        onValueChanged: {
            soundMngr.setSoundVolume(value)
            sound2Mngr.setSoundVolume(value)
            sound3Mngr.setSoundVolume(value)
        }
    }
    AndroidButton{
        id: mute
        anchors.top: soundsSlider.bottom
        anchors.topMargin: height*0.34
        anchors.left: parent.left
        anchors.leftMargin: height*0.34
        width: parent.width/3.5
        height: root.height/16
        Text{
            color: Style.color.android_Button_Text
            width: parent.width
            height: parent.height
            text: qsTr("Mute")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.Wrap
            font.pixelSize: parent.height*0.5
        }
        onClicked:
        {
            muteBtn();
        }
    }
    AndroidButton{
        id: max
        anchors.top: soundsSlider.bottom
        anchors.topMargin: height*0.34
        anchors.left: mute.right
        anchors.leftMargin: height*0.34
        width: parent.width/3.5
        height: root.height/16
        Text{
            color: Style.color.android_Button_Text
            width: parent.width
            height: parent.height
            text: qsTr("Max")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.Wrap
            font.pixelSize: parent.height*0.5
        }
        onClicked:
        {
            maxBtn();
        }
    }
    AndroidButton{
        id: defaults
        anchors.top: soundsSlider.bottom
        anchors.topMargin: height*0.34
        anchors.right: parent.right
        anchors.rightMargin: height*0.34
        width: parent.width/3.5
        height: root.height/16
        Text{
            color: Style.color.android_Button_Text
            width: parent.width
            height: parent.height
            text: qsTr("Defaults")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.Wrap
            font.pixelSize: parent.height*0.5
        }
        onClicked:
        {
            defaultsBtn();
        }
    }
    AndroidButton {
        id: clearScores
        anchors.top: max.bottom
        anchors.topMargin: height*0.34
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width/2.6
        height: root.height/16
        Text{
            color: Style.color.android_Button_Text
            width: parent.width
            height: parent.height
            text: qsTr("Clear Scores")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.Wrap
            font.pixelSize: parent.height*0.5
        }
        onClicked:
        {
            clearScoreCheck.visible= true
        }
    }
    
    Text{
        id: signature
        //visible:false
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width*0.9
        color: Style.color.text_Epiloge
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: parent.height*0.0186
        text: qsTr("Aristotle University of Thessaloniki - 2016")
    }

    ClearScoreCheck{
        id: clearScoreCheck
        visible: false
        onVisibleChanged: {
            if(visible == true){
                musicSlider.enabled = false;
                soundsSlider.enabled = false;
                mute.enabled = false;
                max.enabled = false;
                defaults.enabled = false;
                clearScores.enabled = false;
                forceActiveFocus();
            } else {
                musicSlider.enabled = true;
                soundsSlider.enabled = true;
                mute.enabled = true;
                max.enabled = true;
                defaults.enabled = true;
                clearScores.enabled = true;
                settingsPage.forceActiveFocus();
            }
        }
    }
    
    function muteBtn(){
        /*silenceModeS=true
        silenceModeM=true*/
        if((musicMngr.getMuteSound())&&(soundMngr.getMuteSound())){
            musicMngr.muteSound(false);
            soundMngr.muteSound(false);
            sound2Mngr.muteSound(false);
            sound3Mngr.muteSound(false);
            if((musicSlider.value==0.0)&&(soundsSlider.value==0.0)){
                musicSlider.value=volumeM
                soundsSlider.value=volumeS
                temp=false
            }
        }else{
            musicMngr.muteSound(true);
            soundMngr.muteSound(true);
            sound2Mngr.muteSound(true);
            sound3Mngr.muteSound(true);
            volumeM=musicSlider.value
            volumeS=soundsSlider.value
            musicSlider.value=0.0
            soundsSlider.value=0.0
        }
    }

    function maxBtn(){
        if(musicMngr.getMuteSound()){
            musicMngr.muteSound(false);
            soundMngr.muteSound(false);
            sound2Mngr.muteSound(false);
            sound3Mngr.muteSound(false);
            temp=true
        }

        if((musicSlider.value==100.0)&&(soundsSlider.value==100.0)){
            if(temp){
                musicMngr.muteSound(true);
                soundMngr.muteSound(true);
                sound2Mngr.muteSound(true);
                sound3Mngr.muteSound(true);
                musicSlider.value=0.0
                soundsSlider.value=0.0
            }else{
                musicSlider.value=volumeM
                soundsSlider.value=volumeS
            }
        }else{
            if(!temp){
                volumeM=musicSlider.value
                volumeS=soundsSlider.value
            }
            musicSlider.value=100.0
            soundsSlider.value=100.0
        }
    }

    function defaultsBtn(){
        if(musicMngr.getMuteSound()){
            musicMngr.muteSound(false);
            soundMngr.muteSound(false);
            sound2Mngr.muteSound(false);
            sound3Mngr.muteSound(false);
            temp=true
        }

        if((musicSlider.value==50.0)&&(soundsSlider.value==50.0)){
            if(temp){
                musicMngr.muteSound(true);
                soundMngr.muteSound(true);
                sound2Mngr.muteSound(true);
                sound3Mngr.muteSound(true);
                musicSlider.value=0.0
                soundsSlider.value=0.0
            }else{
                musicSlider.value=volumeM
                soundsSlider.value=volumeS
            }
        }else{
            if(!temp){
                volumeM=musicSlider.value
                volumeS=soundsSlider.value
            }
            musicSlider.value=0.0
            soundsSlider.value=50.0
        }
    }
}
