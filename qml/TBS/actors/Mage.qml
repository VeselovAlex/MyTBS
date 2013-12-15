import QtQuick 2.0

Actor
{
    id: mage
    type: "Mage"
    idx: 1

    health: 60
    armor: 4

    attackMultiplier: 1.2
    defenceMultiplier: 1.0

    movingRange: 2

    primaryAttackRange: 2
    primaryAttackDamage: 20

    secondaryAttackRange: 4
    secondaryAttackDamage: 80

    moneyCosts: 50
    spCosts: 50
    count: 0

    isHealer: false

    idleSprite:
        Sprite
        {
            name: "idle"
            source: "qrc:/images/sprites/res/mageIdleSprite" + (reverted ? "Reverted" : "") + ".png";
            frameCount: 1;
            frameWidth: 107;
            frameHeight: 107;
        }
    movingSprite:
        Sprite
        {
            name: "moving"
            source: "qrc:/images/sprites/res/mageMovingSprite" + (reverted ? "Reverted" : "") + ".png"
            to: {"moving": 1}
            reverse: reverted
            frameCount: 7;
            frameWidth: 108;
            frameHeight: 107;
            frameDuration: 120;
        }
    dyingSprite:
        Sprite
        {
            name: "dying"
            source: "qrc:/images/sprites/res/mageDyingSprite" + (reverted ? "Reverted" : "") + ".png"
            reverse: reverted
            duration: frameCount * frameDuration
            frameCount: 10;
            frameX: 15
            frameWidth: 103;
            frameHeight: 107;
            frameDuration: 120;
        }
    primaryAttackSprite:
        Sprite
        {
            name: "prAttack"
            source: "qrc:/images/sprites/res/magePrimaryAttackSprite" + (reverted ? "Reverted" : "") + ".png"
            reverse: reverted
            duration: frameCount * frameDuration
            frameCount: 6;
            frameX: reverted? 35 : -10
            frameWidth: 103;
            frameHeight: 107;
            frameDuration: 120;
        }
    secondaryAttackSprite:
        Sprite
        {
            name: "sdAttack"
            source: "qrc:/images/sprites/res/mageSecondaryAttackSprite" + (reverted ? "Reverted" : "") + ".png"
            reverse: reverted
            duration: frameCount * frameDuration
            frameCount: 6;
            frameX: reverted? 35 : -10
            frameWidth: 103;
            frameHeight: 107;
            frameDuration: 120;
        }

}
