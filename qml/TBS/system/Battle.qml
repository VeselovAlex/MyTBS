import QtQuick 2.0
import "../players"
import "../actors"
import "../environment"
import "initPlayers.js" as Init
import "turnManager.js" as TurnManager

Item
{
    property var players : []

    property int curPlayer: 0
    property int curUnit: 0

    property int numPlayersReady : 0

    property int rowClicked : 0
    property int colClicked : 0
    Factory
    {
        id : factory
    }
    GameField
    {

        z: 0
        x : Math.round((parent.width - cellSide * columns) / 2)
        y : Math.round((parent.height - cellSide * rows) / 2)

        id : gameField
        rows: 7
        columns : 10
        cellSide: 80
        property var previousHighlighted : null

        onCellClicked:
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
    }

    HumanPlayer
    {
        id : player
        money : 100000
        commanderSkillPoints: 100500
    }
    EnemyPlayer
    {
        id : enemy
        money : 100000
        commanderSkillPoints: 100500
    }

    Component.onCompleted :
    {

        Init.createUnits(enemy);
        Init.createUnits(player);

        playersReady();
    }

    function playersReady()
    {
        players  = [player, enemy];
        unitTurn()
    }

    function unitTurn()
    {
        //проверка на смерть где-то должна быть
        attackMenu.enableAttackBar();
        gameField.highlightPossibleCells(players[curPlayer].playerUnits[curUnit].curRow
                                         , players[curPlayer].playerUnits[curUnit].curCol
                                         , true);
        //обрабатываем хренотень с бара
    }


    function nextUnit()
    {
        if (curUnit < players[curPlayer].unitCount - 1)
        {
            ++curUnit
            unitTurn();
        }
        else
        {
            curPlayer = 1 - curPlayer
            curUnit = 0
            unitTurn();
        }
    }
}
