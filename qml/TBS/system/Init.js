function logCurrentWidth()
{
    console.log("width : " + width);
}

function initTestPlayer()
{
    player.isEnemy = false;
    console.debug("creating player")
    for (var i = 0; i < player.maxUnitCount; i++)
    {
        var actor = factory.createActor(0, player);
        player.buyNewUnit(actor, 1);
        gameField.occupyCell(player.playerUnits[i], i + 1, 0);
        player.playerUnits[i].curRow = i + 1;
        player.playerUnits[i].curCol = 0;
    }
}

function initTestEnemy()
{
    console.debug("creating enemy")
    enemy.isEnemy = true
    for (var i = 0; i < enemy.maxUnitCount; i++)
    {
        var actor = factory.createActor(0, enemy);
        enemy.buyNewUnit(actor, 1);
        gameField.occupyCell(enemy.playerUnits[i], i + 1, gameField.columns - 1);
        enemy.playerUnits[i].curRow = i + 1;
        enemy.playerUnits[i].curCol = gameField.columns - 1;
    }
}
