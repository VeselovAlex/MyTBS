import QtQuick 2.0
import "../players"
import "../actors"
import "../environment"

Item
{
    property var players : Array

    property int curPlayer: 0
    property int curUnit: 0

    property int signEmitted : 0
    signal playersReady;

    signal unitTurn()
    signal nextUnit()

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
    }

    Player
    {
        id : player
        money : 100000
        commanderSkillPoints: 100500
        isEnemy: false
        onInitRequest:
        {
            console.debug("creating player")
            for (var i = 0; i < maxUnitCount; i++)
            {
                var actor = factory.createActor(0, player);
                player.buyNewUnit(actor, 1);
                gameField.occupyCell(player.playerUnits[i], i + 1, 0);
                player.playerUnits[i].curRow = i + 1;
                player.playerUnits[i].curCol = 0;
            }
            playerReady();

        }
        onPlayerReady:
        {
            signEmitted++;
            if (signEmitted == 2)
            {
                playersReady();
            }
        }

    }
    Player // need to use files
    {
        id : enemy
        money : 100000
        commanderSkillPoints: 100500
        isEnemy: true
        onInitRequest:
        {
            console.debug("creating enemy")
            for (var i = 0; i < maxUnitCount; i++)
            {
                var actor = factory.createActor(0, enemy);
                enemy.buyNewUnit(actor, 1);
                gameField.occupyCell(enemy.playerUnits[i], i + 1, gameField.columns - 1);
                enemy.playerUnits[i].curRow = i + 1;
                enemy.playerUnits[i].curCol = gameField.columns - 1;
            }
            playerReady();
        }
        onPlayerReady:
        {
            signEmitted++;
            if (signEmitted == 2)
            {
                playersReady();
            }
        }
    }


    onPlayersReady:
    {
        players  = [player, enemy];
        unitTurn()
    }

    onUnitTurn:
    {
        //проверка на смерть где-то должна быть
        attackMenu.enableAttackBar();
        gameField.highlightPossibleCells(players[curPlayer].playerUnits[curUnit].curRow
                                         , players[curPlayer].playerUnits[curUnit].curCol
                                         , true);
        console.debug(players[curPlayer].playerUnits[curUnit].curRow + ";" + players[curPlayer].playerUnits[curUnit].curCol);
        //обрабатываем хренотень с бара
    }


    onNextUnit:
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
