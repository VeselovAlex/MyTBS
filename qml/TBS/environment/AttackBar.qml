import QtQuick 2.0
import "buttons"

Item
{
    id: attackBar
    width: 80
    height: width

    signal moveButtonClicked
    signal prAttackButtonClicked
    signal sdAttackButtonClicked
    signal skipButtonClicked

    signal moveButtonChosen
    signal prAttackButtonChosen
    signal sdAttackButtonChosen
    signal skipButtonChosen

    property bool moveButtonChosen : false
    property bool prAttackButtonChosen : false
    property bool sdAttackButtonChosen : false
    property bool skipButtonChosen : false

    Image
    {
        anchors.fill: parent
        source: "qrc:/images/buttons/res/attackBarBG.png"
        opacity: 0.7
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

    function enableAttackBar()
    {
        visible = true;
        enabled = true;
    }
    function disableAttackBar()
    {
        visible = false;
        enabled = false;
    }
}
