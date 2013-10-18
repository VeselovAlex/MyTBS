import QtQuick 2.0
import QtGraphicalEffects 1.0

Item
{
    width: 50
    height: width
    Rectangle
    {
        id : bg
        color: "lightgrey"
        anchors.fill: parent
        visible: false
    }

    Image
    {
        id :opMask
        source: "qrc:/images/buttons/res/heartButton.png"
        anchors.fill: parent
        visible: false
    }

    OpacityMask
    {
        anchors.fill: parent
        source : bg
        maskSource: opMask
    }

    MouseArea
    {
        anchors.fill: parent
        property bool enabled : false
        onClicked:
        {
            bg.color = enabled ? "lightgrey" : "cyan";
            enabled = !enabled;
        }
    }

}
