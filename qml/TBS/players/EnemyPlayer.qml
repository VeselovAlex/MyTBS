import QtQuick 2.0
import "../system/AI.js" as AI

Player
{
    id : enemyPlayer
    isEnemy: true

    function turnExtension()
    {
        AI.initAiData();
        AI.getFieldData();
        AI.logFieldData();
        AI.logCurrentDamageMatrix();
    }
}
