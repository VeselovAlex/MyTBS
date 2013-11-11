import QtQuick 2.0
//Основной класс для всех игроков
Item
{
    id : player
    property bool isEnemy: false
    property var playerUnits : []
    readonly property int maxUnitCount : 5
    property int unitCount : 0

    property int money : 0
    property int level : 0
    property int attackSkillLevel : 0 //Бафф от развития атакующих умениий
    property int defenceSkillLevel : 0 //Бафф от развития защитных умениий
    property int commanderSkillPoints : 0 //Устанавливает максимальное кол-во юнитов в подчинении пользователя
    property int commanderSPSpent : 0
    property int commanderSPLeft : commanderSkillPoints - commanderSPSpent


    function buyNewUnit(unit, numberToBy)
    {
        if ((commanderSPLeft > 0) && (money > 0) && (numberToBy > 0) && (unitCount < maxUnitCount))
        {
            var count = Math.min(Math.floor(money / unit.moneyCosts),
                                 (Math.floor(commanderSPLeft / unit.spCosts)),
                                 numberToBy);
            unit.count = count;
            player.money -= count * unit.moneyCosts;
            player.commanderSPSpent += count * unit.spCosts;
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
            player.money -= count * playerUnits[unitIdx].moneyCosts;
            player.commanderSPSpent += count * playerUnits[unitIdx].spCosts;

        }
    }

    function makeTurn()
    {
        console.log((isEnemy ? "Enemy" : "Player") + " turns");
    }

}

