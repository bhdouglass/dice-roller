import QtQuick 2.0
import Ubuntu.Components 1.1

Rectangle {
    id: die
    width: units.gu (10)
    height: width
    Behavior on rotation {
        NumberAnimation {
            easing.type: Easing.InOutQuint
            duration: 1000
        }
    }
    Label {
        anchors.fill: parent
        anchors.margins: units.gu (1)
        text: parent.text
        font.pixelSize: height
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: "black"
    }
    property var text
}
