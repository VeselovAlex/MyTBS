//Базовый класс для всех игровых персонажей

import QtQuick 2.0

Item
{
    property int health
    property int armor

    property real atackMultiplier : 1.0
    property real defenceMultiplier : 1.0

    property int movingRange//радиус движения

    property int primaryAtackRange
    property int primaryAtackDamage

    property int secondaryAtackRange
    property int secondaryAtackDamage

    property int moneyCosts //стоимость единицы в монетах
    property int spCosts //стоимость единицы в очках навыка командира
    property int count : 0 //кол-во юнитов

    property int averageHealth: health * count
    property int averageArmor: armor * count

    //Спрайты для анимации
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
        if (averageArmor > 0)
        {
            averageArmor -= Math.round(defenceMultiplier * damage);
            if (averageArmor < 0) //Если количество единиц брони меньше чем полученный урон
            {
                averageHealth += averageArmor; // вычтем излишек из запаса здоровья
                averageArmor;
            }
        }
        else
        {
            averageHealth -= Math.round(defenceMultiplier * damage);
            if (averageHealth < 0)
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
