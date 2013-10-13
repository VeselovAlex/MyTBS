import QtQuick 2.0

Rectangle
{
    id : gameField
    property int cellSide: 100
    property alias rows : grid.rows
    property alias columns : grid.columns

    signal cellClicked(int row, int col);

    color : "transparent"

    width: cellSide * columns
    height: cellSide * rows

    Grid
    {
        id : grid
        anchors.fill: parent
        Repeater
        {
            id : rep
            model: gameField.rows * gameField.columns
            GameCell
            {
                width: gameField.cellSide
                onButtonClicked: gameField.cellClicked
                                 (Math.floor(index / gameField.columns),
                                  index % gameField.columns);
            }
        }
    }

    function cellAt(row, col)
    {
        return rep.itemAt(row * gameField.columns + col);
    }

    function occupyCell(actor, row, col)
    {
        var target = cellAt(row, col)
        target.occupiedBy = actor;
        target.occupiedBy.anchors.fill = target.occupiedBy.parent;
    }

}
