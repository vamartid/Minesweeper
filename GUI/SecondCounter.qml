import QtQuick 2.5

Timer {
    property int seconds: 0;
    interval: 1000; running: true; repeat: true
    onTriggered: seconds += 1
}
