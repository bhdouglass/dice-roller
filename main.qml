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
        property var total: "Total: " + (die0.text + die1.text)
        Die {
            id: die0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: units.gu (2)
        }
        Die {
            id: die1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: die0.bottom
            anchors.topMargin: units.gu (2)
        }
        Label {
            id: total_label
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: roll_button.top
            anchors.bottomMargin: units.gu (2)
            text: parent.total
        }
        Button {
            id: roll_button
            text: "Roll"
            anchors.left: parent.left
            anchors.leftMargin: units.gu (2)
            anchors.right: parent.right
            anchors.rightMargin: units.gu (2)
            anchors.bottom: parent.bottom
            anchors.bottomMargin: units.gu (2)
            onClicked: {
                die0.roll ()
                die1.roll ()
            }
        }
    }
}
