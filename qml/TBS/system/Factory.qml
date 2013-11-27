import QtQuick 2.0
import "../environment"

QtObject
{
    id : factory

    readonly property var actorComponents :
    [
        Qt.createComponent("../actors/Swordsman.qml"),
        Qt.createComponent("../actors/Mage.qml")
    ]
    /* actorComponents contains components of:
     * 0 - Swordman
     * 1 - Mage
     */

    function createActor(idx, parent)
    {
        return actorComponents[idx].createObject(parent);
    }
}
