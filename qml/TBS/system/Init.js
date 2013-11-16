var factoryLoaded = false
var gameFieldLoaded = false
var playerLoaded = false
var enemyLoaded = false
var attackBarLoaded = false

var playersInitialized = false

function componentIsLoaded()
{
    if (factoryLoaded && gameFieldLoaded && playerLoaded && enemyLoaded && !playersInitialized)
        initPlayers();
    if (playersInitialized && attackBarLoaded)
        generator.start();
}

function initPlayers()
{
    initTestPlayer();
    initTestEnemy();
    playersInitialized = true;
}

function initTestPlayer()
{
    console.debug("creating player")
    for (var i = 0; i < player.maxUnitCount; i++)
    {
        var actor = factory.createActor(0, player);
        player.buyNewUnit(actor, 1);

        gamefield.occupyCell(player.playerUnits[i], i + 1, 0);
    }
    player.turnFinished.connect(generator.nextPlayerTurn);
}

function initTestEnemy()
{
    console.debug("creating enemy")
    for (var i = 1; i < enemy.maxUnitCount; i++)
    {
        var actor = factory.createActor(0, enemy);
        enemy.buyNewUnit(actor, 1);
        gamefield.occupyCell(enemy.playerUnits[i - 1], i + 1, gamefield.columns - 1);
    }
    player.turnFinished.connect(generator.nextPlayerTurn);
}
