import QtQuick 2.0

Actor
{
    health : 150
    armor : 100


    atackMultiplier : 1.2
    defenceMultiplier : 1.5

    movingRange : 2

    primaryAtackRange : 2
    primaryAtackDamage : 30

    secondaryAtackRange : 1
    secondaryAtackDamage : 50

    idleSprite :
        Sprite
        {
            source: "../../../../MyTBS/res/ninjaSprite.png";
            frameCount: 13;
            frameWidth: 90;
            frameHeight: 100;
            frameDuration: 80;
        }

    primaryAtackSprite: null
    secondaryAtackSprite: null
    movingSprite:  null
    dyingSprite: null
}
