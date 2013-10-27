import QtQuick 2.0

Item
{
    property alias sprite : picture.sprite
    Item
    {
        id : picture
        property Sprite sprite

        height: parent.height
        width: height
        anchors.margins: 20

    }
    Rectangle
    {
        anchors.fill: parent
        color: "brown"
        opacity: 0.7
    }
}
