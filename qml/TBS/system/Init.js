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
    initPlayer();
    initEnemy();
    playersInitialized = true;
}

function initPlayer()
{
    //player.dataFileSource = "Test.txt";
    player.loadPlayerData(factory);
    for (var i = 0; i < player.unitCount; i++)
        gamefield.occupyCell(player.playerUnits[i], i + 1, 0);
    player.turnFinished.connect(generator.nextPlayerTurn);
    player.createConnection();
    player.savePlayerData();
}
function initEnemy()
{
    //enemy.dataFileSource = "EnemyTest.txt"
    enemy.loadPlayerData(factory)
    for (var i = 0; i < enemy.unitCount; i++)
        gamefield.occupyCell(enemy.playerUnits[i], i + 1, gamefield.columns - 1)
    enemy.turnFinished.connect(generator.nextPlayerTurn);
    enemy.createConnection();
}

function initTestPlayer()
{
    for (var i = 0; i < player.maxUnitCount; i++)
    {
        var actor = factory.createActor(i, player);
        player.buyNewUnit(actor, 1);
        gamefield.occupyCell(player.playerUnits[i], i + 1, 0)
    }
    player.turnFinished.connect(generator.nextPlayerTurn);
    player.createConnection();
}

function initTestEnemy()
{
    for (var i = 0; i < enemy.maxUnitCount; i++)
    {
        var actor = factory.createActor(i, enemy);
        enemy.buyNewUnit(actor, 2);
        gamefield.occupyCell(enemy.playerUnits[i], i + 1, gamefield.columns - 1)

    }
    enemy.turnFinished.connect(generator.nextPlayerTurn);
    enemy.createConnection();
}
