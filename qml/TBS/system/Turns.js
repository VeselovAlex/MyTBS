.pragma library

var cellCoordsRequired = false
var targetActorRequired = false

var attackBar
var currentPlayer
var currentActor
var currentGameField
var actorStatWgt
var playerStatWgt


function askForTurn()
{
    if (!attackBarConnected)
        connectAttackBar();
    attackBar.enableAttackBar(currentActor.x - (attackBar.width  - currentActor.width)  / 2,
                              currentActor.y - (attackBar.height - currentActor.height) / 2)
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
    console.log("Click any cell...");
}

function moveActorTo(X, Y)
{
    // Сделать в акторе метод move и переписать этот кусок
    occupyCellAt(null, currentActor.x, currentActor.y);
    currentGameField.occupyCell(currentActor,X,Y);
    console.debug("Actor moves to " + X + ";" + Y);
    nextUnitTurn();
}


var primaryAttack = false
var secondaryAttack = false

function needPrAttack()
{
    primaryAttack = true;
    secondaryAttack = false;
    needAttack();
}

function needSdAttack()
{
    primaryAttack = false;
    secondaryAttack = true;
    needAttack();
}

function needAttack()
{
    console.debug("Need attack!")
    askForTarget();
}

function askForTarget()
{
    cellCoordsRequired = false;
    targetActorRequired = true;
    console.log("Click any actor...");
}

function attackActor(actor)
{
    console.debug(primaryAttack ? "Primary attack!" : (secondaryAttack ? "Secondary attack!" : "Attack error!"));
    nextUnitTurn();
}



var currentUnitIdx
function nextUnitTurn()
{
    //console.log("currentUnitIdx: " + currentUnitIdx);
    if (currentUnitIdx >= currentPlayer.unitCount)
    {
        currentPlayer.turnFinished();
        return;
    }
    currentActor = currentPlayer.playerUnits[currentUnitIdx++];//Если бы не баг, этого говна здесь бы не было
    actorStatWgt.update(currentActor);
    askForTurn();
}


var attackBarConnected = false

function connectAttackBar()
{
    if (attackBarConnected)
        return;
    attackBar.moveButtonClicked.connect(needMove);
    attackBar.skipButtonClicked.connect(nextUnitTurn);
    attackBar.prAttackButtonClicked.connect(needPrAttack);
    attackBar.sdAttackButtonClicked.connect(needSdAttack);
    attackBarConnected = true;
}

function disconnectAttackBar()
{
    if (!attackBarConnected)
        return;
    attackBar.moveButtonClicked.disconnect(needMove);
    attackBar.skipButtonClicked.disconnect(nextUnitTurn);
    attackBar.prAttackButtonClicked.disconnect(needPrAttack);
    attackBar.sdAttackButtonClicked.disconnect(needSdAttack);
    attackBarConnected = false;
}

function occupyCellAt(actor, X, Y)
{
    var col = Math.floor((X - currentGameField.x)/ currentGameField.cellSide);
    var row = Math.floor((Y - currentGameField.y) / currentGameField.cellSide);
    return currentGameField.occupyCell(actor, row, col);
}
