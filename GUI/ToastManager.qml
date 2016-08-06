import QtQuick 2.5

/**
 * @brief Manager that creates Toasts dynamically
 */
Column{

    /**
     * Public
     */

    /**
     * @brief Shows a Toast
     *
     * @param {string} text Text to show
     * @param {real} duration Duration to show in milliseconds, defaults to 3000
     */
    function show(text, duration){
        var toast = toastComponent.createObject(toastManager);
        toast.selfDestroying = true;
        toast.show(text, duration);
    }

    /**
     * Private
     */

    id: toastManager

    z: Infinity
    spacing: 5
    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottomMargin: parent.height*0.07

    property var toastComponent

    Component.onCompleted: toastComponent = Qt.createComponent("Toast.qml")
}
