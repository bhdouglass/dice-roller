import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

Dialog {
    id: colorPopup

    property int num: 6
    property var values: null
    signal closed()

    Label {
        text: i18n.tr('Pick new dice')
        horizontalAlignment: Label.AlignHCenter
    }

    GridLayout {
        columnSpacing: units.gu(1)
        rowSpacing: units.gu(1)
        columns: 2

        Button {
            text: i18n.tr('coin')
            color: UbuntuColors.orange
            Layout.fillWidth: true

            onClicked: {
                num = 2;
                values = null;

                closed();
                PopupUtils.close(colorPopup);
            }
        }

        Button {
            text: i18n.tr('d4')
            color: UbuntuColors.orange
            Layout.fillWidth: true

            onClicked: {
                num = 4;
                values = null;

                closed();
                PopupUtils.close(colorPopup);
            }
        }

        Button {
            text: i18n.tr('d6')
            color: UbuntuColors.orange
            Layout.fillWidth: true

            onClicked: {
                num = 6;
                values = null;

                closed();
                PopupUtils.close(colorPopup);
            }
        }

        Button {
            text: i18n.tr('d8')
            color: UbuntuColors.orange
            Layout.fillWidth: true

            onClicked: {
                num = 8;
                values = null;

                closed();
                PopupUtils.close(colorPopup);
            }
        }

        Button {
            text: i18n.tr('d12')
            color: UbuntuColors.orange
            Layout.fillWidth: true

            onClicked: {
                num = 12;
                values = null;

                closed();
                PopupUtils.close(colorPopup);
            }
        }

        Button {
            text: i18n.tr('d20')
            color: UbuntuColors.orange
            Layout.fillWidth: true

            onClicked: {
                num = 20;
                values = null;

                closed();
                PopupUtils.close(colorPopup);
            }
        }

        Button {
            text: i18n.tr('d10 (1-10)')
            color: UbuntuColors.orange
            Layout.fillWidth: true

            onClicked: {
                num = 10;
                values = null;

                closed();
                PopupUtils.close(colorPopup);
            }
        }

        Button {
            text: i18n.tr('d10 (0-9)')
            color: UbuntuColors.orange
            Layout.fillWidth: true

            onClicked: {
                num = 10;
                values = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

                closed();
                PopupUtils.close(colorPopup);
            }
        }

        Button {
            text: i18n.tr('d10 (00-90)')
            color: UbuntuColors.orange
            Layout.fillWidth: true

            onClicked: {
                num = 10;
                values = ['00', 10, 20, 30, 40, 50, 60, 70, 80, 90];

                closed();
                PopupUtils.close(colorPopup);
            }
        }

        Button {
            text: i18n.tr('d100')
            color: UbuntuColors.orange
            Layout.fillWidth: true

            onClicked: {
                num = 100;
                values = null;

                closed();
                PopupUtils.close(colorPopup);
            }
        }
    }

    Button {
        text: i18n.tr('Cancel')

        onClicked: PopupUtils.close(colorPopup);
    }
}
