import QtQuick 2.0
import "../system"
import "buttons"
import QtQuick.Window 2.1

Item
{
    width:Screen.width
    height: Screen.height
    signal returnToMenu
    Battle
    {
        id : battle
        width: parent.width
        height: parent.height
        anchors.fill: parent
    }
    ScreenButton
    {
        id : toMenuBtn
        onClicked: parent.returnToMenu();
        text : "MAIN MENU"
        width: 200
        anchors.right: parent.right
        anchors.top : parent.top
        anchors.margins: 10
    }

}
