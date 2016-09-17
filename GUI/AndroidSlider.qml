import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "qrc:/Styles/" 1.0

Slider{
    id: androidSlider
    style: SliderStyle {
        groove:
            Item{
            anchors.centerIn: parent
                Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    height: androidSlider.height*0.19
                    width: androidSlider.width
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: Style.color.androidSlider_colorL_0 }
                        GradientStop { position: 1 ; color: Style.color.androidSlider_colorL_1 }
                    }
                    radius: 8
                }
                Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    height: androidSlider.height*0.19
                    width: androidSlider.width*(value-minimumValue*0.9)/(maximumValue - minimumValue*0.9)
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: Style.color.androidSlider_colorR_0 }
                        GradientStop { position: 1 ; color: Style.color.androidSlider_colorR_1 }
                    }
                    radius: 8
                }
            }

        handle: Rectangle {
            anchors.centerIn: parent
            gradient: Gradient {
                GradientStop { position: 0 ; color: control.pressed ? Style.color.android_Button_Pressed_0 : Style.color.android_Button_Released_0 }
                GradientStop { position: 1 ; color: control.pressed ? Style.color.android_Button_Released_1 : Style.color.android_Button_Pressed_1 }
            }
            border.color: Style.color.androidSlider_Border
            border.width: androidSlider.height*0.03
            implicitWidth: androidSlider.height*0.62
            implicitHeight: androidSlider.height*0.62
            radius: 45
        }
    }
}
