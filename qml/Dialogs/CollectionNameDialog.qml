import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

import "../Components"

Dialog {
    id: namePopup

    property alias text: name.text
    signal saved(string name)

    Label {
        text: i18n.tr('Choose a name for this collection of dice')
        horizontalAlignment: Label.AlignHCenter
    }

    TextField {
        id: name

        onAccepted: {
            name.focus = false;
            saved(name.text);
            PopupUtils.close(namePopup);
        }
    }

    Button {
        text: i18n.tr('Save')
        color: UbuntuColors.orange

        onClicked: {
            name.focus = false; //Needed because the predictive text cuts off the last part of input
            saved(name.text);
            PopupUtils.close(namePopup);
        }
    }

    Button {
        text: i18n.tr('Cancel')

        onClicked: PopupUtils.close(namePopup)
    }
}
