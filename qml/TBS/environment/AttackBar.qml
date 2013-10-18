import QtQuick 2.0

Item
{
    //надо поправить ссылки до иконок и их расположение на баре
    //для дебага они будут вылезать во всех клетках. Да и прикрутить их в норм метсо тоже надо
    id : attackBar
    width: 200
    height: width

    property int iconSize: Math.floor(attackBar.height / 3)

    signal moveButtonClicked
    signal prAttackButtonClicked
    signal sdAttackButtonClicked
    signal skipButtonClicked
    Rectangle
    {
        id: attackBarBg
        anchors.fill: parent
        radius: width / 2
        opacity: 0.3
    }
    Rectangle
    {
        id: primaryAttackBtn
        width: iconSize
        height: width
        radius: width / 3
        opacity: 1
        anchors.centerIn: attackBar;
        anchors.horizontalCenterOffset: width
        Image
        {
            anchors.fill: parent
            source: "qrc:/images/buttons/res/primaryAttackButtonIcon.png"

        }
        MouseArea
        {
            preventStealing: true
            cursorShape: Qt.PointingHandCursor
            anchors.fill: parent
            onClicked: attackBar.prAttackButtonClicked();
        }
    }
    Rectangle
    {
        id: secondaryAttackBtn
        width: iconSize
        height: width
        radius: width / 3
        //opacity: 1
        anchors.centerIn: attackBar;
        anchors.verticalCenterOffset: -width
        Image
        {
            anchors.fill: parent
            source: "qrc:/images/buttons/res/secondaryAttackButtonIcon.png"
        }
        MouseArea
        {
            preventStealing: true
            anchors.fill: parent
            onClicked: attackBar.sdAttackButtonClicked();
        }
    }
    Rectangle
    {
        id: moveBtn
        width: iconSize
        height: width
        radius: width / 3
        //opacity: 1
        anchors.centerIn: attackBar;
        anchors.horizontalCenterOffset: -width
        Image
        {
            anchors.fill: parent
            source: "qrc:/images/buttons/res/defenceButtonIcon.png"
        }
        MouseArea
        {
            preventStealing: true
            anchors.fill: parent
            onClicked: attackBar.moveButtonClicked();
        }

    }
    Rectangle
    {
        id: skipBtn
        width: iconSize
        height: width
        radius: width / 3
        //opacity: 1
        anchors.centerIn: attackBar;
        anchors.verticalCenterOffset: width
        Image
        {
            anchors.fill: parent
            source: "qrc:/images/buttons/res/skipButtonIcon.png"

        }
        MouseArea
        {
            preventStealing: true
            anchors.fill: parent
            onClicked: attackBar.moveButtonClicked();
        }
    }

}

