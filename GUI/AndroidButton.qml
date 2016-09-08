import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Button
{
    id: androidButton
    style: ButtonStyle{
        background: Rectangle {
            border.width: control.activeFocus ? 2 : 1
            border.color: "#888"
            gradient: Gradient {
                GradientStop { position: 0 ; color: control.pressed ? "#e1e1e1" : "#fbfbfb" }
                GradientStop { position: 1 ; color: control.pressed ? "#ebebeb" : "#efefef" }
            }
            radius: 2;
        }
    }
    onClicked: {
        soundMngr.playSound();
    }
}

/*
OTHER WAY FOR SOUND NOT USED
JUST SAVED HERE AS A COMMENT

   import QtMultimedia 5.6

    SoundEffect {
        id: buttonSound
        source: "qrc:/Sound/crash_padle.wav"
        volume: 1
    }
    onClicked: {
        buttonSound.play()
    }
*/
