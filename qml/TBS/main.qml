import QtQuick 2.0
import "environment"
import "actors"

Item {
    width: 1200
    height: 900

    property var actorComponents : [Qt.createComponent("actors/Swordsman.qml")]
    Image
    {
        id : bgImage
        anchors.fill: parent
        source : "../../../MyTBS/res/woodBg.png"
    }

    GameField
    {
        anchors.centerIn: parent
        id : gameField
        rows: 7
        columns : 10
        onCellClicked:
        {
            var targetCell = cellAt(row, col)
            if (targetCell.empty)
            {
                var swordsman = parent.actorComponents[0].createObject(targetCell);
                occupyCell(swordsman, row, col);
            }
            else
            {
                highlightPossibleCells(row, col, true)
            }
        }

    }

    Rectangle
    {
        id : exitButton
        width: 50
        height: 50
        anchors.right: parent.right
        color: "transparent"
        Image
        {
            anchors.fill: parent
            source: "../../../MyTBS/res/exitButton.png"
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

}
