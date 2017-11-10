import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

Dialog {
    id: dicePopup

    property int num: 6
    property var values: null
    signal closed()

    Label {
        text: i18n.tr('Pick a new die')
        horizontalAlignment: Label.AlignHCenter
    }

    GridLayout {
        columnSpacing: units.gu(1)
        rowSpacing: units.gu(1)
        columns: 3

        DiePicker {
            num: 2
            value: 1
            text: i18n.tr('coin')

            Layout.preferredWidth: units.gu(5)
            Layout.preferredHeight: units.gu(7)

            onClicked: {
                dicePopup.num = 2;
                dicePopup.values = null;

                closed();
                PopupUtils.close(dicePopup);
            }
        }

        DiePicker {
            num: 4
            value: 4
            text: i18n.tr('d4')

            Layout.preferredWidth: units.gu(5)
            Layout.preferredHeight: units.gu(7)

            onClicked: {
                dicePopup.num = 4;
                dicePopup.values = null;

                closed();
                PopupUtils.close(dicePopup);
            }
        }

        DiePicker {
            num: 6
            value: 6
            text: i18n.tr('d6')

            Layout.preferredWidth: units.gu(5)
            Layout.preferredHeight: units.gu(7)

            onClicked: {
                dicePopup.num = 6;
                dicePopup.values = null;

                closed();
                PopupUtils.close(dicePopup);
            }
        }

        DiePicker {
            num: 8
            value: 8
            text: i18n.tr('d8')

            Layout.preferredWidth: units.gu(5)
            Layout.preferredHeight: units.gu(7)

            onClicked: {
                dicePopup.num = 8;
                dicePopup.values = null;

                closed();
                PopupUtils.close(dicePopup);
            }
        }

        DiePicker {
            num: 12
            value: 12
            text: i18n.tr('d12')

            Layout.preferredWidth: units.gu(5)
            Layout.preferredHeight: units.gu(7)

            onClicked: {
                dicePopup.num = 12;
                dicePopup.values = null;

                closed();
                PopupUtils.close(dicePopup);
            }
        }

        DiePicker {
            num: 20
            value: 20
            text: i18n.tr('d20')

            Layout.preferredWidth: units.gu(5)
            Layout.preferredHeight: units.gu(7)

            onClicked: {
                dicePopup.num = 20;
                dicePopup.values = null;

                closed();
                PopupUtils.close(dicePopup);
            }
        }

        DiePicker {
            num: 10
            value: 10
            text: i18n.tr('d10 (1-10)')

            Layout.preferredWidth: units.gu(5)
            Layout.preferredHeight: units.gu(7)

            onClicked: {
                dicePopup.num = 10;
                dicePopup.values = null;

                closed();
                PopupUtils.close(dicePopup);
            }
        }

        DiePicker {
            num: 10
            value: 9
            text: i18n.tr('d10 (0-9)')

            Layout.preferredWidth: units.gu(5)
            Layout.preferredHeight: units.gu(7)

            onClicked: {
                dicePopup.num = 10;
                dicePopup.values = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

                closed();
                PopupUtils.close(dicePopup);
            }
        }

        DiePicker {
            num: 10
            value: 90
            text: i18n.tr('d10 (00-90)')

            Layout.preferredWidth: units.gu(5)
            Layout.preferredHeight: units.gu(7)

            onClicked: {
                dicePopup.num = 10;
                dicePopup.values = ['00', 10, 20, 30, 40, 50, 60, 70, 80, 90];

                closed();
                PopupUtils.close(dicePopup);
            }
        }

        Item {
            //spacer
            Layout.preferredWidth: units.gu(5)
            Layout.preferredHeight: units.gu(7)
        }

        DiePicker {
            num: 100
            value: 100
            text: i18n.tr('d100')

            Layout.preferredWidth: units.gu(5)
            Layout.preferredHeight: units.gu(7)

            onClicked: {
                dicePopup.num = 100;
                dicePopup.values = null;

                closed();
                PopupUtils.close(dicePopup);
            }
        }
    }

    Button {
        text: i18n.tr('Cancel')

        onClicked: PopupUtils.close(dicePopup);
    }
}
