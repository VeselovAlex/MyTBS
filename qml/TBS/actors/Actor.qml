//Базовый класс для всех игровых персонажей

import QtQuick 2.0
import "../players"
import "../environment"

Item
{
    // При создании parent должен быть обьектом Player
    //property Player belongsTo : parent
    property bool belongsToEnemy : false

    property int maxHp
    property int health : maxHp
    property int armor

    property real attackMultiplier : 1.0
    property real defenceMultiplier : 1.0

    property int movingRange//радиус движения
    property int movingRangeLeft : movingRange

    property int primaryAttackRange
    property int primaryAttackDamage

    property int secondaryAttackRange
    property int secondaryAttackDamage

    property int moneyCosts //стоимость единицы в монетах
    property int spCosts //стоимость единицы в очках навыка командира
    property int count : 0 //кол-во юнитов

    property int averageHealth: health * count
    property int averageArmor: armor * count

    property int curRow : 0
    property int curCol : 0

    HealthBar
    {
        id: healthBar
        visible: true
    }
    function changeHpInfo()
    {
        healthBar.changeHpInfo(maxHp * count, averageHealth)
    }

    //Спрайты для анимации
    property Sprite idleSprite
    property Sprite movingSprite
    property Sprite primaryAttackSprite
    property Sprite secondaryAttackSprite
    property Sprite dyingSprite

    //Свойства для корректного отображения (надо будет реализовать спрайты)
    //property bool reverted: belongsTo.isEnemy
    property bool reverted : belongsToEnemy

    SpriteSequence
    {
        id : sprite
        anchors.fill: parent
        antialiasing: true
        sprites: [idleSprite]//, movingSprite, primaryAttackSprite, secondaryAttackSprite, dyingSprite]
    }

    function hurt(damage)
    {
        if (averageArmor > 0)
        {
            averageArmor -= Math.round(defenceMultiplier * damage);
            if (averageArmor < 0) //Если количество единиц брони меньше чем полученный урон
            {
                averageHealth += averageArmor; // вычтем излишек из запаса здоровья
                averageArmor = 0;
                if (averageHealth < 0)
                    die();
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
        //sprite.jumpTo(dyingSprite.name)
        destroy();
    }

    function primaryAttack(target) // основная атака
    {
        sprite.jumpTo(primaryAttackSprite.name);
        target.hurt(primaryAttackDamage * AttackMultiplier);
    }

    function secondaryAttack(target)// дополнительная атака
    {
        sprite.jumpTo(secondaryAttackSprite.name);
        target.hurt(secondaryAttackDamage * AttackMultiplier);
    }

}
