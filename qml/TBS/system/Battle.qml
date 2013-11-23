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
            //console.log(Init.factoryLoaded ? "factory completed!" : "");
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
                //console.debug("Cell clicked at " + row + ";" + col);
                if (cellAt(row, col).isEmpty)
                    gamefield.cellCoords(row, col);
            }
            if (Turns.targetActorRequired)
            {
                //console.debug(cellAt(row, col).isEmpty ? "Empty" : cellAt(row, col).occupiedBy);
                var cell = cellAt(row, col);
                if (!cell.isEmpty)
                    gamefield.target(cell.occupiedBy);
            }
        }

        Component.onCompleted:
        {
            Turns.currentGameField = gamefield;
            cellCoords.connect(Turns.moveActorTo);
            target.connect(Turns.attackActor);
            Init.gameFieldLoaded = true;
            //console.log(Init.gameFieldLoaded ? "gamefield completed!" : "");
            Init.componentIsLoaded();
        }
    }

    AttackBar
    {
        id : attackBar
        width: 120
        Component.onCompleted:
        {
            disableAttackBar();
            Turns.attackBar = attackBar
            Init.attackBarLoaded = true;
            //console.log("AttackBar completed!");
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
            TurnManager.makeTurn(rowClicked, colClicked) //или стоит передать инфу выше?
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
            prAttackButtonChosen = true;
        }
        onSdAttackButtonClicked:
        {
            disableAttackBar()
            sdAttackButtonChosen = true;
        }
        onSkipButtonClicked:
        {
            disableAttackBar();

            gameField.highlightPossibleCells(players[curPlayer].playerUnits[curUnit].curRow
                                             , players[curPlayer].playerUnits[curUnit].curCol
                                             , false);
            players[curPlayer].playerUnits[curUnit].movingRangeLeft
                    = players[curPlayer].playerUnits[curUnit].movingRange
            nextUnit(curPlayer, curUnit);

        }
    }*/


    HumanPlayer
    {
        id : player
        money : 100000
        commanderSkillPoints: 100500

        isEnemy: false
        Component.onCompleted:
        {
            Init.playerLoaded = true;
            Init.componentIsLoaded();
            //console.log(Init.playerLoaded ? "player completed!" : "");
        }
    }

    EnemyPlayer
    //ComputerPlayer
    {
        id : enemy
        money : 100000
        commanderSkillPoints: 100500
        isEnemy: true
        Component.onCompleted:
        {
            Init.enemyLoaded = true;
            Init.componentIsLoaded();
            //console.log(Init.enemyLoaded ? "enemy completed!" : "");
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
