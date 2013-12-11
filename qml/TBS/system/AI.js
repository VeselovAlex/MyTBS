.pragma library

var fieldRows
var fieldColumns

var currentOpponent
var currentGamefield

var multiplier = 0.01
var aiUnitsArray = new Array
var opponentUnitsArray = new Array

var currentDamageMatrix

function Unit(actor, row, col)
{
    var actor = actor;
    var row = row;
    var col = col;
    this.getActor = function()
    {
        return actor;
    }
    this.getRow = function() //Эрон-дон-дон...
    {
        return row;
    }
    this.getCol = function()
    {
        return col;
    }
}

function initAiData()
{
    currentDamageMatrix = new Array;
    for (var i = 0; i < fieldRows; i++)
    {
        currentDamageMatrix.push(new Array);
        for (var j = 0; j < fieldColumns; j++)
            currentDamageMatrix[i].push(0);
    }
    getFieldData();
}

function resetAIData()
{
    if (currentDamageMatrix == null)
        initAiData()
    else
    {
        for (var i = 0; i < fieldRows; i++)
        {
            for (var j = 0; j < fieldColumns; j++)
                currentDamageMatrix[i][j] = 0;
        }
        delete opponentUnitsArray;
        delete aiUnitsArray;
        aiUnitsArray = new Array
        opponentUnitsArray = new Array
        getFieldData();
    }
}

function getFieldData()
{
    for (var i = 0; i < fieldRows; i++)
        for (var j = 0; j < fieldColumns; j++)
        {
            var cell = currentGamefield.cellAt(i, j)
            if (cell == null || cell.isEmpty || !cell.active)
                continue;

            var unit = new Unit(cell.occupiedBy, i, j);
            if (unit.getActor().parent == currentOpponent)
                opponentUnitsArray.push(unit);
            else
                aiUnitsArray.push(unit);
        }
}

function logFieldData()
{
    console.log("AI'S UNITS:")
    for (var i = 0; i < aiUnitsArray.length; i++)
        console.log(aiUnitsArray[i].getActor().type + " " +
                    aiUnitsArray[i].getRow() + " " +
                    aiUnitsArray[i].getCol());
    console.log("OPPONENT'S UNITS:")
    for (var i = 0; i < opponentUnitsArray.length; i++)
        console.log(opponentUnitsArray[i].getActor().type + " " +
                    opponentUnitsArray[i].getRow() + " " +
                    opponentUnitsArray[i].getCol());
}

function getDamageMatrix(unitsArray)//Матрица совокупного урона, который могут нанести юниты из unitsArray
{
    var damageMatrix = new Array
    for (var i = 0; i < fieldRows; i++)
    {
        damageMatrix.push(new Array);
        for (var j = 0; j < fieldColumns; j++)
            damageMatrix[i].push(0);
    }

    for (var k = 0; k < unitsArray.length; k++)
    {
        var unit = unitsArray[k];
        var actor = unit.getActor();
        var ranges = [];
        var damages = [];

        if (actor.primaryAttackRange > actor.secondaryAttackRange)
        {
            ranges = [actor.primaryAttackRange, actor.secondaryAttackRange]
            damages = [actor.primaryAttackDamage, actor.secondaryAttackDamage]
        }
        else
        {
            ranges = [actor.secondaryAttackRange, actor.primaryAttackRange]
            damages = [actor.secondaryAttackDamage, actor.primaryAttackDamage]
        }

        var row = unit.getRow();
        var col = unit.getCol();

        var maxRange = ranges[0];

        var leftBound = Math.max(0, col - maxRange);
        var rightBound = Math.min(fieldColumns - 1, col + maxRange);

        for (var hIter = leftBound; hIter <= rightBound; hIter++)
        {
            var rangeLeft = maxRange - Math.abs(hIter - col);
            var topBound = Math.max(0, row - rangeLeft);
            var bottomBound = Math.min(fieldRows - 1, row + rangeLeft);

            for (var vIter = topBound; vIter <= bottomBound; vIter++)
            {
                var distanse = row + col - hIter - vIter;
                var isInMinRange = distanse <= ranges[1]
                damageMatrix[vIter][hIter] += isInMinRange ? Math.max(damages[0], damages[1]) : damages[0];
            }
        }
    }
    return damageMatrix;
}

function fillCurrentDamageMatrix()
{
    currentDamageMatrix = getDamageMatrix(opponentUnitsArray);
}

function logCurrentDamageMatrix()
{
    fillCurrentDamageMatrix();
    for (var i = 0; i < fieldRows; i++)
    {
        var row = currentDamageMatrix[i].join("\t");
        console.log(row);
    }
}

