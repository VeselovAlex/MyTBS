import QtQuick 2.0
import "../system"
import "buttons"
import QtQuick.Window 2.1

Item
{
    width:Screen.width
    height: Screen.height
    signal returnToMenu
    signal congratPlayer(string winnerName)
    Battle
    {
        id : battle
        width: parent.width
        height: parent.height
        anchors.fill: parent
        onWinner:
        {
            congratPlayer(winner.name)
        }
    }
    ScreenButton
    {
        id : toMenuBtn
        onClicked: quitConfirmDialog.show();
        text : "MAIN MENU"
        width: 200
        anchors.right: parent.right
        anchors.top : parent.top
        anchors.margins: 10
    }

    OKCancelDialog
    {
        id : quitConfirmDialog;
        visible : false
        text : "Are you sure?"

        function show()
        {
            visible = true;
            x = (parent.width - width) / 2;
            y = (parent.height - height) / 2;
            battle.enabled = false;
            toMenuBtn.enabled = false;
        }
        function hide()
        {
            visible = false;
            battle.enabled = true;
            toMenuBtn.enabled = true;
        }

        onDeclined : hide();
        onAccepted: parent.returnToMenu();
    }

}
