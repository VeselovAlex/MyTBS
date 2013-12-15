import QtQuick 2.0
import "../players"
import "../actors"
import "../environment"
import "../environment/HUD"
import "Init.js" as Init
import "AI.js" as Ai
import "Turns.js" as Turns

Item
{
    id : battle
    property int curPlayer: 0
    property int curUnit: 0

    property int rowClicked : 0
    property int colClicked : 0

    signal winner(Player winner);

    Factory
    {
        id : factory
        Component.onCompleted:
        {
            Init.factoryLoaded = true;
            Init.componentIsLoaded();
        }

    }

    GameField
    {
        id : gamefield
        rows: 7
        columns : 10
        cellSide: Math.min(parent.width / (columns + 3), parent.height / (rows + 3))
        x : Math.round((battle.width - cellSide * columns) / 2)
        y : cellSide
        onCellClicked:
        {
            if (Turns.cellCoordsRequired)
            {
                var cell = cellAt(row, col);
                if (cell.isEmpty && cell.highlighted)
                    gamefield.cellCoords(row, col);
            }
            if (Turns.targetActorRequired)
            {
                var cell = cellAt(row, col);
                if (!cell.isEmpty && cell.highlighted)
                    gamefield.target(cell.occupiedBy);
            }
        }

        Component.onCompleted:
        {
            Turns.currentGameField = gamefield;
            Ai.currentGamefield = gamefield;
            Ai.fieldColumns = gamefield.columns;
            Ai.fieldRows = gamefield.rows;
            cellCoords.connect(Turns.moveActorTo);
            target.connect(Turns.attackActor);
            Init.gameFieldLoaded = true;
            Init.componentIsLoaded();
        }
        Component.onDestruction:
        {
            Turns.disconnectAttackBar();
        }
    }

    AttackBar
    {
        id : attackBar
        width: gamefield.cellSide * 1.5
        Component.onCompleted:
        {
            disableAttackBar();
            Turns.attackBar = attackBar
            Init.attackBarLoaded = true;
            Init.componentIsLoaded();
        }
        Component.onDestruction: console.debug("Destructed")
    }
	
    HumanPlayer
    {
        id: player
        width : gamefield.cellSide
        height : width
        money: 100000
        commanderSkillPoints: 100500
        isEnemy: false
        dataFileSource: "Test.txt"
        onGameOver:
        {
            parent.winner(enemy);
        }
        Component.onCompleted:
        {
            Ai.currentOpponent = player;
            Init.playerLoaded = true;
            Init.componentIsLoaded();
        }
        Component.onDestruction:
        {
            Turns.disconnectAttackBar();
        }
    }

    HumanPlayer
    {
        id: enemy
        width : gamefield.cellSide
        height : width
        money: 100000
        commanderSkillPoints: 100500
        isEnemy: true
        dataFileSource: "EnemyTest.txt"
        onGameOver:
        {
            parent.winner(player);
        }
        Component.onCompleted:
        {
            Init.enemyLoaded = true;
            Init.componentIsLoaded();
        }
        Component.onDestruction:
        {
            Turns.disconnectAttackBar();
        }
    }

    TurnGenerator
    {
        id : generator
        players: [player, enemy]
    }

    SelectedActorStatWidget
    {
        id : actorStatWgt
        width: parent.width / 5
        height: parent.height / 6
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 10

        Component.onCompleted: Turns.actorStatWgt = actorStatWgt
    }
    PlayerStatWidget
    {
        id : playerStatWgt
        width: parent.width / 8
        height: actorStatWgt.height
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 10

        Component.onCompleted: Turns.playerStatWgt = playerStatWgt
    }

    Component.onDestruction:
    {
        //player.savePlayerData();
        //enemy.savePlayerData();
        Turns.reset();
        Init.reset();
    }
}
