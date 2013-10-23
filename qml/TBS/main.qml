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

    property int signEmitted : 0
    signal playersReady;

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
            }
            playerReady();

        }
        onPlayerReady:
        {
            signEmitted++;
            console.debug(signEmitted);
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
            }
            playerReady();
        }
        onPlayerReady:
        {
            signEmitted++;
            console.debug(signEmitted);
            if (signEmitted == 2)
            {
                playersReady();
            }
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

        onCellClicked:
        {
            console.debug(row + ";" + col)
        }
    }
    onPlayersReady:
    {
        gen.startPlayersTurns();
    }

    TurnGenerator
    {

        id : gen
        players : [player, enemy]

        /*Component.onCompleted:
        {
            //console.debug(playerCount)
            if (player.state == Component.Ready)
            nextPlayerTurn();
            //nextPlayerTurn();
        }*/
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
