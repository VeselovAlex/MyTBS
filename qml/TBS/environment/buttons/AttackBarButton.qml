import QtQuick 2.0

Rectangle
{
    id: attackBarButton
    property int iconSize: Math.floor(parent.width / 3)
    width: iconSize
    height: width
    radius: Math.round(width / 3);
    property alias imageSource: btnImage.source
    property alias btnClicked: mArea
    color: "transparent"

    Image
    {
        id: btnImage
        anchors.fill: parent
    }
    MouseArea
    {
        id: mArea
        hoverEnabled: true
        anchors.fill: parent
        preventStealing: true
        cursorShape: Qt.PointingHandCursor
        onHoveredChanged: parent.color = containsMouse ? "#40CF0721" : "transparent"
        //цвет - "#OORRGGBB", где OO - прозрачность
    }
}
