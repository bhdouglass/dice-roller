import QtQuick 2.0
import Ubuntu.Components 1.3

Item {
    id: die

    property int num: 2
    property var values: null
    property var value: null
    property var new_value
    property var held: false
    signal changed()
    signal rolled()
    signal remove(var die)

    onNumChanged: {
        update_face();
    }

    property bool animation_enabled: false
    property var dot_size: width / 7

    function is_d2() {
        return (num <= 2);
    }

    function is_d4() {
        return (num >= 3 && num <= 5);
    }

    function is_d6() {
        return (num == 6);
    }

    function is_d8() {
        return (num >= 7 && num <= 8);
    }

    function is_d10() {
        return (num >= 9 && num <= 11);
    }

    function is_d12() {
        return (num >= 12 && num <= 16);
    }

    function is_d20() {
        return (num >= 17 && num <= 30);
    }

    function is_d100() {
        return (num >= 30);
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

    Image {
        anchors.fill: parent
        //TODO use a qrc file
        source: {
            var imageNum = 2;
            if (is_d2()) {
                imageNum = 2;
            }
            else if (is_d4()) {
                imageNum = 4;
            }
            else if (is_d6()) {
                imageNum = 6;
            }
            else if (is_d8()) {
                imageNum = 8;
            }
            else if (is_d10()) {
                imageNum = 10;
            }
            else if (is_d12()) {
                imageNum = 12;
            }
            else if (is_d20()) {
                imageNum = 20;
            }
            else if (is_d100()) {
                imageNum = 100;
            }

            return '../../img/d' + imageNum + '.svg'
        }
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
        visible: (is_d10() || is_d100())
        anchors {
            fill: parent
            topMargin: parent.height / 5
            rightMargin: parent.height / 10
            bottomMargin: parent.height / 10
            leftMargin: parent.height / 10
        }

        font.pixelSize: height * 1/2
        font.bold: true

        verticalAlignment: Label.AlignTop
        horizontalAlignment: Label.AlignHCenter

        text: (value == null) ? '' : value
        color: 'black'
    }

    Label {
        //Shifted left
        visible: is_d2()
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
            if (values) {
                return (value == null) ? '' : value;
            }
            else {
                if (value == 1) {
                    return 'H';
                }
                else {
                    return 'T';
                }
            }
        }
        color: 'black'
    }

    Label {
        //Centered
        visible:  {
            if (is_d6()) {
                return !!values;
            }
            else if (is_d2() || is_d10() || is_d100()) {
                return false;
            }
            else {
                return true;
            }
        }
        anchors.fill: parent
        anchors.margins: parent.height / 10
        font.pixelSize: {
            if (num >= 20) {
                return height * 3/8;
            }
            else {
                return height * 3/4;
            }
        }
        font.bold: true

        verticalAlignment: Label.AlignVCenter
        horizontalAlignment: Label.AlignHCenter

        text: (value == null) ? '' : value
        color: 'black'
    }

    MouseArea {
        anchors.fill: parent
        onPressed: held = !held
        onPressAndHold: remove(die)
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
