import QtQuick 2.0
import "environment"
import "actors"

Item {
    width: 1200
    height: 900

    property var actorComponents : [Qt.createComponent("actors/Swordsman.qml")]
    Image
    {
        id : bgImage
        anchors.fill: parent
        source : "qrc:/images/res/woodBg.png"
    }


    GameField
    {
        z: 0
        anchors.centerIn: parent
        id : gameField
        rows: 7
        columns : 10
        cellSide: 80
        property var previousHighlighted : null
        onCellClicked:
        {
            var targetCell = cellAt(row, col)
            console.debug("Click on:" + targetCell.x + ";" + targetCell.y);
            if (!targetCell.empty)
            {
                attackMenu.parent = targetCell.occupiedBy;
                attackMenu.z = targetCell.z + 1;
                attackMenu.anchors.centerIn = attackMenu.parent
                attackMenu.visible = true;
                attackMenu.enabled = true;
            }

        }

        Component.onCompleted: defaultActors();

    }

    AttackBar
    {
        id : attackMenu
        visible: false
        width : gameField.cellSide * 1.5
        enabled: false
        onPrAttackButtonClicked: console.debug("Primary Attack")
        z : 1;
    }


    function defaultActors()
    {
        var actor = actorComponents[0].createObject(gameField.cellAt(1,2));
        gameField.occupyCell(actor, 1, 2)
    }

    Rectangle
    {
        id : exitButton
        width: 50
        height: 50
        anchors.right: parent.right
        color: "transparent"
        Image
        {
            anchors.fill: parent
            source: "qrc:/images/buttons/res/exitButton.png"
        }
        MouseArea
        {
            hoverEnabled: true
            anchors.fill: parent

            onHoveredChanged: parent.color = containsMouse ? "#40C0C0C0" : "transparent"
            //цвет - "#OORRGGBB", где OO - прозрачность
            onClicked: Qt.quit();
        }
    }


}
