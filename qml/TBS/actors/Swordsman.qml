import QtQuick 2.0

Actor
{
    id : swordsman
    health : 150
    armor : 100

    atackMultiplier : 1.2
    defenceMultiplier : 1.5

    movingRange : 2

    primaryAtackRange : 2
    primaryAtackDamage : 30

    secondaryAtackRange : 1
    secondaryAtackDamage : 50

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

    primaryAtackSprite: null
    secondaryAtackSprite: null
    movingSprite:  null
    dyingSprite: null
}
