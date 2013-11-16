import QtQuick 2.0

Actor
{
    id : swordsman
    maxHp : 150
    armor : 12

    attackMultiplier : 1.2
    defenceMultiplier : 1.5

    movingRange : 5

    primaryAttackRange : 2
    primaryAttackDamage : 30

    secondaryAttackRange : 1
    secondaryAttackDamage : 50

    moneyCosts : 50
    spCosts : 20
    count : 0

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
