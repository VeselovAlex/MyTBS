import QtQuick 2.0

Actor
{
    id : swordsman

    health : 150
    type : "Swordsman"
    idx : 0
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
        name: "idle"
        //source: "qrc:/images/sprites/res/ninjaMovingSprite" + (reverted ? "Reverted" : "") + ".png";
        source: "qrc:/images/sprites/res/swordsmanIdleSprite" + (reverted ? "Reverted" : "") + ".png";
        frameCount: 1;
        frameX: reverted? 35 : -35
        frameWidth: 125;
        frameHeight: 94;
    }
    movingSprite:
    Sprite
    {
        name: "moving"
        //source: "qrc:/images/sprites/res/ninjaMovingSprite" + (reverted ? "Reverted" : "") + ".png";
        source: "qrc:/images/sprites/res/swordsmanMovingSprite" + (reverted ? "Reverted" : "") + ".png";
        reverse: reverted
        frameX: reverted? 35 : -35
        frameCount: 8;
        frameWidth: 125;
        frameHeight: 94;
        frameDuration: 100;
    }
    dyingSprite:
    Sprite
    {
        name: "dying"
        source: "qrc:/images/sprites/res/swordsmanDyingSprite" + (reverted ? "Reverted" : "") + ".png";
        reverse: reverted
        frameX: reverted? 35 : -35
        frameCount: 7;
        frameWidth: 120;
        frameHeight: 94;
        frameDuration: 100;
    }


    /*primaryAttackSprite: null
    secondaryAttackSprite: null
    movingSprite:  null
    dyingSprite: null*/
}
