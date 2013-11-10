import QtQuick 2.0
import "../players"
import "../actors"
import "../environment"
//import "initPlayers.js" as Init
import "Init.js" as Init

Item
{
    property var players : Array

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
            if (attackMenu.prAttackButtonChosen) //для дебага атакуют своих. Заменить потом, где надо curPlayer на 1 - curPlayer
            {//реализовать обход препятствий
                if (!cellAt(rowClicked, colClicked).isEmpty)
                {

                    var horizOffset1 = Math.abs(players[curPlayer].playerUnits[curUnit].curCol - colClicked);
                    var vertOffset1 = Math.abs(players[curPlayer].playerUnits[curUnit].curRow - rowClicked);
                    if (horizOffset1 + vertOffset1 <= players[curPlayer].playerUnits[curUnit].primaryAttackRange)
                    {
                        gameField.highlightPossibleCells(players[curPlayer].playerUnits[curUnit].curRow
                                                         , players[curPlayer].playerUnits[curUnit].curCol
                                                         , false);

                        attackMenu.prAttackButtonChosen = false;

                        for (var i = 0; i < players[curPlayer].unitCount; i++)
                        {
                            if (rowClicked == players[curPlayer].playerUnits[i].curRow &&
                                    colClicked == players[curPlayer].playerUnits[i].curCol)
                            {
                                console.debug("pad" + players[curPlayer].playerUnits[curUnit].primaryAttackDamage)
                                console.debug("hp" +  players[curPlayer].playerUnits[i].averageHealth)
                                players[curPlayer].playerUnits[i].hurt(
                                            players[curPlayer].playerUnits[curUnit].primaryAttackDamage);
                                if (players[curPlayer].playerUnits[i].averageHealth <= 0)
                                {
                                    clearCell(players[curPlayer].playerUnits[i].curRow,
                                              players[curPlayer].playerUnits[i].curCol)
                                    for (var j = i; j < players[curPlayer].unitCount - 1; j++)
                                    {
                                        players[curPlayer].playerUnits[j] = players[curPlayer].playerUnits[j + 1]
                                    }
                                    players[curPlayer].unitCount--
                                }

                                console.debug("hp" +  players[curPlayer].playerUnits[i].averageHealth)
                                break;
                            }
                        }
                    }
                    else
                    {
                        unitTurn();
                    }

                    players[curPlayer].playerUnits[curUnit].movingRangeLeft =
                            players[curPlayer].playerUnits[curUnit].movingRange;
                    nextUnit();

                }
                else
                {
                    unitTurn();
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
            prAttackButtonChosen = true;
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
            players[curPlayer].playerUnits[curUnit].movingRangeLeft = players[curPlayer].playerUnits[curUnit].movingRange
            nextUnit(curPlayer, curUnit);

        }
    }

    /*Player
    {
        id : player
        money : 100000
        commanderSkillPoints: 100500
        //isEnemy: false
    }
    Player // need to use files
    {
        id : enemy
        money : 100000
        commanderSkillPoints: 100500
        //isEnemy: true

    }*/
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
        //Init.createUnits(player);
        /*Init.createUnits(enemy);
        Init.createUnits(player);*/
        //Init.initTestEnemy()
        //Init.initTestPlayer()
        player.isEnemy = false;
        console.debug("creating player")
        for (var i = 0; i < player.maxUnitCount; i++)
        {
            var actor = factory.createActor(0, player);
            player.buyNewUnit(actor, 1);
            console.debug("01 " + player.playerUnits[i].curRow + ";" + player.playerUnits[i].curCol)
            gameField.occupyCell(player.playerUnits[i], i + 1, 0);
            console.debug("02 " + player.playerUnits[i].curRow + ";" + player.playerUnits[i].curCol)
            player.playerUnits[i].curRow = i + 1;
            player.playerUnits[i].curCol = 0;
            console.debug("03 " + player.playerUnits[i].curRow + ";" + player.playerUnits[i].curCol)
        }

        console.debug("creating enemy")
        enemy.isEnemy = true
        for (var i1 = 0; i1 < enemy.maxUnitCount; i1++)
        {
            console.debug("0 " + enemy.playerUnits[i1].curRow + ";" + enemy.playerUnits[i1].curCol)
            var actor1 = factory.createActor(0, enemy);
            console.debug("1 " + enemy.playerUnits[i1].curRow + ";" + enemy.playerUnits[i1].curCol)
            enemy.buyNewUnit(actor1, 1);
            console.debug("2 " + enemy.playerUnits[i1].curRow + ";" + enemy.playerUnits[i1].curCol)
            gameField.occupyCell(enemy.playerUnits[i1], i1 + 1, gameField.columns - 1);
            console.debug("3 " + enemy.playerUnits[i1].curRow + ";" + enemy.playerUnits[i1].curCol)
            enemy.playerUnits[i1].curRow = i1 + 1;
            enemy.playerUnits[i1].curCol = gameField.columns - 1;
            console.debug("4 " + enemy.playerUnits[i1].curRow + ";" + enemy.playerUnits[i1].curCol)
        }
        playersReady();
    }

    /*function playerReady()
    {
        numPlayersReady++;
        if (numPlayersReady == 2)
        {
            playersReady();
        }
    }*/

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

        //console.debug(players[curPlayer].playerUnits[curUnit].curRow + ";" + players[curPlayer].playerUnits[curUnit].curCol);
        //обрабатываем хренотень с бара
    }


    function nextUnit()
    {
        if (curUnit < players[curPlayer].unitCount - 1)
        {
            ++curUnit
            /*console.debug("changing units")
            console.debug("cu" + curUnit)
            console.debug("cp" + curPlayer)
            console.debug(players[curPlayer].playerUnits[curUnit].curRow +";"+ players[curPlayer].playerUnits[curUnit].curCol)
*/
            unitTurn();
        }
        else
        {
            curPlayer = 1 - curPlayer
            /*console.debug("changing players")
            console.debug("cu" + curUnit)
            console.debug("cp" + curPlayer)
            console.debug(players[curPlayer].isEnemy)*/
            curUnit = 0
            unitTurn();
        }
    }


}
