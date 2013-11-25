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

    ScreenButton
    {
        id : textMsg
        width : 200
        text : "test!"
        anchors.top: closeBtn.bottom
        anchors.horizontalCenter: playButton.horizontalCenter
        onClicked: msg.showMsg("Test","#FF000000");
    }

    BlowUpMsg
    {
        id : msg
        startX: 500
        startY: 600
    }
}
