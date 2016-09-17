import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "qrc:/Styles/" 1.0

Button
{
    id: androidButton
    style: ButtonStyle{
        background: Rectangle {
            border.width: control.activeFocus ? 2 : 1
            border.color: Style.color.android_Button_Border
            gradient: Gradient {
                GradientStop { position: 0 ; color: control.pressed ? Style.color.android_Button_Pressed_0 : Style.color.android_Button_Released_0 }
                GradientStop { position: 1 ; color: control.pressed ? Style.color.android_Button_Released_1 : Style.color.android_Button_Pressed_1 }
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
