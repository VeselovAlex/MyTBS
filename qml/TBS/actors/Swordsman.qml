import QtQuick 2.0

Actor
{
    id : swordsman

    health : 150
    type : "Swordsman"
    armor : 12

    attackMultiplier : 1.2
    defenceMultiplier : 1.5

    movingRange : 2

    primaryAttackRange : 2
    primaryAttackDamage : 50

    secondaryAttackRange : 4
    secondaryAttackDamage : 30

    moneyCosts : 50
    spCosts : 20
    count : 0

    isHealer: false

    idleSprite :
        Sprite
        {
            source: "qrc:/images/sprites/res/ninjaMovingSprite" + (reverted ? "Reverted" : "") + ".png";
            frameCount: 5;
            frameWidth: 128;
            frameHeight: 128;
            frameDuration: 80;
        }

    /*primaryAttackSprite: null
    secondaryAttackSprite: null
    movingSprite:  null
    dyingSprite: null*/
}
