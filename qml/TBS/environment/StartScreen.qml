import QtQuick 2.0
import "buttons"
import "HUD"

Item
{
    signal playBtnClicked;

    ScreenButton
    {
        id : playButton
        width : 200
        text : "play!"
        anchors.centerIn: parent
        onClicked: playBtnClicked();
    }

    CloseButton
    {
        id : closeBtn
        width: 200
        anchors.top: playButton.bottom
        anchors.horizontalCenter: playButton.horizontalCenter
    }
}
