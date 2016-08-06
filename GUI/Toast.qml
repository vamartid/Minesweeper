import QtQuick 2.5

/**
* @brief An Android-like timed message text in a box that selfdestroys when finished if desired
*/
Rectangle{

    /**
    * Public
    */

    /**
    * @brief Shows this Toast
    *
    * @param {string} text Text to show
    * @param {real} duration Duration to show in milliseconds, defaults to 3000
    */
    function show(text, duration){
        theText.text = text;
        if(typeof duration !== "undefined"){
            if(duration >= 2*fadeTime)
                time = duration;
            else
                time = 2*fadeTime;
            }
        else
            time = defaultTime;
        anim.start();
    }

    property bool selfDestroying: false ///< Whether this Toast will selfdestroy when it is finished

    /**
    * Private
    */

    id: toast

    property real time: defaultTime
    readonly property real defaultTime: 3000
    readonly property real fadeTime: 300

    property real margin: 10

    width: childrenRect.width + 2*margin
    height: childrenRect.height + 2*margin
    radius: 7

    anchors.horizontalCenter: parent.horizontalCenter
    //anchors.bottom: parent.bottom

    opacity: 0
    color: "#616161"

    Text{
        id: theText
        text: ""
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        x: margin
        y: margin
    }

    SequentialAnimation on opacity{
        id: anim

        running: false

        NumberAnimation{
            to: 0.9
            duration: fadeTime
        }
        PauseAnimation{
            duration: time - 2*fadeTime
        }
        NumberAnimation{
            to: 0
            duration: fadeTime
        }

        onRunningChanged:{
            if(!running && selfDestroying)
                toast.destroy();
        }
    }
}
