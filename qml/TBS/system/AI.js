.pragma library

var fieldRows
var fieldColumns

var currentOpponent
var currentGamefield

var aiUnitsArray = new Array
var opponentUnitsArray = new Array

var currentDamageMatrix //ТОЛЬКО ДЛЯ ТЕСТА, НАДО БУДЕТ РАЗДЕЛИТЬ НА МАТРИЦЫ НАНОСИМОГО И ПОЛУЧАЕМОГО УРОНА

function Unit(actor, row, col)
{
    var actor = actor;
    var row = row;
    var col = col;
    this.getActor = function()
    {
        return actor;
    }
    this.getRow = function()
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
    var aiDmgMatrix = getDamageMatrix(aiUnitsArray);
    var opponentDmgMatrix = getDamageMatrix(opponentUnitsArray);
    for (var i = 0; i < fieldRows; i++)
        for (var j = 0; j < fieldColumns; j++)
            currentDamageMatrix[i][j] = aiDmgMatrix[i][j] - opponentDmgMatrix[i][j];
}

function logCurrentDamageMatrix()//ТОЛЬКО ДЛЯ ТЕСТА, НАДО БУДЕТ РАЗДЕЛИТЬ НА МАТРИЦЫ НАНОСИМОГО И ПОЛУЧАЕМОГО УРОНА
{
    fillCurrentDamageMatrix();
    for (var i = 0; i < fieldRows; i++)
    {
        var row = currentDamageMatrix[i].join("\t");
        console.log(row);
    }
}
/* Добавить :
  Для функции nextUnitTurn()
  1. Сделать список юнитов, которые он может атаковать с текущей ячейки;
  2. Каждой ячейке из списка сопоставить дамаг из currentDamageMatrix;
  3. Список атакуемых юнитов отсортировать по убыванию дамага, учитывая, что если в результате атаки юнит гибнет,
     то необходимо его атаковать в первую очередь (можно не проверять получаемый после атаки дамаг). Если наносимый урон >= C * CCD,
     где CCD - получаемый урон в текущей ячейке, а C - произвольная постоянная, то атакуем, иначе п.4;
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
