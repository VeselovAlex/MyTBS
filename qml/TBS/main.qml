import QtQuick 2.0
import QtQuick.Window 2.0
import "environment"
import "environment/buttons"
import "system"

Item
{
    width: 1920
    height: 1080

    readonly property url battleScreenPath : "environment/BattleScreen.qml"
    readonly property url startScreenPath  : "environment/StartScreen.qml"

    StartScreen
    {
        id : startScreen
        width: Screen.width
        height : Screen.height
        onPlayBtnClicked:
        {
            battleScreen.setSource(battleScreenPath);
            visible = false;
        }
    }

    Loader
    {
        id : battleScreen
        width: Screen.width
        height: Screen.height
    }

    focus: true;
    Keys.onEscapePressed: //Временно, пока нет соотв. кнопки
    {
        battleScreen.setSource("")
        startScreen.visible = true;
    }

    CloseButton
    {
        id : closeBtn
        width: 50
        anchors.right: parent.right
    }


    Component.onCompleted: console.debug(width + "x" + height)
}
