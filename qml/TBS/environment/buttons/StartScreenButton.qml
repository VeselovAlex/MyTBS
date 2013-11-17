import QtQuick 2.0

Rectangle {
    signal clicked()
    width: 100
    height: 62
    color: "#581b0d"//Brown
    border.color : "black"
    border.width: 1
    radius: Math.min(height, width) / 4

    gradient: Gradient {
        GradientStop {
            id : btmGrCol;
            position: 1.00;
            color: "#581b0d";
        }
        GradientStop {
            id : topGrCol;
            position: 0.00;
            color: "#b33807";//Light brown
        }
    }

    states: [
        State {
            name: "Pressed";
            when: mousearea.pressed
            PropertyChanges {target: btmGrCol; position: 0.00;}
            PropertyChanges {target: topGrCol; position: 1.00;}
        },
        State {
            name: "Released";
            when: !mousearea.pressed
            PropertyChanges {target: btmGrCol; position: 1.00;}
            PropertyChanges {target: topGrCol; position: 0.00;}
        }
    ]
    property alias text: label.text

    Text
    {
        id : label
        color: "white"
        font.capitalization: Font.AllUppercase
        font.pixelSize: parent.height / 2
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

    }

    MouseArea
    {
        id : mousearea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked:
        {
            parent.clicked();
        }

    }

}
