//Базовый класс для всех игровых персонажей

import QtQuick 2.0
import "../players"
import "../environment/HUD"

Item
{
    // При создании parent должен быть обьектом Player

    property string type
    property int idx
    // перелопатить все, ибо ИС УГ
    id: actor
    property int health

    property int armor

    property real attackMultiplier: 1.0
    property real defenceMultiplier: 1.0

    property int movingRange //радиус движения
    property int movingRangeLeft: movingRange

    property int primaryAttackRange
    property int primaryAttackDamage

    property int secondaryAttackRange
    property int secondaryAttackDamage

    property int moneyCosts //стоимость единицы в монетах
    property int spCosts //стоимость единицы в очках навыка командира
    property int count: 0 //кол-во юнитов

    property int averageHealth: health * count
    property int averageArmor: armor * count

    property bool isHealer
    //Спрайты для анимации
    property Sprite idleSprite
    property Sprite movingSprite
    property Sprite primaryAttackSprite
    property Sprite secondaryAttackSprite
    property Sprite dyingSprite

    //Свойства для корректного отображения (надо будет реализовать спрайты)

    property bool reverted: parent.isEnemy
    property int speed : 100

    signal died(var actor);

    SequentialAnimation
    {
        running: false;
        id: moveAnimation
        NumberAnimation
        {
            id : horizontalAnimation
            target : actor;
            property : "x";
            easing.type: Easing.Linear
        }
        NumberAnimation
        {
            id : verticalAnimation
            target : actor;
            property : "y";
            easing.type: Easing.Linear
        }
        onStopped:
        {
            actor.x = horizontalAnimation.to;
            actor.y = verticalAnimation.to
            parent.continueTurn();
            sprite.jumpTo(idleSprite.name)
        }
    }

    NumberAnimation {
        id : dieAnimation; target : sprite;
        property: "opacity"; to: 0; duration: dyingSprite.duration;
        easing.type: Easing.InOutQuad; onStopped: {actor.destroy();}
    }

    SpriteSequence
    {
        id: sprite
        anchors.fill: parent
        antialiasing: true
        sprites: [idleSprite, movingSprite, dyingSprite]//, primaryAttackSprite, secondaryAttackSprite, dyingSprite]
    }

    HealthBar
    {
        id: healthBar
    }

    Text
    {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 3
        style: Text.Outline
        styleColor: "white"
        text: count
        color: "red"
        font.bold: true
        height: parent.height / 4
        font.pixelSize: height
        font.family: "Arial"
    }

    BlowUpMsg
    {
        id : msg
    }
    function hurt(damage)
    {
        msg.showMsg((damage > 0)? "-" + damage.toString() : "+" + Math.abs(damage).toString(), "#FFFF0000");
        if (damage > 0) {
            if (averageArmor > 0) {
                averageArmor -= Math.round(defenceMultiplier * damage);
                if (averageArmor < 0) //Если количество единиц брони меньше чем полученный урон
                {
                    averageHealth += averageArmor; // вычтем излишек из запаса здоровья
                    averageArmor = 0;
                    if (averageHealth < 0)
                        die();
                }
            } else {
                averageHealth -= Math.round(defenceMultiplier * damage);
                if (averageHealth < 0)
                    die();
            }
        } else {
            averageHealth -= damage;
            if (averageHealth > health * count)
                averageHealth = health * count;
        }

        healthBar.update(health * count, averageHealth)
    }

    function die()
    {
        sprite.jumpTo(dyingSprite.name);
        msg.showMsg("Пиздец мне...","red");
        dieAnimation.start();
        died(actor);
    }

    function primaryAttack(target) // основная атака
    {
        //sprite.jumpTo(primaryAttackSprite.name);
        target.hurt(primaryAttackDamage * attackMultiplier);
    }

    function secondaryAttack(target)// дополнительная атака, у хилеров - хил
    {
        //sprite.jumpTo(secondaryAttackSprite.name);
        target.hurt(secondaryAttackDamage * attackMultiplier);
    }

    function moveTo(X, Y)
    {
        sprite.jumpTo(movingSprite.name)
        horizontalAnimation.to = X;
        horizontalAnimation.duration = Math.round(X / width * speed)
        verticalAnimation.to = Y;
        verticalAnimation.duration = Math.round(X / height * speed)
        moveAnimation.running = true;
    }

    function getStatAsString()
    {
        return  idx.toString()              + " " +
                count.toString()            + " " +
                averageHealth.toString()    + " " +
                averageArmor.toString()     + " " ;
    }

}