function Target(unit)
{
    var m_unit = unit;
    var m_damage = 0;

    this.oneShot = false;
    this.getDamage = function()
    {
        return m_damage;
    }

    this.setDamage = function(damage)
    {
        m_damage = damage;
    }
    this.getUnit = function()
    {
        return m_unit;
    }

    this.getActor = function()
    {
        return m_unit.getActor();
    }

    this.getRow = function()
    {
        return m_unit.getRow();
    }

    this.getCol = function()
    {
        return m_unit.getCol();
    }
}

function getAttackableUnitsList(unit)
{
    if(unit == null)
        return null;
    var actor = unit.getActor();
    var row = unit.getRow();
    var col = unit.getCol();
    var listOfUnits = []
    for (var i = 0; i < opponentUnitsArray.length; i++)
    {
        var enemyUnit = opponentUnitsArray[i];
        var distanse = Math.abs(enemyUnit.getRow() - row) + Math.abs(enemyUnit.getCol() - col);
        var isInAttackRange = distanse <= Math.max(actor.primaryAttackRange, actor.secondaryAttackRange);

        if (isInAttackRange)
        {
            var target = new Target(enemyUnit);
            if (distanse <= actor.primaryAttackRange)
                target.setDamage(actor.primaryAttackDamage);
            if (distanse <= actor.secondaryAttackRange)
                target.setDamage(Math.max(target.getDamage(), actor.secondaryAttackDamage));
            listOfUnits.push(target);
        }
    }

    return listOfUnits
}

function logAttackableUnitsList(list)
{
    if (list == null)
        return;
    console.log("ATTACKABLE :");
    if (list.length == 0)
        console.log("NOTHING");
    for (var i = 0; i < list.length; i++)
    {
        var str = list[i].getActor().type + " " + list[i].getRow() + " " +
                  list[i].getCol() + " " +list[i].getDamage().toString();
        console.log(str);
    }
    delete list;
}

function compareTargetsByDamage(first, other, row, col)//Сравнение по наносимому урону(know-how)
{
    first.oneShot = false;
    other.oneShot = false;
    var firstActor = first.getActor();
    var otherActor = other.getActor();
    if (firstActor.averageHealth <= first.getDamage())
    {
        if (otherActor.averageHealth <= other.getDamage())
        {
            if (first.getDamage() > other.getDamage())
                return 1;
            else if (first.getDamage() == other.getDamage())
                return compareCellsByDistanse(first.getRow(), first.getCol(),
                                              other.getRow(), other.getCol(),
                                              row, col);
            else
                return -1;
        }
        else
        {
            first.oneShot = true;
            return 1;
        }
    }

    if (otherActor.averageHealth <= first.getDamage())
    {
        other.oneShot = true;
        return -1;
    }
    if (first.getDamage() > other.getDamage())
        return 1;
    else if (first.getDamage() == other.getDamage())
        return 0;
    else
        return -1;
}

function compareCellsByDistanse(row1, col1, row2, col2, startRow, startCol)//Сравнение по расстоянию до ячейки
{
    var distanse1 = Math.abs(row1 - startRow) + Math.abs(col1 - startCol);
    var distanse2 = Math.abs(row2 - startRow) + Math.abs(col2 - startCol);
    if (distanse1 > distanse2)
        return 1;
    else if (distanse1 == distanse2)
        return 0;
    else
        return -1;
}

function sortAttackArrayDesc(array, row, col)//Сортировка(know-how)
{
    if (array == null)
        return;
    for (var i = 0; i < array.length; i++)
        for (var j = array.length - 1; j > i; j--)
            if (compareTargetsByDamage(array[j], array[j - 1], row, col) == 1)
                swap(array[j], array[j - 1]);
}

function logData()
{
    resetAIData();
    logFieldData();
    logCurrentDamageMatrix();
}

function ableToAttack(target, unit)//Проверка уловия возможности для unit атаковать target
{
    return (target.getDamage() >= multiplier * cellDamage(unit.getRow(), unit.getCol())) || target.oneShot
}

function unitTurn(actor)
{
    if (actor == null)
        return;
    var unit = findUnit(actor, false);
    if (unit == null)
        return;
    var list = getAttackableUnitsList(unit);
    sortAttackArrayDesc(list, unit.getRow, unit.getCol);
    logAttackableUnitsList(list);

    if (list.length > 0 && ableToAttack(list[0], unit))
    {
        var distance = Math.abs(list[0].getRow() - unit.getRow()) + Math.abs(list[0].getCol() - unit.getCol());
        chooseAttack(actor, distance, list[0].getUnit());
    }
    else
        move(unit);
}

function findUnit(actor, isOpponents)//Поиск юнита содержащего в себе actor
{
    if (actor == null)
        return;
    var currentList = isOpponents ? opponentUnitsArray : aiUnitsArray
    for (var i = 0; i < currentList.length; i++)
        if (currentList[i].getActor() == actor)
            return currentList[i];
    return null;
}

