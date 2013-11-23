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
        cellSide: 100
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
        width: 120
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
        width: 600
        height: 200
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 10

        Component.onCompleted: Turns.actorStatWgt = actorStatWgt
    }
    PlayerStatWidget
    {
        id : playerStatWgt
        width: 300
        height: 200
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 10

        Component.onCompleted: Turns.playerStatWgt = playerStatWgt
    }
}
