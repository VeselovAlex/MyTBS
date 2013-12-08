import QtQuick 2.0

Item
{
    id: healthBar
    width: 80
    height: 5
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
    function update(maxHp, curHp)
    {
        greenBar.width = Math.round(curHp / maxHp * healthBar.width)
        redBar.width = healthBar.width - greenBar.width
    }

}
