import QtQuick 2.0
//Основной класс для всех игроков
QtObject
{
    id : player
    property bool isEnemy: false
    property var playerUnits : null
    readonly property int maxUnitCount : 5
    property int freeCellIdx : 0
    property QtObject gameBelongsTo

    property int money : 0
    property int level : 0
    property int attackSkillLevel : 0 //Бафф от развития атакующих умениий
    property int defenceSkillLevel : 0 //Бафф от развития защитных умениий
    property int commanderSkillPoints : 0 //Устанавливает максимальное кол-во юнитов в подчинении пользователя
    property int commanderSPSpent : 0
    property int commanderSPLeft : commanderSkillPoints - commanderSPSpent


    function makeTurn()
    {
        for (var i = 0; i < freeCellIdx; i++)
        {
            playerUnits[i].turn()
        }
        if (freeCellIdx == 0)
        {
            //Заканчиваем игру
            gameBelongsTo.end();
        }
    }


    function buyNewUnit(unit, numberToBy)
    {
        if ((commanderSPLeft > 0) && (money > 0) && (numberToBy > 0) && (freeCellIdx < maxUnitCount))
        {
            var count = Math.min(Math.floor(money / unit.moneyCosts),
                                 (Math.floor(commanderSPLeft / unit.spCosts)),
                                 numberToBy);
            unit.count = count;
            player.money -= count * unit.moneyCosts;
            player.commanderSPSpent += count * unit.spCosts;
            playerUnits[freeCellIdx] = unit;
            freeCellIdx++;
        }
    }

    function buyMoreExistingUnits(unitIdx, numberToBy)
    {
        if ((commanderSPLeft > 0) && (money > 0) && (numberToBy > 0) && (unitIdx < maxUnitCount))
        {
            var count = Math.min(Math.floor(money / playerUnits[unitIdx].moneyCosts),
                                 (Math.floor(commanderSPLeft / playerUnits[unitIdx].spCosts)),
                                 numberToBy);
            playerUnits[unitIdx].count = count;
            player.money -= count * playerUnits[unitIdx].moneyCosts;
            player.commanderSPSpent += count * playerUnits[unitIdx].spCosts;

        }
    }

    function initPlayer()
    {

    }

    Component.onCompleted: initPlayer();

}

