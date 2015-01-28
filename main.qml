import QtQuick 2.0
import QtQuick.Layouts 1.1
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
        Item {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: total_label.top
            anchors.margins: units.gu (2)
            Flow {
                id: die_grid
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                spacing: units.gu (1)
                flow: Flow.TopToBottom
                move: Transition {
                    NumberAnimation { properties: "x,y"; easing.type: Easing.InOutBounce; duration: 500 }
                }
                Die {
                    id: die0
                }
                Die {
                    id: die1
                }
            }
        }
        Label {
            id: total_label
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: buttons_layout.top
            anchors.bottomMargin: units.gu (2)
            text: parent.total
        }
        RowLayout {
            id: buttons_layout
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: roll_button.top
            anchors.bottomMargin: units.gu (2)
            Button {
                text: "-"
            }
            Button {
                text: "+"
                onClicked: {
                    var die_component = Qt.createComponent ("Die.qml")
                    die_component.createObject (die_grid)
                }
            }
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
