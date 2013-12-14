import QtQuick 2.0
import "../system/AI.js" as AI

Player
{
    id : enemyPlayer
    isEnemy: true

    function turnExtension()
    {
        AI.logData();
        AI.unitTurn(playerUnits[0]);
    }
}
