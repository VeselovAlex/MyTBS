import QtQuick 2.0

Item
{
    id: healthBar
    width: 80
    height: 5

    property int maxHp

    Rectangle
    {
        id: greenBar
        width: parent.width
        height: parent.height
        color: "green"
    }

    Rectangle
    {
        id :redBar
        anchors.left: greenBar.right
        width: parent.width - greenBar.width
        height: parent.height
        color: "red"
    }

    function update(curHp)
    {
        if (maxHp)
            greenBar.width = Math.round(curHp / maxHp * healthBar.width)
        else
            greenBar.width = healthBar.width
        if (greenBar.width < 0)
            greenBar.width = 0
        redBar.width = healthBar.width - greenBar.width
    }
}
