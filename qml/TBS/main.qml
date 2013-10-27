import QtQuick 2.0
import "environment"
import "environment/buttons"
import "actors"
import "players"
import "system"

Item
{
    width: 1200
    height: 900

    Image
    {
        anchors.fill: parent
        source : "qrc:/images/res/woodBg.png"
    }


    Battle
    {
        id : battle
        width : parent.width
        height : parent.height
        anchors.centerIn: parent
    }

    CloseButton
    {
        id : closeBtn
        width: 50
        anchors.right: parent.right
    }

   LikeButton
    {
        id : like
        width : 50
        anchors.right: closeBtn.left
    }

}
