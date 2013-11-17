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
        cellSide: 100
        x : Math.round((battle.width - cellSide * columns) / 2)
        y : Math.round((battle.height - cellSide * rows) / 2)
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
            console.log("Gamefield :" + gamefield.x + ";" + gamefield.y);
            Turns.currentGameField = gamefield;
            cellCoords.connect(Turns.moveActorTo);
            target.connect(Turns.attackActor);
            Init.gameFieldLoaded = true;
            //console.log(Init.gameFieldLoaded ? "gamefield completed!" : "");
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
        width: 240
        Component.onCompleted:
        {
            disableAttackBar();
            Turns.attackBar = attackBar
            Init.attackBarLoaded = true;
            //console.log("AttackBar completed!");
            Init.componentIsLoaded();
        }
    }

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
            //console.log(Init.playerLoaded ? "player completed!" : "");
        }
        Component.onDestruction:
        {
            Turns.disconnectAttackBar();
            console.log("GF destruct");
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
            //console.log(Init.enemyLoaded ? "enemy completed!" : "");
        }
        Component.onDestruction:
        {
            Turns.disconnectAttackBar();
            console.log("GF destruct");
        }
    }

    TurnGenerator
    {
        id : generator
        players: [player, enemy]
    }

    Component.onCompleted:
    {
        console.log("Battle width, height :" + battle.width + " " + battle.height);
    }

}
