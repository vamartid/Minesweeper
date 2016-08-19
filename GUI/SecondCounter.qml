import QtQuick 2.5

//A simple timer to count the elapsed seconds during a game
Timer {
    property int seconds: 0;
    interval: 1000; running: false; repeat: true
    onTriggered: {
        if(seconds < 999){
            seconds += 1
        }
    }
}
