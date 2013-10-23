import QtQuick 2.0

QtObject
{
    property var players : []

    property int playerCount : players.length

    property int firstPlayerIdx : 0
    property int currentTurnPlayer : firstPlayerIdx

    function nextPlayerTurn()
    {
        players[currentTurnPlayer].makeTurn()
        players[1].makeTurn()
    }

    function startPlayersTurns()
    {
        console.debug("ololo");
        nextPlayerTurn();
    }
}
