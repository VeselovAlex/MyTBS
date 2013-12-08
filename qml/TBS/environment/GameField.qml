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
        return cell;
    }

    function occupyCell(actor, row, col)
    {
        var target = cellAt(row, col)
        target.occupiedBy = actor;
        if (actor == null || actor == undefined)
        {
            target.occupiedBy = null;
            return;
        }
        else
            target.occupiedBy = actor;
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
    function highlightPossibleCells(row, col, radius, enabled) // for moving
    {

        console.debug("Highlight: " + enabled);
        var currentCell = cellAt(row, col);
        currentCell.highlightColor = "#77AAFFAA"
        currentCell.highlighted = enabled;

        if (radius <= 0)
            return;

        if (row + 1 < gameField.rows && isHighlightable(cellAt(row + 1, col)))
        {
            highlightPossibleCells(row + 1, col, radius - 1, enabled);
        }
        if (col + 1 < gameField.columns && isHighlightable(cellAt(row, col + 1)))
        {
            highlightPossibleCells(row, col + 1, radius - 1, enabled);
        }
        if (row > 0  && isHighlightable(cellAt(row - 1, col)))
        {
            highlightPossibleCells(row - 1, col, radius - 1, enabled);
        }
        if (col > 0 && isHighlightable(cellAt(row, col - 1)))
        {
            highlightPossibleCells(row, col - 1, radius - 1, enabled);
        }
    }
    function isHighlightable(cell)
    {
        return cell != null && cell.active && cell.isEmpty
    }

    function highLightCellsForAttack(row, col, radius, enabled, attackType)
    {
        var currentCell = cellAt(row, col);
        if (currentCell == null || !currentCell.active || currentCell.isEmpty)
            return;


        if (radius <= 0)
            return;

        for (var i = - radius; i <= radius; i++)
        {
            if (i + col < 0)
                continue;
            if (i + col >= gameField.columns)
                break;
            for (var  j = Math.abs(i) - radius; j <= radius - Math.abs(i); j++)
            {
                if (j + row < 0)
                    continue;
                if (j + row >= gameField.rows)
                    break;
                var cell = cellAt(j + row, i + col);
                if (cell.active)
                {
                    if ((!currentCell.occupiedBy.isHealer || (currentCell.occupiedBy.isHealer && attackType == "primary"))
                            && (cell.isEmpty || currentCell.occupiedBy.parent !== cell.occupiedBy.parent))

                    {
                        cell.highlightColor = "#77FFAAAA";
                        cell.highlighted = enabled;
                    }
                    else if (currentCell.occupiedBy.isHealer && attackType == "secondary"
                             && (cell.isEmpty || currentCell.occupiedBy.parent === cell.occupiedBy.parent))
                    {
                        cell.highlightColor = "#77AAFFAA";
                        cell.highlighted = enabled;
                    }
                }
            }
        }
        if (currentCell.occupiedBy.isHealer && attackType == "secondary")
        {
            currentCell.highlighted = true;
        }
        else
        {
            currentCell.highlighted = false;
        }
    }

    /*function highlightPossibleCells(row, col, enabled)
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
    }*/
}
