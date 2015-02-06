import QtQuick 2.0
import Ubuntu.Components 1.1

Rectangle {
    id: die
    radius: width * 0.1
    border.color: "grey"
    border.width: held ? 4 : 1
    property bool animation_enabled: false
    Behavior on rotation {
        NumberAnimation {
            id: animation
            easing.type: Easing.InOutQuint
            duration: 1000
            onRunningChanged: {
                if (!running)
                    die.rolled ()
            }
        }
    }
    Behavior on x {
        enabled: animation_enabled
        NumberAnimation {
            easing: UbuntuAnimation.StandardEasing
            duration: UbuntuAnimation.FastDuration
        }
    }
    Behavior on y {
        enabled: animation_enabled
        NumberAnimation {
            easing: UbuntuAnimation.StandardEasing
            duration: UbuntuAnimation.FastDuration
        }
    }
    Behavior on opacity {
        enabled: animation_enabled
        NumberAnimation {
            id: opacity_animation
            easing: UbuntuAnimation.StandardEasing
            duration: UbuntuAnimation.FastDuration
        }
    }
    Timer {
        id: change_timer
        interval: 500
        onTriggered: {
            text = value
            die.changed ()
        }
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
    MouseArea {
        anchors.fill: parent
        onPressed: held = !held
    }
    property var text
    property var value
    property var held: false
    signal changed ()
    signal rolled ()
    function roll () {
        if (held)
            return
        value = Math.floor (Math.random () * 6) + 1
        change_timer.start ()
        rotation += random_direction () * 360 * 10
    }
    function discard () {
        opacity_animation.onRunningChanged.connect (function () {
            if (!opacity_animation.running)
                die.destroy ()
        })
        opacity = 0
    }
    function is_rolling () {
        return animation.running
    }
    function random_direction () {
        return Math.random () >= 0.5 ? 1 : -1
    }
    Component.onCompleted: {
        text = value = Math.floor (Math.random () * 6) + 1
    }
}
