import QtQuick 2.0

Rectangle
{
    //надо поправить ссылки до иконок и их расположение на баре
    //для дебага они будут вылезать во всех клетках. Да и прикрутить их в норм метсо тоже надо
    id: attackBar
    width: cellSide
    height: cellSide
    radius: Math.round(cellSide / 2)
    opacity: 0.3
    property int iconSize: Math.floor(cellSide / 3)
    Rectangle
    {
        id: primaryAttackBtn
        width: iconSize
        height: iconSize
        radius: iconSize / 3
        opacity: 1
        anchors.centerIn: attackBar;
        anchors.horizontalCenterOffset: iconSize
        Image {
            anchors.fill: parent
            source: "../res/primaryAttackButtonIcon.png"

        }
    }
    Rectangle
    {
        id: secondaryAttackBtn
        width: iconSize
        height: iconSize
        radius: iconSize / 3
        //opacity: 1
        anchors.centerIn: attackBar;
        anchors.verticalCenterOffset: -iconSize
        Image {
            anchors.fill: parent
            source: "../res/secondaryAttackButtonIcon.png"
        }
    }
    Rectangle
    {
        id: defenceBtn
        width: iconSize
        height: iconSize
        radius: iconSize / 3
        //opacity: 1
        anchors.centerIn: attackBar;
        anchors.horizontalCenterOffset: -iconSize
        Image {
            anchors.fill: parent
            source: "../res/defenceButtonIcon.png"
        }

    }
    Rectangle
    {
        id: skipBtn
        width: iconSize
        height: iconSize
        radius: iconSize / 3
        //opacity: 1
        anchors.centerIn: attackBar;
        anchors.verticalCenterOffset: iconSize
        Image {
            anchors.fill: parent
            source: "../res/skipButtonIcon.png"

        }
    }

}

