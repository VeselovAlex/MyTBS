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

    signal unitTurn ()
    signal nextUnit ()

    property int rowClicked : 0
    property int colClicked : 0
    Factory
    {
        id : factory
    }
    GameField
    {

        z: 0
        anchors.centerIn: parent
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
                if (cellAt(rowClicked, colClicked).isEmpty)
                {
                    var tempRow = players[curPlayer].playerUnits[curUnit].curRow
                    var tempCol = players[curPlayer].playerUnits[curUnit].curCol
                    occupyCell(players[curPlayer].playerUnits[curUnit], rowClicked, colClicked)

                    players[curPlayer].playerUnits[curUnit].curRow = rowClicked
                    players[curPlayer].playerUnits[curUnit].curCol = colClicked
                    clearCell(tempRow, tempCol)
                    attackMenu.moveButtonChosen = false
                    gameField.highlightPossibleCells(players[curPlayer].playerUnits[curUnit].curRow
                                                     , players[curPlayer].playerUnits[curUnit].curCol
                                                     , false);
                    nextUnit();
                }
                else
                {

                }
            }

            //console.debug("!!!" + players[curPlayer].playerUnits[curUnit].curRow + ";" + players[curPlayer].playerUnits[curUnit].curCol )
            //console.debug (row + ";" + col)
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
            for (var i = 0; i < maxUnitCount; i++)
            {
                var actor = factory.createActor(0, enemy);
                enemy.buyNewUnit(actor, 1);
                gameField.occupyCell(enemy.playerUnits[i], i + 1, gameField.columns - 1);
                player.playerUnits[i].curRow = i + 1;
                player.playerUnits[i].curCol = gameField.columns - 1;
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
        attackMenu.enableAttackBar();
        gameField.highlightPossibleCells(players[curPlayer].playerUnits[curUnit].curRow
                                         , players[curPlayer].playerUnits[curUnit].curCol
                                         , true);
        console.debug(players[curPlayer].playerUnits[curUnit].curRow + ";" + players[curPlayer].playerUnits[curUnit].curCol);
        //обрабатываем хренотень с бара
    }


    onNextUnit:
    {
        if (curUnit < players[curPlayer].maxUnitCount - 1)
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
