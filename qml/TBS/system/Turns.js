.pragma library

var cellCoordsRequired = false
var targetActorRequired = false

var attackBar
var currentPlayer
var currentActor
var currentGameField

var attackBarConnected = false

function askForTurn()
{
    connectAttackBar();
    attackBar.enableAttackBar(400, 400)
}

function needMove()
{
    console.debug("Need move")
    askForCoords();
}

function askForCoords()
{
    cellCoordsRequired = true;
    targetActorRequired = false;
    console.log("press any cell");
}

function askForTarget()
{
    cellCoordsRequired = false;
    targetActorRequired = true;
    console.log("press any actor");
}

function moveActorTo(X, Y)
{
    // Сделать в акторе метод move и переписать этот кусок
    currentActor = currentPlayer.playerUnits[0];//For tests only!
    occupyCellAt(null, currentActor.x, currentActor.y);
    currentGameField.occupyCell(currentActor,X,Y);
    console.debug("Actor moves to" + X + ";" + Y);
}

function connectAttackBar()
{
    if (attackBarConnected)
        return;
    attackBar.moveButtonClicked.connect(needMove);
    attackBarConnected = true;
}

function disconnectAttackBar()
{
    if (!attackBarConnected)
        return;
    attackBar.moveButtonClicked.disconnect(needMove);
    attackBarConnected = false;
}

function occupyCellAt(actor, X, Y)
{
    var col = Math.floor((X - currentGameField.x)/ currentGameField.cellSide);
    var row = Math.floor((Y - currentGameField.y) / currentGameField.cellSide);
    return currentGameField.occupyCell(actor, row, col);
}
