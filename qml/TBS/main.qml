import QtQuick 2.0
import QtQuick.Window 2.0
import "environment"
import "environment/buttons"
import "system"

Item
{
    width: 1920
    height: 1200

    readonly property url battleScreenPath : "environment/BattleScreen.qml"
    readonly property url startScreenPath  : "environment/StartScreen.qml"

    Image
    {
        anchors.fill: parent
        source : "qrc:/images/res/woodBg.png"
    }

    Loader
    {
        id : startScreen
        width: Screen.width
        height : Screen.height
        onLoaded:
        {
            item.playBtnClicked.connect(loadBattleScreen)
        }
    }

    Loader
    {
        id : battleScreen
        width: Screen.width
        height: Screen.height
        onLoaded:
        {
            item.returnToMenu.connect(loadStartScreen)
        }
    }

    function loadStartScreen()
    {
        battleScreen.setSource("");
        startScreen.setSource(startScreenPath);
    }
	
    function loadBattleScreen()
    {
        battleScreen.setSource(battleScreenPath);
        startScreen.setSource("");
    }

    Component.onCompleted: loadStartScreen();

}
