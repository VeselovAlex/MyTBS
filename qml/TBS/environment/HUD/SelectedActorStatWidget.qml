import QtQuick 2.0
import "../../actors"
Item
{
    property Actor selected

    Rectangle//Подобрать Картинку
    {
        id : bg
        radius : height / 8
        color: "#4b4747"
        border.color: "#8f421c"
        border.width: 5
        anchors.fill: parent
    }


    Rectangle//Картинка
    {
        id : pictureFrame
        color : "lightgrey"
        border.color: "#75340b"
        border.width: 2
        radius: height / 16

        width: height
        anchors.margins: 20
        anchors.left: parent.left;
        anchors.top: parent.top;
        anchors.bottom: parent.bottom

        SpriteSequence
        {
            id : picture
            sprites : selected == null ? [] : [selected.idleSprite]
            running: false

            anchors.fill: parent
        }
    }

    Text
    {
        color: "white"
        style: Text.Outline
        styleColor: "black"
        textFormat: Text.StyledText
        anchors.left : pictureFrame.right
        anchors.margins: 15
        anchors.top: parent.top;
        anchors.bottom: parent.bottom
        font.family: "Comic Sans MS"
        font.pixelSize: 22

        text: "<b><u>" + selected.type + "</b></u>" +
              "<br><b>Health:</b> " + selected.health + "/" + selected.averageHealth +
              "<br><b>Armor:</b> " + selected.armor + "/" + selected.averageArmor +
              "<br><b>Cost:</b> " + selected.moneyCosts + "$/" + selected.spCosts + " cp" +
              "<br><b>Attack:</b> " + selected.primaryAttackDamage + "/" + selected.secondaryAttackDamage

    }

    function update(currentActor)
    {
        selected = currentActor;
        picture.running = true;
    }

}
