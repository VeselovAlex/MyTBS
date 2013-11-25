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


function askForTurn()
{
    if (!attackBarConnected)
        connectAttackBar();
    attackBar.enableAttackBar(currentActor.x - (attackBar.width  - currentActor.width)  / 2,
                              currentActor.y - (attackBar.height - currentActor.height) / 2);
    enableHighLight(currentActorRow, currentActorColumn);

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
    disableHighLigh(currentActorRow, currentActorColumn);
    occupyCellAt(null, currentActor.x, currentActor.y, true);
    currentActor.moveTo(xCoordOf(Y), yCoordOf(X));
    currentGameField.occupyCell(currentActor, X, Y, true);
    console.debug("Actor moves to " + X + ";" + Y);
    // радиус ходьбы равен 0??
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
    if (primaryAttack)
    {
        if (actor.parent != currentPlayer)
        {
            currentActor.primaryAttack(actor);
            nextUnitTurn();
        }
    }
    else if (secondaryAttack)
    {
        if (actor.parent != currentPlayer && !currentActor.isHealer)
        {
            currentActor.secondaryAttack(actor);
            nextUnitTurn();
        }
        else if (actor.parent == currentPlayer && currentActor.isHealer)
        {
            currentActor.secondaryAttack(actor);
            nextUnitTurn();
        }
    }

}

var currentUnitIdx
function nextUnitTurn()
{
    //console.log("currentUnitIdx: " + currentUnitIdx);
    if (currentPlayer.unitCount == 0) // чтобы не падало. переделать!
        return;
    if (currentUnitIdx >= currentPlayer.unitCount)
    {
        currentPlayer.turnFinished();
        return;
    }
    if (currentActorRow != null && currentActorColumn != null) // disable highlight after skipping turn
    {
        disableHighLigh(currentActorRow, currentActorColumn);
    }

    currentActor = currentPlayer.playerUnits[currentUnitIdx++];//Если бы не баг, этого говна здесь бы не было
    currentActorRow =  getActorsRow();
    currentActorColumn =  getActorsCol();
	
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
    currentGameField.highlightPossibleCells(row, col, currentActor.movingRange, true);
}

function disableHighLigh(row, col)
{
    currentGameField.highlightPossibleCells(row, col, currentActor.movingRange, false);
}

function getActorsRow()
{
    return Math.floor((currentActor.y - currentGameField.y) / currentGameField.cellSide);
}

function getActorsCol()
{
    return Math.floor((currentActor.x - currentGameField.x) / currentGameField.cellSide);
}

function unitDied(actor) //подебажить
{
    actor.parent.unitCount--;
    for (var i = 0; i < actor.parent.unitCount; i++)
    {
        if (actor.parent.playerUnits[i] == actor)
        {
            console.debug("OLOLO")
            for (var j = i; j < actor.parent.unitCount; j++)
            {
                actor.parent.playerUnits[j] = actor.parent.playerUnits[j + 1];
            }
            break;
        }

    }
}
