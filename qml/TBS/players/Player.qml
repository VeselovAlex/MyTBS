import QtQuick 2.0
import DataFile 1.0
import "../system"
import "../system/Turns.js" as PlayerTurns
//Основной класс для всех игроков
Item
{
    id : abstractPlayer
    property string name
    property bool isEnemy: false
    property var playerUnits : []
    readonly property int maxUnitCount : 5
    property int unitCount : playerUnits.length

    property int money : 0
    property int level : 0
    property int attackSkillLevel : 0 //Бафф от развития атакующих умениий
    property int defenceSkillLevel : 0 //Бафф от развития защитных умениий
    property int commanderSkillPoints : 0 //Устанавливает максимальное кол-во юнитов в подчинении пользователя
    property int commanderSPSpent : 0
    property int commanderSPLeft : commanderSkillPoints - commanderSPSpent

    property string dataFileSource
    signal turnFinished
    signal gameOver
    File
    {
        id : file;
    }

    function savePlayerData()
    {
        file.loadFileForWriting(dataFileSource);
        file.write(name);
        file.write(money.toString());
        file.write(commanderSkillPoints.toString());
        file.write(commanderSPLeft.toString());
        for (var i = 0; i < unitCount; i++)
        {
            file.write(playerUnits[i].getStatAsString());
        }
        file.write("finish");
        file.close();
    }
    function loadPlayerData(factory)
    {
        file.loadFileForReading(dataFileSource);
//        name = file.read();
        money = parseInt(file.read());
        commanderSkillPoints = parseInt(file.read());
        commanderSPLeft = parseInt(file.read());
        var string = file.read();
        while (string !== "finish")
        {
            var idx = parseInt(string);
            var actor = factory.createActor(idx, abstractPlayer);
            if (actor == null)
                console.log("Error data reading");
            string = file.read();
            actor.count = parseInt(string);
            string = file.read();
            actor.averageHealth = parseInt(string);
            string = file.read();
            actor.averageArmor = parseInt(string);
            playerUnits[unitCount++] = actor;
            string = file.read();
        }
        console.log("Loaded " + name);
        file.close();
    }

    function createConnection()
    {
        for (var i = 0; i < unitCount; i++)
        {
            playerUnits[i].died.connect(PlayerTurns.unitDied);
        }
    }

    function buyNewUnit(unit, numberToBy)
    {
        if ((commanderSPLeft > 0) && (money > 0) && (numberToBy > 0) && (unitCount < maxUnitCount))
        {
            var count = Math.min(Math.floor(money / unit.moneyCosts),
                                 (Math.floor(commanderSPLeft / unit.spCosts)),
                                 numberToBy);
            unit.count = count;

            abstractPlayer.money -= count * unit.moneyCosts;
            abstractPlayer.commanderSPSpent += count * unit.spCosts;
            abstractPlayer.playerUnits[unitCount] = unit;
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
            abstractPlayer.money -= count * playerUnits[unitIdx].moneyCosts;
            abstractPlayer.commanderSPSpent += count * playerUnits[unitIdx].spCosts;
        }
    }
    function makeTurn()
    {
        if (unitCount <= 0)
        {
            gameOver();
            return;
        }

        PlayerTurns.currentPlayer = abstractPlayer;
        PlayerTurns.playerStatWgt.update(PlayerTurns.currentPlayer);
        PlayerTurns.currentUnitIdx = 0;
        PlayerTurns.nextUnitTurn();
        turnExtension();
    }
    function continueTurn()
    {
        PlayerTurns.continueTurn();
    }
    function turnExtension()
    {

    }
}

