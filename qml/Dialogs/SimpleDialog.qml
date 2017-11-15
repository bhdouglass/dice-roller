import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

Dialog {
    id: simplePopup

    property alias text: label.text

    Label {
        id: label
        horizontalAlignment: Label.AlignHCenter
    }

    Button {
        text: i18n.tr('Ok')
        color: UbuntuColors.orange

        onClicked: PopupUtils.close(simplePopup);
    }
}
