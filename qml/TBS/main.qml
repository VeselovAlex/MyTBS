import QtQuick 2.0
import "environment"
import "environment/buttons"
import "actors"
import "players"
import "system"

Item
{
    width: 1200
    height: 900

    Factory
    {
        id : factory
    }

    Image
    {
        anchors.fill: parent
        source : "qrc:/images/res/woodBg.png"
    }


    Player
    {
        id : enemy
        money : 100000
        commanderSkillPoints: 100500
        isEnemy: true
        onInitRequest:
        {
            var actor = factory.createActor(0, enemy);
            enemy.buyNewUnit(actor, 1);
            gameField.occupyCell(enemy.playerUnits[0], 5, 3);
        }
    }
    Player
    {
        id : player
        money : 100000
        commanderSkillPoints: 100500
        onInitRequest:
        {
            var actor = factory.createActor(0, player);
            player.buyNewUnit(actor, 1);
            gameField.occupyCell(player.playerUnits[0], 1, 2);
        }
    }


    TurnGenerator
    {
        players: [player, enemy]
        Component.onCompleted:
        {
            console.debug(playerCount)
            nextPlayerTurn();
            nextPlayerTurn();
        }
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

        Component.onCompleted: defaultPlayerActors();

    }
    AttackBar
    {

    }


    function defaultPlayerActors()
    {
        var actor = player.playerUnits[0];

    }

    CloseButton
    {
        id : closeBtn
        width: 50
        anchors.right: parent.right
    }

   LikeButton
    {
        id : like
        width : 50
        anchors.right: closeBtn.left
    }

}
