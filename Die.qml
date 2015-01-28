import QtQuick 2.0
import Ubuntu.Components 1.1

Rectangle {
    id: die
    width: units.gu (10)
    height: width
    radius: width * 0.1
    border.color: "grey"
    Behavior on rotation {
        NumberAnimation {
            easing.type: Easing.InOutQuint
            duration: 1000
        }
    }
    Timer {
        id: change_timer
        interval: 500
        onTriggered: text = new_text
    }
    Label {
        id: label
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
    property var new_text
    function roll () {
        new_text = Math.floor (Math.random () * 6) + 1
        change_timer.start ()
        rotation += random_direction () * 360 * 10
    }
    function random_direction () {
        return Math.random () >= 0.5 ? 1 : -1
    }
}
