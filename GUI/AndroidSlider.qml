import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

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
                        GradientStop { position: 0 ; color: "#434343" }
                        GradientStop { position: 1 ; color: "#3f3f3f" }
                    }
                    radius: 8
                }
                Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    height: androidSlider.height*0.19
                    width: androidSlider.width*(value-minimumValue*0.9)/(maximumValue - minimumValue*0.9)
                    gradient: Gradient {
                        GradientStop { position: 0 ; color: "#ff774c" }
                        GradientStop { position: 1 ; color: "#FF5722" }
                    }
                    radius: 8
                }
            }

        handle: Rectangle {
            anchors.centerIn: parent
            gradient: Gradient {
                GradientStop { position: 0 ; color: control.pressed ? "#e1e1e1" : "#fbfbfb" }
                GradientStop { position: 1 ; color: control.pressed ? "#ebebeb" : "#efefef" }
            }
            border.color: "lightgray"
            border.width: androidSlider.height*0.03
            implicitWidth: androidSlider.height*0.62
            implicitHeight: androidSlider.height*0.62
            radius: 45
        }
    }
}
