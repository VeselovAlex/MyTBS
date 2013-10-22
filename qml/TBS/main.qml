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
            }

        }
    }

//    AttackBar
//    {
//        id : attackMenu
//        visible: false
//        width : gameField.cellSide * 1.5
//        enabled: false
//        onPrAttackButtonClicked: console.debug("Primary Attack")
//        z : 1;
//    }



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

//        }
//        onCellClicked:
//        {
//            var targetCell = cellAt(row, col)
//            console.debug("Click on:" + targetCell.x + ";" + targetCell.y);
//            if (!targetCell.empty)
//            {
//                attackMenu.parent = targetCell.occupiedBy;
//                attackMenu.z = targetCell.z + 1;
//                attackMenu.anchors.centerIn = attackMenu.parent
//                attackMenu.visible = true;
//                attackMenu.enabled = true;
//                if (targetCell.empty)
//                {

//                }
//            }

//        }

        //Component.onCompleted: defaultPlayerActors();

    }


//    function defaultPlayerActors()
//    {
//        var actor = player.playerUnits[0];

//    }
    TurnGenerator
    {
        players : [player, enemy]
        Component.onCompleted:
        {
            //console.debug(playerCount)
            nextPlayerTurn();
            //nextPlayerTurn();
        }

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
