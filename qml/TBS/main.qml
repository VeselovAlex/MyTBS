import QtQuick 2.0
import QtQuick.Window 2.1
import QtMultimedia 5.0
import "environment"
import "environment/buttons"
import "system"

Item
{
    width: 1920
    height: 1080

    readonly property url battleScreenPath : "environment/BattleScreen.qml"
    readonly property url startScreenPath  : "environment/StartScreen.qml"
    readonly property url winScreenPath  : "environment/WinScreen.qml"

    Image
    {
        anchors.fill: parent
        //source : "qrc:/images/res/woodBg.png"
        source : "qrc:/images/res/BackGround.png"
    }

    MuteButton
    {
        width: 70;
        height : width;
        anchors.top : parent.top;
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 15
        onMute: music.muted = enabled
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
            item.congratPlayer.connect(loadWinScreen)
            item.returnToMenu.connect(loadStartScreen)
        }
    }

    Loader
    {
        id : winScreen
        width: Screen.width
        height: Screen.height
        onLoaded:
        {
            item.playBtnClicked.connect(loadBattleScreen)
        }
    }

    SoundEffect
    {
        id : music
        source: "qrc:/sounds/res/bgSoung.wav"
        loops: 3
        volume : 0.8
        onLoadedChanged:
        {
            music.play();
        }
        onLoopsRemainingChanged:
        {
            if (loopsRemaining <= 2)
                loops += 50;
        }
    }
    function loadStartScreen()
    {
        battleScreen.setSource("");
        winScreen.setSource("");
        startScreen.setSource(startScreenPath);
    }
	
    function loadBattleScreen()
    {
        battleScreen.setSource(battleScreenPath);
        winScreen.setSource("");
        startScreen.setSource("");
    }

    function loadWinScreen(winner)
    {
        winScreen.setSource(winScreenPath);
        battleScreen.setSource("");
        startScreen.setSource("");
        winScreen.item.congratulate(winner);
    }

    Component.onCompleted:
    {
        loadStartScreen();
    }

}
