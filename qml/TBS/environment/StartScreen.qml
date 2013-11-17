import QtQuick 2.0
import "buttons"

Item
{
    signal playBtnClicked;
    Image
    {
        id : bgImage
        source : "qrc:/images/res/woodBg.png"
        anchors.fill: parent
    }
    StartScreenButton
    {
        id : playButton
        width : 200
        text : "play!"
        anchors.centerIn: parent
        onClicked: playBtnClicked();
    }

}
