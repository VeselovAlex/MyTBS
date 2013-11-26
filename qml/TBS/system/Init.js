var factoryLoaded = false
var gameFieldLoaded = false
var playerLoaded = false
var enemyLoaded = false
var attackBarLoaded = false

var playersInitialized = false

function reset()
{
    factoryLoaded = false
    gameFieldLoaded = false
    playerLoaded = false
    enemyLoaded = false
    attackBarLoaded = false
    playersInitialized = false
}

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
    //console.debug("creating player")
    player.dataFileSource = "Test.txt";
    for (var i = 0; i < player.maxUnitCount; i++)
    {
        var actor = factory.createActor(0, player);
        player.buyNewUnit(actor, i);
    }
    for (var i = 0; i < player.unitCount; i++)
    {
        gamefield.occupyCell(player.playerUnits[i], i + 1, 0, false);
    }
    player.turnFinished.connect(generator.nextPlayerTurn);
    player.createConnection();
    //player.savePlayerData();
}

function initTestEnemy()
{
    //console.debug("creating enemy")
    for (var i = 0; i < enemy.maxUnitCount; i++)
    {
        var actor = factory.createActor(0, enemy);
        enemy.buyNewUnit(actor, 1);
        gamefield.occupyCell(enemy.playerUnits[i], i + 1, gamefield.columns - 1, false);
    }
    enemy.turnFinished.connect(generator.nextPlayerTurn);
    enemy.createConnection();
}
