import QtQuick 2.0
import "../../players"

Item
{
    property Player master

    Rectangle//Подобрать Картинку
    {
        id : bg
        radius : height / 8
        color: "#4b4747"
        border.color: "#8f421c"
        border.width: 5
        anchors.fill: parent
    }


    Text
    {
        color: "white"
        style: Text.Outline
        styleColor: "black"
        textFormat: Text.StyledText
        anchors.left : parent.left
        anchors.margins: 15
        anchors.top: parent.top;
        anchors.bottom: parent.bottom
        font.family: "Comic Sans MS"
        font.pixelSize: 22

        text: "<b><u>" + (master.isEnemy ? "Enemy" : "Player") + "</b></u>" +
              "<br><b>Money:</b> " + master.money +
              "<br><b>CP:</b> " + master.commanderSPLeft
                                        + "/" + master.commanderSkillPoints

    }

    function update(currentPlayer)
    {
        master = currentPlayer;
    }
}
