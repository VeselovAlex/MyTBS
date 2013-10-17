import QtQuick 2.0

Rectangle
{
    id : gameField
    property int cellSide: 80
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

    function clearCell(row, col)
    {
        var target = cellAt(row, col)
        target.occupiedBy.destroy();
    }
    function highlightPossibleCells(row, col, enabled)
    {
        var currentCell = cellAt(row, col);
        if (currentCell == null || !currentCell.active || currentCell.isEmpty)
            return;

        var moveRange = currentCell.occupiedBy.movingRange
        if (moveRange == 0)
            return;

        for (var i = - moveRange; i <= moveRange; i++)
        {
            if (i + col < 0)
                continue;
            if (i + col >= gameField.columns)
                break;
            for (var  j = Math.abs(i) - moveRange; j <= moveRange - Math.abs(i); j++)
            {
                if (j + row < 0)
                    continue;
                if (j + row >= gameField.rows)
                    break;
                var cell = cellAt(j + row, i + col);
                if (cell.active && cell.isEmpty)
                    cell.highlighted = enabled;
            }
        }
        currentCell.highlighted = false;
    }

}
