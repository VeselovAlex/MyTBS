import QtQuick 2.0

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
    }
    AttackBarButton
    {
        id: primaryAttackBtn
        anchors.centerIn: attackBar;
        anchors.horizontalCenterOffset: iconSize
        imageSource: "qrc:/images/buttons/res/primaryAttackButtonIcon.png"
        MouseArea
        {
            onClicked: attackBar.prAttackButtonClicked();
        }
    }
    AttackBarButton
    {
        id: secondaryAttackBtn
        anchors.centerIn: attackBar;
        anchors.verticalCenterOffset: -iconSize
        imageSource: "qrc:/images/buttons/res/secondaryAttackButtonIcon.png"
        MouseArea
        {
            onClicked: attackBar.sdAttackButtonClicked();
        }
    }
    AttackBarButton
    {
        id: moveBtn
        anchors.centerIn: attackBar;
        anchors.horizontalCenterOffset: -iconSize
        imageSource: "qrc:/images/buttons/res/moveButtonIcon.png"
        MouseArea
        {
            onClicked: attackBar.moveButtonClicked();
        }
    }
    AttackBarButton
    {
        id:skipTurnBtn
        anchors.centerIn: attackBar;
        anchors.verticalCenterOffset: iconSize
        imageSource: "qrc:/images/buttons/res/skipButtonIcon.png"
        MouseArea
        {
            onClicked: attackBar.skipButtonClicked();
        }
    }
}
