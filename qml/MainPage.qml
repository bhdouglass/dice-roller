import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

Page {
    id: main_page

    header: PageHeader {
        id: header
        title: i18n.tr('Dice Roller')

        trailingActionBar.actions: [
            Action {
                iconName: 'info'
                text: i18n.tr('About')
                onTriggered: pageStack.push(Qt.resolvedUrl('AboutPage.qml'))
            }
        ]
    }

    Component {
        id: dialogComponent

        DiceDialog {
            id: dialog

            onClosed: dice.add(num, values)
        }
    }

    ColumnLayout {
        anchors {
            top: header.bottom
            left: parent.left
            bottom: parent.bottom
            right: parent.right
        }
        anchors.margins: units.gu(2)
        spacing: units.gu(1)

        Dice {
            id: dice
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Label {
            Layout.fillWidth: true

            visible: dice.count > 1
            text: i18n.tr("Total: %n").replace("%n", dice.total)
            horizontalAlignment: Label.AlignHCenter
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: units.gu(4)

            Icon {
                name: 'remove'
                Layout.preferredHeight: units.gu(5)
                opacity: dice.count > 0 ? 1 : 0.5

                MouseArea {
                    anchors.fill: parent
                    onClicked: dice.remove()
                }
            }

            Icon {
                name: 'add'
                Layout.preferredHeight: units.gu(5)

                MouseArea {
                    anchors.fill: parent
                    onClicked: PopupUtils.open(dialogComponent, root)
                }
            }

            Item {
                //spacer
                Layout.fillWidth: true
            }

            Icon {
                name: 'reload'
                Layout.preferredHeight: units.gu(5)
                opacity: dice.rolling ? 0.5 : 1

                MouseArea {
                    anchors.fill: parent
                    onClicked: dice.roll()
                }
            }
        }
    }
}
