import QtQuick 2.0
import "../../players"

Item
{
    property Player master

    Text
    {
        text: "Level: " + master.level +
              "\nMoney: " + master.money +
              "\nCommander skill: " + master.commanderSkillPoints
    }
}
