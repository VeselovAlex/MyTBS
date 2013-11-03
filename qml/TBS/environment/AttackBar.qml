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
    }
    // ахтунг. копипаста
    AttackBarButton
    {
        id: primaryAttackBtn
        anchors.centerIn: attackBar;
        anchors.horizontalCenterOffset: iconSize
        imageSource: "qrc:/images/buttons/res/primaryAttackButtonIcon.png"
        MouseArea
        {
            onClicked: prAttackButtonClicked();
            hoverEnabled: true
            anchors.fill: parent
            preventStealing: true
            cursorShape: Qt.PointingHandCursor
            onHoveredChanged: parent.color = containsMouse ? "#40CF0721" : "transparent"
            //цвет - "#OORRGGBB", где OO - прозрачность
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
            onClicked: sdAttackButtonClicked();
            hoverEnabled: true
            anchors.fill: parent
            preventStealing: true
            cursorShape: Qt.PointingHandCursor
            onHoveredChanged: parent.color = containsMouse ? "#40CF0721" : "transparent"
            //цвет - "#OORRGGBB", где OO - прозрачность
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
            onClicked: moveButtonClicked();
            hoverEnabled: true
            anchors.fill: parent
            preventStealing: true
            cursorShape: Qt.PointingHandCursor
            onHoveredChanged: parent.color = containsMouse ? "#40CF0721" : "transparent"
            //цвет - "#OORRGGBB", где OO - прозрачность
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
            onClicked: skipButtonClicked();
            hoverEnabled: true
            anchors.fill: parent
            preventStealing: true
            cursorShape: Qt.PointingHandCursor
            onHoveredChanged: parent.color = containsMouse ? "#40CF0721" : "transparent"
            //цвет - "#OORRGGBB", где OO - прозрачность

        }
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
