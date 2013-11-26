import QtQuick 2.0
import "../players"
import "../actors"
import "../environment"
import "../environment/HUD"
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
                if (cellAt(row, col).isEmpty)
                    gamefield.cellCoords(row, col);
            }
            if (Turns.targetActorRequired)
            {
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
    }
	
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
        }
        Component.onDestruction:
        {
            Turns.disconnectAttackBar();
        }
    }

    EnemyPlayer
    {
        id : enemy
        money : 100000
        commanderSkillPoints: 100500
        isEnemy: true
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
}
