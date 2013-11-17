import QtQuick 2.0
import "../system"
import QtQuick.Window 2.0

Item
{
    Image
    {
        anchors.fill: parent
        source : "qrc:/images/res/woodBg.png"
    }

    Battle
    {
        id : battle
        width: parent.width
        height: parent.height
        anchors.fill: parent
    }
}
