//Базовый класс для всех игровых персонажей

import QtQuick 2.0

Item
{
    property int health
    property int armor


    property real atackMultiplier : 1.0
    property real defenceMultiplier : 1.0

    property int movingRange

    property int primaryAtackRange
    property int primaryAtackDamage

    property int secondaryAtackRange
    property int secondaryAtackDamage

    property Sprite idleSprite
    property Sprite movingSprite
    property Sprite primaryAtackSprite
    property Sprite secondaryAtackSprite
    property Sprite dyingSprite

    SpriteSequence
    {
        id : sprite
        anchors.fill: parent
        sprites: [idleSprite, movingSprite, primaryAtackSprite, secondaryAtackSprite, dyingSprite]
    }

    function hurt(damage)
    {
        if (armor > 0)
        {
            armor -= Math.round(defenceMultiplier * damage);
            if (armor < 0) //Если количество единиц брони меньше чем полученный урон
            {
                health += armor; // вычтем излишек из запаса здоровья
                armor = 0;
            }
        }
        else
        {
            health -= Math.round(defenceMultiplier * damage);
            if (health < 0)
                die();
        }
    }

    function die()
    {
        sprite.jumpTo(dyingSprite.name)
        destroy();
    }

    function primaryAtack(target) // основная атака
    {
        sprite.jumpTo(primaryAtackSprite.name);
        target.hurt(primaryAtackDamage * atackMultiplier);
    }

    function secondaryAtack(target)// дополнительная атака
    {
        sprite.jumpTo(secondaryAtackSprite.name);
        target.hurt(secondaryAtackDamage * atackMultiplier);
    }
}
