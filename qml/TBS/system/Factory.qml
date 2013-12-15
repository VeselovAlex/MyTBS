import QtQuick 2.0
import "../environment"

QtObject
{
    id : factory

    readonly property var actorComponents :
    [
        Qt.createComponent("../actors/Swordsman.qml"),
        Qt.createComponent("../actors/Mage.qml"),
        Qt.createComponent("../actors/Druid.qml"),
        Qt.createComponent("../actors/Archer.qml"),
        Qt.createComponent("../actors/Troll.qml")
    ]
    /* actorComponents contains components of:
     * 0 - Swordman
     * 1 - Mage
     * 2 - Druid
     * 3 - Archer
     * 4 - Troll
     */

    function createActor(idx, parent)
    {
        return actorComponents[idx].createObject(parent);
    }
}

