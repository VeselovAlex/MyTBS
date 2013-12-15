import QtQuick 2.0

Actor
{
    id: swordsman
    type: "Swordsman"
    idx: 0

    health: 150
    armor: 12

    attackMultiplier: 1.2
    defenceMultiplier: 1.5

    movingRange: 2

    primaryAttackRange: 2
    primaryAttackDamage: 50

    secondaryAttackRange: 4
    secondaryAttackDamage: 30

    moneyCosts: 65
    spCosts: 20
    count: 0

    isHealer: false

    idleSprite :
    Sprite
    {
        name: "idle"
        source: "qrc:/images/sprites/res/swordsmanIdleSprite" + (reverted ? "Reverted" : "") + ".png";
        frameCount: 1;
        frameWidth: 111;
        frameHeight: 111;
    }
    movingSprite:
    Sprite
    {
        name: "moving"
        source: "qrc:/images/sprites/res/swordsmanMovingSprite" + (reverted ? "Reverted" : "") + ".png";
        reverse: reverted
        frameCount: 8;
        frameWidth: 125;
        frameHeight: 111;
        frameDuration: 100;
    }
    dyingSprite:
    Sprite
    {
        name: "dying"
        source: "qrc:/images/sprites/res/swordsmanDyingSprite" + (reverted ? "Reverted" : "") + ".png";
        reverse: reverted
        duration: frameCount * frameDuration
        frameCount: 7;
        frameWidth: 120;
        frameHeight: 111;
        frameDuration: 120;
    }
    primaryAttackSprite:
        Sprite
        {
            name: "prAttack"
            source: "qrc:/images/sprites/res/swordsmanPrimaryAttackSprite" + (reverted ? "Reverted" : "") + ".png"
            reverse: reverted
            duration: frameCount * frameDuration
            frameCount: 6;
            frameWidth: 120;
            frameHeight: 111;
            frameDuration: 120;
        }
    secondaryAttackSprite:
        Sprite
        {
            name: "sdAttack"
            source: "qrc:/images/sprites/res/swordsmanSecondaryAttackSprite" + (reverted ? "Reverted" : "") + ".png"
            reverse: reverted
            duration: frameCount * frameDuration
            frameCount: 6;
            frameWidth: 120;
            frameHeight: 111;
            frameDuration: 120;
        }
}
