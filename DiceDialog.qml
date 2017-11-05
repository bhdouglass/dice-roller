import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

Dialog {
    id: colorPopup

    property int num: 6
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
            //TODO make this a "coin"
            text: i18n.tr('d2')
            color: UbuntuColors.orange
            Layout.fillWidth: true

            onClicked: {
                num = 2;
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
