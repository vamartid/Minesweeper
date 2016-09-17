pragma Singleton
import QtQuick 2.0
QtObject {
    property QtObject color: QtObject{

        property color background               : "#303030"

        property color bar                      : "#FF5722"

        property color android_Button_Border    : "#888"

        property color android_Button_Pressed   : "#efefef"
        property color android_Button_Released  : "#fbfbfb"
        property color android_Button_Text      : "#000000"

        property color android_Button2_Pressed   : "#4c4c4c"
        property color android_Button2_Released  : "#303030"
        property color android_Button2_Text      : "#000000"

        property color text_On_Bar              : "#ffffff"
        property color text                     : "#ffffff"
        property color text_Selected            : "#ff7043"
        property color text_Epiloge             : "#ffffff"
        property color text_Link                : "#3b85b0"

        property color aboutPage_Rect_Border    : "#9e9e9e"

        property color cellTextColor            : "#000000"
        property color cellColorPressed         : "#D1D1D1"
        property color cellColorNotPressed      : "#F4F4F4"

        property color colorOne                 : "#0B0CA5"
        property color colorTwo                 : "#147116"
        property color colorThree               : "#A92322"
        property color colorFour                : "#080846"
        property color colorFive                : "#4D1514"
        property color colorSix                 : "#1F7373"
        property color colorSeven               : "#000000"
        property color colorEight               : "#808080"

        property color androidSlider_colorL_0   : "#434343"
        property color androidSlider_colorL_1   : "#3f3f3f"
        property color androidSlider_colorR_0   : "#ff774c"
        property color androidSlider_colorR_1   : "#FF5722"
        property color androidSlider_Border     : "#dddddd"

        property color scores                   : "#FF5722"

        property color dialog_Background        : "#3f3f3f"
        property color dialog_Shadow            : "#282828"
        property color dialog_Text              : "#ffffff"

        property color toast                    : "#616161"
        property color toast_Text               : "#ffffff"
    }

    property QtObject icons : QtObject{
        property string clear           : ""

        property string logo            : "icons/mine-white.png"

        property string gear            : "icons/gear.png"
        property string mouth           : "icons/open-mouth.png"
        property string smile           : "icons/smiling.png"
        property string sunglasses      : "icons/sunglasses.png"
        property string dazed           : "icons/dazed.png"

        property string red_mine        : "icons/mine-red.png"
        property string flagged_mine    : "icons/mine-greyflagged.png"

        property string flag            : "icons/flag.png"
        property string flag_greyed     : "icons/flag-greyed.png"

        property string screenshot      : "icons/screenshot.png"

        property string b_arrow         : "icons/back-arrow.png"
        property string f_arrow         : "icons/forward-arrow.png"
    }
}
