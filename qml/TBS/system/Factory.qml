import QtQuick 2.0
import "../environment"

QtObject
{
    id : factory

    readonly property var actorComponents :
    [
        Qt.createComponent("../actors/Swordsman.qml"),
    ]
    /* actorComponents contains components of:
     * 0 - Swordman
     */

    function createActor(idx, parent)
    {
        var ret = actorComponents[idx].createObject(parent);
        return ret;
    }



}
