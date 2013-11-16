import QtQuick 2.0
import "../players"
import "../actors"
import "../environment"
import "Init.js" as Init
import "Turns.js" as Turns

Item
{
    id : battle

    property int curPlayer: 0
    property int curUnit: 0

    property int rowClicked : 0
    property int colClicked : 0

    Factory
    {
        id : factory
        Component.onCompleted:
        {
            Init.factoryLoaded = true;
            console.log(Init.factoryLoaded ? "factory completed!" : "");
            Init.componentIsLoaded();
        }

    }

    GameField
    {
        id : gamefield
        rows: 7
        columns : 10
        cellSide: 80
        x : Math.round((parent.width - cellSide * columns) / 2)
        y : Math.round((parent.height - cellSide * rows) / 2)
        onCellClicked:
        {
            if (Turns.cellCoordsRequired)
            {
                console.debug("Cell clicked at " + row + ";" + col);
                //var cell = cellAt(row, col)
                gamefield.cellCoords(row, col); //cell.x + gamefield.x, cell.y + gamefield.y);
            }
            /*if (Turns.targetActorRequired)
            {
                console.debug(cellAt(row, col).isEmpty ? "Empty" : cellAt(row, col).occupiedBy);
                target(cellAt(row, col).occupiedBy);
            }*/
        }

        Component.onCompleted:
        {
            Turns.currentGameField = gamefield;
            cellCoords.connect(Turns.moveActorTo);
            Init.gameFieldLoaded = true;
            console.log(Init.gameFieldLoaded ? "gamefield completed!" : "");
            Init.componentIsLoaded();
        }
    }

    AttackBar
    {
        id : attackBar
        width: 240
        Component.onCompleted:
        {
            disableAttackBar();
            Turns.attackBar = attackBar
            Init.attackBarLoaded = true;
            console.log("AttackBar completed!");
            Init.componentIsLoaded();
        }
    }
    /*GameField
    {

        z: 0
        x : Math.round((parent.width - cellSide * columns) / 2)
        y : Math.round((parent.height - cellSide * rows) / 2)

        id : gameField
        rows: 7
        columns : 10
        cellSide: 80
        property var previousHighlighted : null

        /*onCellClicked:
        {
            rowClicked = row
            colClicked = col
            if (attackMenu.moveButtonChosen)
            {
                if (cellAt(rowClicked, colClicked).isEmpty && cellAt(rowClicked, colClicked).highlighted)
                {
                    var tempRow = players[curPlayer].playerUnits[curUnit].curRow
                    var tempCol = players[curPlayer].playerUnits[curUnit].curCol
                    gameField.highlightPossibleCells(players[curPlayer].playerUnits[curUnit].curRow
                                                     , players[curPlayer].playerUnits[curUnit].curCol
                                                     , false);
                    occupyCell(players[curPlayer].playerUnits[curUnit], rowClicked, colClicked)
                    players[curPlayer].playerUnits[curUnit].curRow = rowClicked
                    players[curPlayer].playerUnits[curUnit].curCol = colClicked

                    clearCell(tempRow, tempCol)

                    attackMenu.moveButtonChosen = false

                    var horizOffset = Math.abs(tempCol - colClicked);
                    var vertOffset = Math.abs(tempRow - rowClicked);
                    players[curPlayer].playerUnits[curUnit].movingRangeLeft -= horizOffset + vertOffset;

                    if (players[curPlayer].playerUnits[curUnit].movingRangeLeft > 0)
                    {
                        unitTurn();
                    }
                    else
                    {
                        players[curPlayer].playerUnits[curUnit].movingRangeLeft =
                                players[curPlayer].playerUnits[curUnit].movingRange;
                        nextUnit();
                    }
                }
                else
                {

                }
            }
        }
    }
    AttackBar
    {
        id : attackMenu
        width : gameField.cellSide * 1.5
        anchors.left: parent.left
        enabled: false
        visible: false
        onMoveButtonClicked:
        {
            disableAttackBar()
            moveButtonChosen = true;

        }
        onPrAttackButtonClicked:
        {
            disableAttackBar()
        }
        onSdAttackButtonClicked:
        {
            disableAttackBar()
        }
        onSkipButtonClicked:
        {
            disableAttackBar();
            gameField.highlightPossibleCells(players[curPlayer].playerUnits[curUnit].curRow
                                             , players[curPlayer].playerUnits[curUnit].curCol
                                             , false);
            nextUnit(curPlayer, curUnit);
        }
    }*/


    Player
    {
        id : player
        money : 100000
        commanderSkillPoints: 100500
        isEnemy: false
        Component.onCompleted:
        {
            Init.playerLoaded = true;
            Init.componentIsLoaded();
            console.log(Init.playerLoaded ? "player completed!" : "");
        }
    }

    Player
    {
        id : enemy
        money : 100000
        commanderSkillPoints: 100500
        isEnemy: true
        Component.onCompleted:
        {
            Init.enemyLoaded = true;
            Init.componentIsLoaded();
            console.log(Init.enemyLoaded ? "enemy completed!" : "");
        }
    }

    TurnGenerator
    {
        id : generator
        players: [player, enemy]
    }

    Component.onCompleted:
    {
        //console.log("battle loaded");
    }

}
