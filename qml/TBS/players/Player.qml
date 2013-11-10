import QtQuick 2.0
import "../system"
//Основной класс для всех игроков
Item
{
    //id : player
    property bool isEnemy
    //property var playerUnits : Array
    readonly property int maxUnitCount : 5
    property int unitCount : 0
    //property QtObject gameBelongsTo : parent

    property int money : 0
    property int level : 0
    property int attackSkillLevel : 0 //Бафф от развития атакующих умениий
    property int defenceSkillLevel : 0 //Бафф от развития защитных умениий
    property int commanderSkillPoints : 0 //Устанавливает максимальное кол-во юнитов в подчинении пользователя
    property int commanderSPSpent : 0
    property int commanderSPLeft : commanderSkillPoints - commanderSPSpent

    //signal initRequest(var isItEnemy);

    function buyNewUnit(unit, numberToBy)
    {
        if ((commanderSPLeft > 0) && (money > 0) && (numberToBy > 0) && (unitCount < maxUnitCount))
        {
            var count = Math.min(Math.floor(money / unit.moneyCosts),
                                 (Math.floor(commanderSPLeft / unit.spCosts)),
                                 numberToBy);
            unit.count = count;
            money -= count * unit.moneyCosts;
            commanderSPSpent += count * unit.spCosts;
            playerUnits[unitCount] = unit;
            unitCount++;
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
            money -= count * playerUnits[unitIdx].moneyCosts;
            commanderSPSpent += count * playerUnits[unitIdx].spCosts;

        }
    }


    //Component.onCompleted: initRequest(isEnemy);

}

