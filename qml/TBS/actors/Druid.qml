import QtQuick 2.0

Actor
{
    id : druid
    type : "Druid"
    idx: 2

    health: 80
    armor: 4

    attackMultiplier: 1.2
    defenceMultiplier: 1.0

    movingRange: 2

    primaryAttackRange: 3
    primaryAttackDamage: 30

    secondaryAttackRange: 3
    secondaryAttackDamage: -45

    moneyCosts: 50
    spCosts: 35
    count: 0

    isHealer: true

    idleSprite:
        Sprite
        {
            name: "idle"
            source: "qrc:/images/sprites/res/druidIdleSprite" + (reverted ? "Reverted" : "") + ".png";
            frameCount: 1;
            frameWidth: 100;
            frameHeight: 110;
        }
    movingSprite:
        Sprite
        {
            name: "moving"
            source: "qrc:/images/sprites/res/druidMovingSprite" + (reverted ? "Reverted" : "") + ".png"
            to: {"moving": 1}
            reverse: reverted
            frameCount: 12;
            frameWidth: 100;
            frameHeight: 110;
            frameDuration: 120;
        }
    dyingSprite:
        Sprite
        {
            name: "dying"
            source: "qrc:/images/sprites/res/druidDyingSprite" + (reverted ? "Reverted" : "") + ".png"
            reverse: reverted
            duration: frameCount * frameDuration
            frameCount: 9;
            frameWidth: 100;
            frameHeight: 110;
            frameDuration: 180;
        }
    primaryAttackSprite:
        Sprite
        {
            name: "prAttack"
            source: "qrc:/images/sprites/res/druidPrimaryAttackSprite" + (reverted ? "Reverted" : "") + ".png"
            reverse: reverted
            duration: frameCount * frameDuration
            frameCount: 12;
            frameWidth: 100;
            frameHeight: 110;
            frameDuration: 120;
        }
    secondaryAttackSprite:
        Sprite
        {
            name: "sdAttack"
            source: "qrc:/images/sprites/res/druidSecondaryAttackSprite" + (reverted ? "Reverted" : "") + ".png"
            reverse: reverted
            duration: frameCount * frameDuration
            frameCount: 11;
            frameWidth: 100;
            frameHeight: 110;
            frameDuration: 120;
        }
}
