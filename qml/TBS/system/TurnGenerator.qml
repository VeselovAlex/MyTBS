import QtQuick 2.0
import "../players"

QtObject
{
    property list<Player> players//Поправить так, чтобы генератор не имел понятия об игроках

    property int playerCount : players.length

    property bool running: turns < 10//For debug only

    property int turns: 0//For debug only

    property int firstPlayerIdx : 0
    property int currentTurnPlayer : (firstPlayerIdx + turns) % playerCount

    function nextPlayerTurn()
    {
        players[currentTurnPlayer].makeTurn();
        turns++;
//        if (running)
//            nextPlayerTurn();
    }

    function start()
    {
        //console.debug("ololo");
        nextPlayerTurn();
    }
}