function cellDamage(row, col)
{
    return currentDamageMatrix[row][col];
}
//----------------------------Функции атаки---------------------------------------------------------
function prAttackActor(unit)
{
    console.log("Primary attack " + unit.getActor().type + " " +
                unit.getRow() + " " + unit.getCol())
}

function sdAttackActor(unit)
{
    console.log("Secondary attack " + unit.getActor().type + " " +
                unit.getRow() + " " + unit.getCol())
}


function chooseAttack(actor, distance, unit)//Выбор доступной атаки с максимальным уроном
{
    var ranges = []
    var attacks = [prAttackActor, sdAttackActor]
    var damages = []
    if (actor.primaryAttackRange > actor.secondaryAttackRange)
    {
        ranges = [actor.primaryAttackRange, actor.secondaryAttackRange]
        damages = [actor.primaryAttackDamage, actor.secondaryAttackDamage]
    }
    else
    {
        ranges = [actor.secondaryAttackRange, actor.primaryAttackRange]
        damages = [actor.secondaryAttackDamage, actor.primaryAttackDamage]
        attacks = [sdAttackActor, prAttackActor]
    }

    console.debug(damages.join(":"));

    if (distance > ranges[0] || distance <= 0)
        return;
    if (distance <= ranges[1] && damages[1] >= damages[0])
        return attacks[1](unit);

    return attacks[0](unit);
}
//----------------------------Функции перемещения---------------------------------------------------
function Cell(row, col)
{
    var m_row = row
    var m_col = col

    this.getRow = function()
    {
        return m_row;
    }
    this.getCol = function()
    {
        return m_col
    }
}

function move(unit)
{
    var moveList = fillMoveList(unit)
    logMoveList(moveList);
}

function logMoveList(list)
{
    console.log("MOVABLE TO:")
    for (var i = 0; i < list.length; i++)
        console.log(list[i].getRow() + " : " + list[i].getCol());
}

function fillMoveList(unit)
{
    var list = []
    var row = unit.getRow();
    var col = unit.getCol();

    var maxRange = unit.getActor().movingRangeLeft

    var leftBound = Math.max(0, col - maxRange);
    var rightBound = Math.min(fieldColumns - 1, col + maxRange);

    for (var hIter = leftBound; hIter <= rightBound; hIter++)
    {
        var rangeLeft = maxRange - Math.abs(hIter - col);
        var topBound = Math.max(0, row - rangeLeft);
        var bottomBound = Math.min(fieldRows - 1, row + rangeLeft);

        for (var vIter = topBound; vIter <= bottomBound; vIter++)
        {
            var cell = new Cell(vIter, hIter)
            if(cellAbleToMoveTo(cell, unit))
                list.push(cell);
        }
    }
    return list;
}

function cellAbleToMoveTo(cell, unit)
{
    var radius = unit.getActor().movingRangeLeft
    currentGamefield.highlightPossibleCells(unit.getRow(), unit.getCol(), radius, true, "transparent"); //LOL
    var gfCell = currentGamefield.cellAt(cell.getRow(), cell.getCol());
    var able = gfCell.highlighted;
    currentGamefield.highlightPossibleCells(unit.getRow(), unit.getCol(), radius, false);
    return able
}

/* Добавить :
  Для функции nextUnitTurn()
  1. Сделать список юнитов, которые он может атаковать с текущей ячейки;#DONE#
  2. Каждой ячейке из списка сопоставить дамаг из currentDamageMatrix;#DONE# изменено
  3. Список атакуемых юнитов отсортировать по убыванию дамага, учитывая, что если в результате атаки юнит гибнет,
     то необходимо его атаковать в первую очередь (можно не проверять получаемый после атаки дамаг). Если наносимый урон >= C * CCD,
     где CCD - получаемый урон в текущей ячейке, а C - произвольная постоянная, то атакуем, иначе п.4; ##DONE##
  4. Для каждого юнита сделать список из ячеек, в которые он может пойти
  5. Отсортировать список доступных для хода ячеек по возрастанию получаемого дамага,
     затем по дальности от противника (левого или правого края, проверим через actor.reverted):
        a) самые близкие к краю ячейки - приоритетнее;
        б) приоритетнее ячейки, растоложенные на расстоянии moveRange - 1 от юнита, затем moveRange - 2, и т.д.,
           предпоследние по приоритету - крайние, затем текущая;
  6. Если в голове списка - текущая ячейка, то пропуск хода, иначе ходим в ячейку в голове списка.
  Для функции continueTurn()
  1. - 3. Те же
  4. Пропуск хода
  */
