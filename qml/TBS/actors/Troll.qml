import QtQuick 2.0

Actor
{
    id: troll
    type: "Troll"
    idx: 4

    health: 110
    armor: 6

    attackMultiplier: 1.2
    defenceMultiplier: 1.5

    movingRange: 2

    primaryAttackRange: 2
    primaryAttackDamage: 45

    secondaryAttackRange: 3
    secondaryAttackDamage: 35

    moneyCosts: 45
    spCosts: 20
    count: 0

    isHealer: false

    idleSprite:
    Sprite
    {
        name: "idle"
        source: "qrc:/images/sprites/res/trollIdleSprite" + (reverted ? "Reverted" : "") + ".png";
        frameCount: 1;
        frameWidth: 100;
        frameHeight: 110;
    }
    movingSprite:
    Sprite
    {
        name: "moving"
        source: "qrc:/images/sprites/res/trollMovingSprite" + (reverted ? "Reverted" : "") + ".png";
        reverse: reverted
        frameCount: 14;
        frameWidth: 100;
        frameHeight: 110;
        frameDuration: 80;
    }
    dyingSprite:
    Sprite
    {
        name: "dying"
        source: "qrc:/images/sprites/res/trollDyingSprite" + (reverted ? "Reverted" : "") + ".png";
        reverse: reverted
        duration: frameCount * frameDuration
        frameCount: 11;
        frameWidth: 100;
        frameHeight: 110;
        frameDuration: 100;
    }
    primaryAttackSprite:
        Sprite
        {
            name: "prAttack"
            source: "qrc:/images/sprites/res/trollPrimaryAttackSprite" + (reverted ? "Reverted" : "") + ".png"
            reverse: reverted
            duration: frameCount * frameDuration
            frameCount: 5;
            frameWidth: 100;
            frameHeight: 110;
            frameDuration: 120;
        }
    secondaryAttackSprite:
        Sprite
        {
            name: "sdAttack"
            source: "qrc:/images/sprites/res/trollSecondaryAttackSprite" + (reverted ? "Reverted" : "") + ".png"
            reverse: reverted
            duration: frameCount * frameDuration
            frameCount: 6;
            frameWidth: 100;
            frameHeight: 110;
            frameDuration: 120;
        }
}
