import QtQuick 2.0
import Ubuntu.Components 1.3

Rectangle {
    id: die

    property int num: 1
    onNumChanged: {
        update_face();
        roll();
    }

    color: {
        if (num == 2) {
            return 'yellow';
        }
        else if (num == 4) {
            return 'red'
        }
        else if (num == 8) {
            return 'green';
        }
        else if (num == 12) {
            return 'blue';
        }
        else if (num == 20) {
            return 'black';
        }
        else {
            return 'white';
        }
    }

    radius: width * 0.1
    border.color: "grey"
    border.width: held ? 4 : 1
    property bool animation_enabled: false
    property var dot_size: width / 7

    Rectangle {
        id: dot_nw
        visible: false
        x: dot_size
        y: dot_size
        width: dot_size
        height: dot_size
        radius: width * 0.5
        color: "black"
    }

    Rectangle {
        id: dot_w
        visible: false
        x: dot_size
        y: dot_size * 3
        width: dot_size
        height: dot_size
        radius: width * 0.5
        color: "black"
    }

    Rectangle {
        id: dot_sw
        visible: false
        x: dot_size
        y: dot_size * 5
        width: dot_size
        height: dot_size
        radius: width * 0.5
        color: "black"
    }

    Rectangle {
        id: dot_middle
        visible: false
        x: dot_size * 3
        y: dot_size * 3
        width: dot_size
        height: dot_size
        radius: width * 0.5
        color: "black"
    }

    Rectangle {
        id: dot_ne
        visible: false
        x: dot_size * 5
        y: dot_size
        width: dot_size
        height: dot_size
        radius: width * 0.5
        color: "black"
    }

    Rectangle {
        id: dot_e
        visible: false
        x: dot_size * 5
        y: dot_size * 3
        width: dot_size
        height: dot_size
        radius: width * 0.5
        color: "black"
    }

    Rectangle {
        id: dot_se
        visible: false
        x: dot_size * 5
        y: dot_size * 5
        width: dot_size
        height: dot_size
        radius: width * 0.5
        color: "black"
    }

    Behavior on rotation {
        NumberAnimation {
            id: animation
            easing.type: Easing.InOutQuint
            duration: 1000
            onRunningChanged: {
                if (!running)
                    die.rolled()
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
            value = new_value
            update_face()
            die.changed()
        }
    }

    Label {
        id: label
        anchors.fill: parent
        anchors.margins: units.gu(1)
        font.pixelSize: height
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        text: value
        visible: num != 6
        color: (num == 20) ? 'white' : 'black'
    }

    MouseArea {
        anchors.fill: parent
        onPressed: held = !held
    }

    property var value
    property var new_value
    property var held: false
    signal changed()
    signal rolled()

    function roll() {
        if (held)
            return
        new_value = Math.floor(Math.random() * num) + 1
        change_timer.start()
        rotation += random_direction() * 360 * 10
    }

    function discard() {
        opacity_animation.onRunningChanged.connect(function() {
            if (!opacity_animation.running)
                die.destroy()
        })
        opacity = 0
    }

    function is_rolling() {
        return animation.running
    }

    function random_direction() {
        return Math.random() >= 0.5 ? 1 : -1
    }

    function update_face() {
        if (num != 6) {
            dot_nw.visible = false;
            dot_w.visible = false;
            dot_sw.visible = false;
            dot_middle.visible = false;
            dot_ne.visible = false;
            dot_e.visible = false;
            dot_se.visible = false;
        }
        else {
            switch(value)
            {
            case 1:
                dot_nw.visible = false
                dot_w.visible = false
                dot_sw.visible = false
                dot_middle.visible = true
                dot_ne.visible = false
                dot_e.visible = false
                dot_se.visible = false
                break;
            case 2:
                dot_nw.visible = false
                dot_w.visible = false
                dot_sw.visible = true
                dot_middle.visible = false
                dot_ne.visible = true
                dot_e.visible = false
                dot_se.visible = false
                break;
            case 3:
                dot_nw.visible = false
                dot_w.visible = false
                dot_sw.visible = true
                dot_middle.visible = true
                dot_ne.visible = true
                dot_e.visible = false
                dot_se.visible = false
                break;
            case 4:
                dot_nw.visible = true
                dot_w.visible = false
                dot_sw.visible = true
                dot_middle.visible = false
                dot_ne.visible = true
                dot_e.visible = false
                dot_se.visible = true
                break;
            case 5:
                dot_nw.visible = true
                dot_w.visible = false
                dot_sw.visible = true
                dot_middle.visible = true
                dot_ne.visible = true
                dot_e.visible = false
                dot_se.visible = true
                break;
            case 6:
                dot_nw.visible = true
                dot_w.visible = true
                dot_sw.visible = true
                dot_middle.visible = false
                dot_ne.visible = true
                dot_e.visible = true
                dot_se.visible = true
                break;
            }
        }
    }

    Component.onCompleted: {
        value = Math.floor(Math.random() * num) + 1
        update_face()
    }
}
