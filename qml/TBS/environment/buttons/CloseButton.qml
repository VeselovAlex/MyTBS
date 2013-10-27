import QtQuick 2.0

Rectangle
{
    id : exitButton
    width: 50
    height: width
    color: "transparent"

    Image
    {
        anchors.fill: parent
        source: "qrc:/images/buttons/res/exitButton.png"
    }

    MouseArea
    {
        hoverEnabled: true
        anchors.fill: parent
        onHoveredChanged: parent.color = containsMouse ? "#40C0C0C0" : "transparent"
        //цвет - "#OORRGGBB", где OO - прозрачность
        onClicked: Qt.quit();
    }
}
