import QtQuick 2.0

Text
{
    id : textMsg
    property int startX
    property int startY
    x : startX
    y : startY
    z : 3
    width : 100
    height: 50
    color : "red";
    style : Text.Outline;
    styleColor: "White";
    text : "Msg"
    font.pixelSize: 22
    visible: false

    ParallelAnimation
    {
        id: animation
        ColorAnimation {
            target: textMsg;
            property: "color";
            from: color;
            to: "transparent";
            duration: 1000
        }
        ColorAnimation {
            target: textMsg;
            property: "styleColor";
            from: styleColor;
            to: "transparent";
            duration: 1000
        }
        NumberAnimation {
            target: textMsg;
            property: "y";
            from: startY;
            to: startY - 100;
            duration: 1000;
            easing.type: Easing.InOutQuad
        }
        onStopped: reset();
    }

    function showMsg(msg, txtColor)
    {
        color = txtColor;
        visible = true;
        text = msg;
        animation.start();
    }
    function reset()
    {
        visible = false;
        styleColor = "white";
        color = "red"
    }
}
