import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Button{
    height: (rectID.width
            -(gridid.spacing*(gridid.columns-1))
            -(gridid.anchors.leftMargin)
            -(gridid.anchors.rightMargin)
        )/gridid.columns
   width : (rectID.width
            -(gridid.spacing*(gridid.columns-1))
            -(gridid.anchors.leftMargin)
            -(gridid.anchors.rightMargin)
        )/gridid.columns


    onClicked:
    {

    }
}
/*
(parent.height
    -(toolbar_game.height)
    -(gridid.spacing*(gridid.rows-1))
    -(gridid.anchors.topMargin)
    -(gridid.anchors.bottomMargin)
)/gridid.rows
(parent.width
    -(gridid.spacing*(gridid.columns-1))
    -(gridid.anchors.leftMargin)
    -(gridid.anchors.rightMargin)
)/gridid.columns
*/
