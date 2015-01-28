import QtQuick 2.0
import Ubuntu.Components 1.1

MainView {
    objectName: "mainView"
    id: game_view
    applicationName: "com.ubuntu.developer.robert-ancell.dice-roller"
    useDeprecatedToolbar: false

    width: units.gu (40)
    height: units.gu (71)

    Page {
        Die {
            id: die0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: units.gu (2)
            text: "1"
        }
        Die {
            id: die1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: die0.bottom
            anchors.topMargin: units.gu (2)
            text: "6"
        }
        Button {
            text: "Roll"
            anchors.left: parent.left
            anchors.leftMargin: units.gu (2)
            anchors.right: parent.right
            anchors.rightMargin: units.gu (2)
            anchors.bottom: parent.bottom
            anchors.bottomMargin: units.gu (2)
            onClicked: {
                die0.rotation += 360 * 10
                die1.rotation -= 360 * 10
            }
        }
    }
}
