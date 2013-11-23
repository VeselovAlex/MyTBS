import QtQuick 2.0
import "buttons"
import "../system/Turns.js" as Turns

Item
{
    id: attackBar
    width: 80
    height: width

    signal moveButtonClicked
    signal prAttackButtonClicked
    signal sdAttackButtonClicked
    signal skipButtonClicked

    Image
    {
        anchors.fill: parent
        source: "qrc:/images/buttons/res/attackBarBG.png"
        opacity: 0.3
    }
    AttackBarButton
    {
        id: primaryAttackBtn
        anchors.centerIn: attackBar;
        anchors.horizontalCenterOffset: iconSize
        imageSource: "qrc:/images/buttons/res/primaryAttackButtonIcon.png"
        onAttackBarButtonClicked: prAttackButtonClicked()
    }
    AttackBarButton
    {
        id: secondaryAttackBtn
        anchors.centerIn: attackBar;
        anchors.verticalCenterOffset: -iconSize
        imageSource: "qrc:/images/buttons/res/secondaryAttackButtonIcon.png"
        onAttackBarButtonClicked: sdAttackButtonClicked()
    }
    AttackBarButton
    {
        id: moveBtn
        anchors.centerIn: attackBar;
        anchors.horizontalCenterOffset: -iconSize
        imageSource: "qrc:/images/buttons/res/moveButtonIcon.png"
        onAttackBarButtonClicked: moveButtonClicked()
    }
    AttackBarButton
    {
        id:skipTurnBtn
        anchors.centerIn: attackBar;
        anchors.verticalCenterOffset: iconSize
        imageSource: "qrc:/images/buttons/res/skipButtonIcon.png"
        onAttackBarButtonClicked: skipButtonClicked()
    }

    function enableAttackBar(X, Y)
    {
        x = X;
        y = Y;
        z = 2;
        visible = true;
        enabled = true;
    }
    function disableAttackBar()
    {
        x = -width;
        y = -height;
        visible = false;
        enabled = false;
    }
}
