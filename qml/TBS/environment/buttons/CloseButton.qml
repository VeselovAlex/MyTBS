import QtQuick 2.0

ScreenButton
{
    id : exitButton
    width: 200

    text : "Quit"
    onClicked: Qt.quit();
}
