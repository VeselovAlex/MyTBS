import QtQuick 2.0
import QtQuick.Particles 2.0
import "buttons"

Item
{
    signal playBtnClicked;

    Text
    {
        id :msg
        font.pixelSize: 48
        color : "yellow"
        style: Text.Outline
        styleColor: "lightgreen"
        width: parent.width / 3
        height: parent.height / 5
        elide: Text.ElideMiddle
        anchors.bottom: playButton.top
        anchors.horizontalCenter: playButton.horizontalCenter
        anchors.margins: 20
    }

    ScreenButton
    {
        id : playButton
        width : 200
        text : "play again!"
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
    function congratulate(winner)
    {
        msg.text = "Победитель - " + winner.name + " Подравляем!"
    }
}
