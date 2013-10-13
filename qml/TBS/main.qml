import QtQuick 2.0
import "environment"
import "actors"

Rectangle {
    width: 1200
    height: 900

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
            console.debug(row + ";" + col);
            gameField.cellAt(row, col).color = "red";
        }
        Component.onCompleted:
        {
            var component = Qt.createComponent("actors/Swordsman.qml")
            var swordsman = component.createObject(cellAt(0,0))
            occupyCell(swordsman, 0, 0);
        }
    }

    /*Swordsman
    {
        id : swordsman
        width: 90
        height: 100
        anchors.fill: gameField.cellAt(0, 0);
        Component.onCompleted:
        {
            console.debug("Completed" + x + y);
        }

    }*/

}
