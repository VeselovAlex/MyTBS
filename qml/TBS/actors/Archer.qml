import QtQuick 2.0

Actor
{
    id: archer
    type: "Archer"
    idx: 3

    health: 100
    armor: 7

    attackMultiplier: 1.2
    defenceMultiplier: 1.5

    movingRange: 2

    primaryAttackRange: 2
    primaryAttackDamage: 25

    secondaryAttackRange: 4
    secondaryAttackDamage: 55

    moneyCosts: 55
    spCosts: 30
    count: 0

    isHealer: false

    idleSprite :
    Sprite
    {
        name: "idle"
        source: "qrc:/images/sprites/res/archerIdleSprite" + (reverted ? "Reverted" : "") + ".png";
        frameCount: 1;
        frameWidth: 100;
        frameHeight: 110;
    }
    movingSprite:
    Sprite
    {
        name: "moving"
        source: "qrc:/images/sprites/res/archerMovingSprite" + (reverted ? "Reverted" : "") + ".png";
        reverse: reverted
        frameCount: 10;
        frameWidth: 100;
        frameHeight: 110;
        frameDuration: 120;
    }
    dyingSprite:
    Sprite
    {
        name: "dying"
        source: "qrc:/images/sprites/res/archerDyingSprite" + (reverted ? "Reverted" : "") + ".png";
        reverse: reverted
        duration: frameCount * frameDuration
        frameCount: 6;
        frameWidth: 100;
        frameHeight: 110;
        frameDuration: 120;
    }
    primaryAttackSprite:
        Sprite
        {
            name: "prAttack"
            source: "qrc:/images/sprites/res/archerPrimaryAttackSprite" + (reverted ? "Reverted" : "") + ".png"
            reverse: reverted
            duration: frameCount * frameDuration
            frameCount: 7;
            frameWidth: 100;
            frameHeight: 110;
            frameDuration: 120;
        }
    secondaryAttackSprite:
        Sprite
        {
            name: "sdAttack"
            source: "qrc:/images/sprites/res/archerSecondaryAttackSprite" + (reverted ? "Reverted" : "") + ".png"
            reverse: reverted
            duration: frameCount * frameDuration
            frameCount: 12;
            frameWidth: 100;
            frameHeight: 110;
            frameDuration: 120;
        }
}
