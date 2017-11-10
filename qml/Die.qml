import QtQuick 2.0
import Ubuntu.Components 1.3

Item {
    id: die

    property int num: 2
    property var values: null
    property var value
    property var new_value
    property var held: false
    signal changed()
    signal rolled()

    onNumChanged: {
        update_face();
    }

    property bool animation_enabled: false
    property var dot_size: width / 7

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

    Image {
        anchors.fill: parent
        source: '../img/d' + num + '.svg'
        sourceSize.width: 400
        sourceSize.height: 500
    }

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

    Label {
        //Shifted up
        visible: (num == 10 || num == 100)
        anchors {
            fill: parent
            topMargin: (num == 10) ? parent.height / 5 : parent.height / 10
            rightMargin: parent.height / 10
            bottomMargin: parent.height / 10
            leftMargin: parent.height / 10
        }

        font.pixelSize: {
            if (num == 100) {
                return height * 3/8;
            }
            else {
                return height * 1/2;
            }
        }
        font.bold: true

        verticalAlignment: Label.AlignTop
        horizontalAlignment: Label.AlignHCenter

        text: value ? value : ''
        color: 'black'
    }

    Label {
        //Shifted left
        visible: (num == 2)
        anchors {
            fill: parent
            topMargin: parent.height / 5
            rightMargin: parent.height / 5
            bottomMargin: parent.height / 10
            leftMargin: parent.height / 10
        }

        font.pixelSize: height * 3/4
        font.bold: true

        verticalAlignment: Label.AlignTop
        horizontalAlignment: Label.AlignHCenter

        text: {
            if (value == 1) {
                return 'H';
            }
            else {
                return 'T';
            }
        }
        color: 'black'
    }

    Label {
        //Centered
        visible: (num != 2 && num != 6 && num != 10 && num != 100)
        anchors.fill: parent
        anchors.margins: parent.height / 10
        font.pixelSize: {
            if (num == 20) {
                return height * 3/8;
            }
            else {
                return height * 3/4;
            }
        }
        font.bold: true

        verticalAlignment: Label.AlignVCenter
        horizontalAlignment: Label.AlignHCenter

        text: value ? value : ''
        color: 'black'
    }

    MouseArea {
        anchors.fill: parent
        onPressed: held = !held
    }

    function roll() {
        if (!held) {
            var random = Math.floor(Math.random() * num) + 1;

            if (values) {
                new_value = values[random - 1];
            }
            else {
                new_value = random;
            }

            change_timer.start()
            rotation += random_direction() * 360 * 10
        }
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
}
