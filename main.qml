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
        Rectangle {
            id: die
            width: units.gu (10)
            height: width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: units.gu (2)
        }
        Button {
            text: "Roll"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: units.gu (2)
        }
    }
}
