import QtQuick 2.0
import QtGraphicalEffects 1.0

Item
{
    id : muteBtn
    width: 100
    height: 100

    property bool stateEnabled : true
    signal mute(bool enabled)

    readonly property url soundImageSource: "qrc:/images/buttons/res/soundIcon.png"
    readonly property url muteImageSource: "qrc:/images/buttons/res/muteIcon.png"
    Image
    {
        id : image
        visible: false
        source: soundImageSource
        anchors.fill: parent
    }

    Glow
    {
        id : glow
        anchors.fill: image
        source: image
        color: "white"
        radius: 0;
        spread : 0.7
        fast : true
    }

    states:
    [
        State
        {
            name : "sound"
            when :stateEnabled
            PropertyChanges {target: image; source: soundImageSource}
        },

        State
        {
            name : "mute"
            when : !stateEnabled
            PropertyChanges {target: image; source: muteImageSource}
        }
    ]

    MouseArea
    {
        id : mouseArea
        anchors.fill: parent
        hoverEnabled : true
        onEntered: glow.radius = 4;
        onExited: glow.radius = 0
        onClicked :
        {
            parent.mute(parent.stateEnabled);
            parent.stateEnabled = !parent.stateEnabled;
        }
    }
}
