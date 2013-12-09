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
    currentActorRow = null;
    currentActorColumn = null;
}

function askForTurn()
{
    if (!attackBarConnected)
        connectAttackBar();
    attackBar.enableAttackBar(currentActor.x - (attackBar.width  - currentActor.width)  / 2,
                              currentActor.y - (attackBar.height - currentActor.height) / 2);
    currentActorRow = getActorsRow(currentActor);
    currentActorColumn = getActorsCol(currentActor);
}


function needMove()
{
    console.debug("Need move")
    disableHighLightForAttack(currentActorRow, currentActorColumn, currentActor.secondaryAttackRange, "secondary");
    disableHighLightForAttack(currentActorRow, currentActorColumn, currentActor.primaryAttackRange, "primary");
    enableHighLight(currentActorRow, currentActorColumn);
    askForCoords();
}

function askForCoords()
{
    cellCoordsRequired = true;
    targetActorRequired = false;
    console.log("Click any cell...");
}

function moveActorTo(row, col)
{
    /*if (!currentGameField.cellAt(row, col).highlighted)
        return;*/ // turned off for debug
    // Сделать в акторе метод move и переписать этот кусок
    disableHighLight(currentActorRow, currentActorColumn);
    attackBar.disableAttackBar();
    currentGameField.occupyCell(null, currentActorRow, currentActorColumn, true);
    currentGameField.occupyCell(currentActor, row, col, true);
    currentActor.moveTo(xCoordOf(col), yCoordOf(row));
    console.debug("Actor moves to " + row + ";" + col);
    cellCoordsRequired = false;
    console.debug(getDistanceTravelled(row, col))
    currentActor.movingRangeLeft = currentActor.movingRangeLeft - getDistanceTravelled(row, col);
}

function continueTurn()
{
    if (currentActor.movingRangeLeft > 0)
    {
        askForTurn();
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
    disableHighLightForAttack(currentActorRow, currentActorColumn, currentActor.secondaryAttackRange, "secondary");
    enableHighLightForAttack(currentActorRow, currentActorColumn, currentActor.primaryAttackRange, "primary");
    needAttack();
}

function needSdAttack()
{
    primaryAttack = false;
    secondaryAttack = true;
    disableHighLight(currentActorRow, currentActorColumn);
    disableHighLightForAttack(currentActorRow, currentActorColumn, currentActor.primaryAttackRange, "primary");
    enableHighLightForAttack(currentActorRow, currentActorColumn, currentActor.secondaryAttackRange, "secondary");
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
                disableHighLightForAttack(currentActorRow, currentActorColumn, currentActor.primaryAttackRange, "primary");
                primaryAttack = false;
                nextUnitTurn();
            }
        }
        else if (secondaryAttack)
        {
            if (actor.parent != currentPlayer && !currentActor.isHealer)
            {
                currentActor.secondaryAttack(actor);
                disableHighLightForAttack(currentActorRow, currentActorColumn, currentActor.secondaryAttackRange, "secondary");
                secondaryAttack = false
                nextUnitTurn();
            }
            else if (actor.parent == currentPlayer && currentActor.isHealer)
            {
                currentActor.secondaryAttack(actor);
                disableHighLightForAttack(currentActorRow, currentActorColumn, currentActor.secondaryAttackRange, "secondary");
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
        disableHighLightForAttack(currentActorRow, currentActorColumn,
                                  Math.max(currentActor.primaryAttackRange, currentActor.secondaryAttackRange),
                                  (currentActor.primaryAttackRange > currentActor.secondaryAttackRange)? "primary" : "secondary");
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

function enableHighLightForAttack(row, col, radius, attackType)
{
    currentGameField.highLightCellsForAttack(row, col, radius, true, attackType);
}

function disableHighLightForAttack(row, col, radius, attackType)
{
    currentGameField.highLightCellsForAttack(row, col, radius, false, attackType);
}

function getActorsRow(actor)
{
    return Math.floor((actor.y - currentGameField.y) / currentGameField.cellSide);
}

function getActorsCol(actor)
{
    return Math.floor((actor.x - currentGameField.x) / currentGameField.cellSide);
}

function  getDistanceTravelled(row, col)
{
    return (Math.abs(currentActorColumn - col) + Math.abs(currentActorRow - row));
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

