import QtQuick 2.0

Actor
{
    id : mage
    type : "Mage"
    idx : 1
    //maxHp : 60
    health: 60
    armor : 4

    attackMultiplier : 1.2
    defenceMultiplier : 1.0

    movingRange : 2

    primaryAttackRange : 2
    primaryAttackDamage : 15

    secondaryAttackRange : 4
    secondaryAttackDamage : 75

    moneyCosts : 50
    spCosts : 20
    count : 0

    isHealer: false

    idleSprite :
        Sprite
        {
            name: "idle"
            source: "qrc:/images/sprites/res/mageIdleSprite" + (reverted ? "Reverted" : "") + ".png";
            frameCount: 1;
            frameWidth: 102;
            frameHeight: 90;
            //frameDuration: 150;
        }
    movingSprite:
        Sprite
        {
            name: "moving"
            source: "qrc:/images/sprites/res/mageMovingSprite" + (reverted ? "Reverted" : "") + ".png"
            to: {"moving": 1}
            reverse: reverted
            frameCount: 7;
            frameWidth: 102;
            frameHeight: 75;
            frameDuration: 120;
        }
    dyingSprite:
        Sprite
        {
            name: "dying"
            source: "qrc:/images/sprites/res/mageDyingSprite" + (reverted ? "Reverted" : "") + ".png"
            reverse: reverted
            duration: frameCount * frameDuration
            //to: {"dying": 1}
            frameCount: 10;
            frameWidth: 102;
            frameHeight: 106;
            frameDuration: 180;
        }

    /*primaryAttackSprite: null
    secondaryAttackSprite: null
    movingSprite:  null
    dyingSprite: null*/
}
