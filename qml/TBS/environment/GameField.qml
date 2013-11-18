import QtQuick 2.0
import "../actors"

Rectangle
{
    id : gameField
    property int cellSide: 80
    property alias rows : grid.rows
    property alias columns : grid.columns

    signal cellClicked(int row, int col);
    signal cellCoords(int X, int Y);
    signal target(var actor);

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
                cellCol: index % gameField.columns
                cellRow: Math.floor(index / gameField.columns)
                onButtonClicked: gameField.cellClicked(cellRow, cellCol);
            }
        }
    }

    function cellAt(row, col)
    {
        var cell = rep.itemAt(row * gameField.columns + col);
        //cell.buttonClicked();
        return cell;
    }

    function occupyCell(actor, row, col)
    {
        var target = cellAt(row, col)
        target.occupiedBy = actor;
        if (actor == null || actor == undefined)
            return;
        target.occupiedBy.x = target.x + gameField.x;
        target.occupiedBy.y = target.y + gameField.y;
        target.occupiedBy.width = target.width;
        target.occupiedBy.height = target.height;
    }

    function clearCell(row, col)
    {
        cellAt (row,col).isEmpty = true;
    }

    function destroyCell(row, col)
    {
        cellAt(row, col).occupiedBy.destroy();
    }

    function highlightPossibleCells(row, col, enabled)
    {

        var currentCell = cellAt(row, col);
        if (currentCell == null || !currentCell.active || currentCell.isEmpty)
            return;

        var moveRangeLeft = currentCell.occupiedBy.movingRangeLeft
        if (moveRangeLeft == 0)
            return;

        for (var i = - moveRangeLeft; i <= moveRangeLeft; i++)
        {
            if (i + col < 0)
                continue;
            if (i + col >= gameField.columns)
                break;
            for (var  j = Math.abs(i) - moveRangeLeft; j <= moveRangeLeft - Math.abs(i); j++)
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
