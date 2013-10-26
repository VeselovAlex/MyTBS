import QtQuick 2.0
import "../actors"

Rectangle
{
    id : cell
    width: 50
    height: width
    border.color: "gold"
    border.width: 2
    color : "transparent"

    property bool active : true
    property bool isEmpty : true
    property bool highlighted : false
    property color highlightColor: "#77AAFFAA"

    property Actor occupiedBy: null

    onOccupiedByChanged: isEmpty = (occupiedBy == null);
    onHighlightedChanged: color = (highlighted) ? highlightColor : "transparent";

    signal buttonClicked

    MouseArea
    {
        anchors.fill: parent
        onClicked:
        {
            /*if (active)
            {
                parent.buttonClicked();
            }
            else
                destroy();*/
            if (highlighted)
            {
                console.debug("highlighted")
            }
            else
            {

            }
        }
    }
}
