import QtQuick 2.0
import "buttons"

Rectangle {
    width: 300
    height: 200
    radius : Math.min(width, height) / 10
    color : "#3e3737"
    border.width: 2
    border.color: "#581b0d"

    signal accepted;
    signal declined;

    property alias text: msg.text
    Text
    {
        id :msg
        font.pixelSize: 28
        color : "#b33807"
        style: Text.Outline
        styleColor: "#581b0d"
        width: parent.width
        height: parent.height / 2
        horizontalAlignment: Text.AlignHCenter
        anchors.top : parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 10
    }

    ScreenButton
    {
        id : okBtn
        width : parent.width / 3
        height : parent.height / 4
        text : "OK"
        anchors.bottom: parent.bottom
        anchors.right: parent.horizontalCenter
        anchors.margins: 10
        anchors.rightMargin: 20
        onClicked: accepted();
    }

    ScreenButton
    {
        id : cancelBtn
        width : parent.width / 3
        height : parent.height / 4
        text : "Cancel"
        anchors.bottom: parent.bottom
        anchors.left: parent.horizontalCenter
        anchors.margins: 10
        anchors.leftMargin: 20
        onClicked: declined()
    }
}
