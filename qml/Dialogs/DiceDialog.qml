import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

import "../Components"

Dialog {
    id: dicePopup

    property var collections: []
    signal diePicked(int num, var values)
    signal collectionPicked(var dice)
    signal collectionRemoved(string name)

    Flickable {
        height: units.gu(50)
        contentHeight: contentColumn.height + units.gu(4)
        clip: true

        ColumnLayout {
            id: contentColumn
            anchors {
                left: parent.left;
                top: parent.top;
                right: parent.right;
                margins: units.gu(2)
            }
            spacing: units.gu(2)

            Label {
                Layout.fillWidth: true
                text: i18n.tr('Pick a new die')
                horizontalAlignment: Label.AlignHCenter
            }

            GridLayout {
                Layout.fillWidth: true
                columnSpacing: units.gu(1)
                rowSpacing: units.gu(1)
                columns: 3

                DiePicker {
                    num: 2
                    value: 1
                    text: i18n.tr('coin')

                    Layout.fillWidth: true
                    Layout.preferredHeight: units.gu(7)

                    onClicked: {
                        diePicked(2, null);
                        PopupUtils.close(dicePopup);
                    }
                }

                DiePicker {
                    num: 4
                    value: 4
                    text: i18n.tr('d4')

                    Layout.fillWidth: true
                    Layout.preferredHeight: units.gu(7)

                    onClicked: {
                        diePicked(4, null);
                        PopupUtils.close(dicePopup);
                    }
                }

                DiePicker {
                    num: 6
                    value: 6
                    text: i18n.tr('d6')

                    Layout.fillWidth: true
                    Layout.preferredHeight: units.gu(7)

                    onClicked: {
                        diePicked(6, null);
                        PopupUtils.close(dicePopup);
                    }
                }

                DiePicker {
                    num: 8
                    value: 8
                    text: i18n.tr('d8')

                    Layout.fillWidth: true
                    Layout.preferredHeight: units.gu(7)

                    onClicked: {
                        diePicked(8, null);
                        PopupUtils.close(dicePopup);
                    }
                }

                DiePicker {
                    num: 12
                    value: 12
                    text: i18n.tr('d12')

                    Layout.fillWidth: true
                    Layout.preferredHeight: units.gu(7)

                    onClicked: {
                        diePicked(12, null);
                        PopupUtils.close(dicePopup);
                    }
                }

                DiePicker {
                    num: 20
                    value: 20
                    text: i18n.tr('d20')

                    Layout.fillWidth: true
                    Layout.preferredHeight: units.gu(7)

                    onClicked: {
                        diePicked(20, null);
                        PopupUtils.close(dicePopup);
                    }
                }

                DiePicker {
                    num: 10
                    value: 10
                    text: i18n.tr('d10 (1-10)')

                    Layout.fillWidth: true
                    Layout.preferredHeight: units.gu(7)

                    onClicked: {
                        diePicked(10, null);
                        PopupUtils.close(dicePopup);
                    }
                }

                DiePicker {
                    num: 10
                    value: 9
                    text: i18n.tr('d10 (0-9)')

                    Layout.fillWidth: true
                    Layout.preferredHeight: units.gu(7)

                    onClicked: {
                        diePicked(10, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
                        PopupUtils.close(dicePopup);
                    }
                }

                DiePicker {
                    num: 10
                    value: 90
                    text: i18n.tr('d10 (00-90)')

                    Layout.fillWidth: true
                    Layout.preferredHeight: units.gu(7)

                    onClicked: {
                        diePicked(10, ['00', 10, 20, 30, 40, 50, 60, 70, 80, 90]);
                        PopupUtils.close(dicePopup);
                    }
                }

                Item {
                    //spacer
                    Layout.fillWidth: true
                    Layout.preferredHeight: units.gu(7)
                }

                DiePicker {
                    num: 100
                    value: 100
                    text: i18n.tr('d100')

                    Layout.fillWidth: true
                    Layout.preferredHeight: units.gu(7)

                    onClicked: {
                        diePicked(100, null);
                        PopupUtils.close(dicePopup);
                    }
                }
            }

            Label {
                Layout.fillWidth: true
                text: i18n.tr('Pick a collection')
                horizontalAlignment: Label.AlignHCenter
            }

            Label {
                Layout.fillWidth: true
                text: i18n.tr('(Tap and hold to delete a collection)')
                textSize: Label.XSmall
                horizontalAlignment: Label.AlignHCenter
            }

            Repeater {
                model: collections
                delegate: Label {
                    Layout.fillWidth: true
                    Layout.preferredHeight: units.gu(3)
                    text: modelData.name

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            collectionPicked(modelData.dice);
                            PopupUtils.close(dicePopup);
                        }

                        onPressAndHold: {
                            PopupUtils.close(dicePopup);
                            collectionRemoved(modelData.name);
                        }
                    }
                }
            }
        }
    }

    Button {
        text: i18n.tr('Cancel')

        onClicked: PopupUtils.close(dicePopup);
    }
}
