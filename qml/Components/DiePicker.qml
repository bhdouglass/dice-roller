import QtQuick 2.4
import Ubuntu.Components 1.3

Item {
    property alias text: label.text
    property alias num: die.num
    property alias values: die.values
    property alias value: die.value

    signal clicked()
    signal pressAndHold()

    Die {
        id: die

        width: units.gu(5)
        height: units.gu(5)
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
    }

    Label {
        id: label

        anchors {
            right: parent.right
            bottom: parent.bottom
            left: parent.left
        }

        horizontalAlignment: Label.AlignHCenter
    }

    MouseArea {
        anchors.fill: parent
        onClicked: parent.clicked()
        onPressAndHold: parent.pressAndHold()
    }
}
