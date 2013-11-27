.pragma library

var cellCoordsRequired = false
var targetActorRequired = false

var attackBar
var currentPlayer
var currentActor = null
var currentGameField
var actorStatWgt
var playerStatWgt

var currentActorRow = null;
var currentActorColumn = null;

function reset()
{
    cellCoordsRequired = false
    targetActorRequired = false

//    attackBar = null
//    currentPlayer = null
//    currentActor = null
//    currentGameField = null
//    actorStatWgt = null
//    playerStatWgt = null

    currentActorRow = null;
    currentActorColumn = null;
}

function askForTurn()
{
    if (!attackBarConnected)
        connectAttackBar();
    attackBar.enableAttackBar(currentActor.x - (attackBar.width  - currentActor.width)  / 2,
                              currentActor.y - (attackBar.height - currentActor.height) / 2);
    currentActorRow =  getActorsRow(currentActor);
    currentActorColumn =  getActorsCol(currentActor);
}


function needMove()
{
    console.debug("Need move")
    disableHighLightForAttack(currentActorRow, currentActorColumn, currentActor.secondaryAttackRange);
    disableHighLightForAttack(currentActorRow, currentActorColumn, currentActor.primaryAttackRange);
    enableHighLight(currentActorRow, currentActorColumn);
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
    disableHighLight(currentActorRow, currentActorColumn);
    occupyCellAt(null, currentActor.x, currentActor.y)
    currentActor.moveTo(xCoordOf(Y), yCoordOf(X));
    currentGameField.occupyCell(currentActor, X, Y)
    console.debug("Actor moves to " + X + ";" + Y);
    cellCoordsRequired = false;
    currentActor.movingRangeLeft = currentActor.movingRangeLeft - getDistanceTravelled(currentActor);
    if (currentActor.movingRangeLeft > 0)
    {
        askForTurn()
    }
    else
    {
        nextUnitTurn();
    }
}

var primaryAttack = false
var secondaryAttack = false

function needPrAttack()
{
    primaryAttack = true;
    secondaryAttack = false;
    disableHighLight(currentActorRow, currentActorColumn);
    disableHighLightForAttack(currentActorRow, currentActorColumn, currentActor.secondaryAttackRange);
    enableHighLightForAttack(currentActorRow, currentActorColumn, currentActor.primaryAttackRange);
    needAttack();
}

function needSdAttack()
{
    primaryAttack = false;
    secondaryAttack = true;
    disableHighLight(currentActorRow, currentActorColumn);
    disableHighLightForAttack(currentActorRow, currentActorColumn, currentActor.primaryAttackRange);
    enableHighLightForAttack(currentActorRow, currentActorColumn, currentActor.secondaryAttackRange);
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
    if (currentGameField.cellAt(getActorsRow(actor), getActorsCol(actor)).highlighted)
    {
        if (primaryAttack)
        {
            if (actor.parent != currentPlayer)
            {
                currentActor.primaryAttack(actor);
                disableHighLightForAttack(currentActorRow, currentActorColumn, currentActor.primaryAttackRange);
                primaryAttack = false;
                nextUnitTurn();
            }
        }
        else if (secondaryAttack)
        {
            if (actor.parent != currentPlayer && !currentActor.isHealer)
            {
                currentActor.secondaryAttack(actor);
                disableHighLightForAttack(currentActorRow, currentActorColumn, currentActor.secondaryAttackRange);
                secondaryAttack = false
                nextUnitTurn();
            }
            else if (actor.parent == currentPlayer && currentActor.isHealer)
            {
                currentActor.secondaryAttack(actor);
                disableHighLightForAttack(currentActorRow, currentActorColumn, currentActor.secondaryAttackRange);
                secondaryAttack = false
                nextUnitTurn();
            }
        }
    }
}

var currentUnitIdx = 0
function nextUnitTurn()
{
    if (currentPlayer.unitCount <= 0) // чтобы не падало. переделать!
        return;

    if (currentUnitIdx >= currentPlayer.unitCount)
    {
        currentPlayer.turnFinished();
        return;
    }
    if (currentActorRow != null && currentActorColumn != null) // disable highlight after skipping turn
    {
        disableHighLight(currentActorRow, currentActorColumn);
        currentActorRow = null;
        currentActorColumn = null;
        disableHighLight(currentActorRow, currentActorColumn);
    }
    currentActor = currentPlayer.playerUnits[currentUnitIdx++];//Если бы не баг, этого говна здесь бы не было
    currentActor.movingRangeLeft = currentActor.movingRange

	actorStatWgt.update(currentActor);
    askForTurn();
}

function xCoordOf(col)
{
    var ret = (currentGameField.x + col * currentGameField.cellSide);
    console.debug(ret);
    return ret;
}

function yCoordOf(row)
{
    var ret = (currentGameField.y + row * currentGameField.cellSide);
    console.debug(ret);
    return ret;
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

function enableHighLight(row, col)
{
    currentGameField.highlightPossibleCells(row, col, currentActor.movingRangeLeft, true);
}

function disableHighLight(row, col)
{
    currentGameField.highlightPossibleCells(row, col, currentActor.movingRangeLeft, false);
}

function enableHighLightForAttack(row, col, radius)
{
    currentGameField.highLightCellsForAttack(row, col, radius, true);
}

function disableHighLightForAttack(row, col, radius)
{
    currentGameField.highLightCellsForAttack(row, col, radius, false);
}

function getActorsRow(actor)
{
    return Math.floor((actor.y - currentGameField.y) / currentGameField.cellSide);
}

function getActorsCol(actor)
{
    return Math.floor((actor.x - currentGameField.x) / currentGameField.cellSide);
}

function getDistanceTravelled(actor)
{
    return (Math.abs(currentActorColumn - getActorsCol(actor)) + Math.abs(currentActorRow - getActorsRow(actor)));
}

function unitDied(actor)
{
    actor.parent.unitCount--;
    for (var i = 0; i < actor.parent.unitCount; i++)
    {
        if (actor.parent.playerUnits[i] == actor)
        {
            for (var j = i; j < actor.parent.unitCount; j++)
            {
                actor.parent.playerUnits[j] = actor.parent.playerUnits[j + 1];
            }
            break;
        }

    }
}
