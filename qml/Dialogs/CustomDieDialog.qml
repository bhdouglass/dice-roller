import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

import "../Components"

Dialog {
    id: customDicePopup

    signal saved(string name, var values)

    function save() {
        var v = values.text.split(',');
        var v2 = [];
        for (var i = 0; i < v.length; i++) {
            var value = v[i].trim();
            if (value) {
                v2.push(value);
            }
        }

        if (v2.length > 0 && name.text.length > 0) {
            saved(name.text, v2);
            PopupUtils.close(customDicePopup);
        }
    }

    Label {
        text: i18n.tr('Create a custom die')
        horizontalAlignment: Label.AlignHCenter
    }

    Label {
        text: i18n.tr('Name')
        horizontalAlignment: Label.AlignHCenter
        textSize: Label.Small
    }

    TextField {
        id: name
    }

    Label {
        text: i18n.tr('Enter side values separated by commas')
        horizontalAlignment: Label.AlignHCenter
        textSize: Label.Small
    }

    TextField {
        id: values
        inputMethodHints: Qt.ImhNoPredictiveText

        onAccepted: save()
    }

    Button {
        text: i18n.tr('Save')
        color: UbuntuColors.orange

        onClicked: save()
    }

    Button {
        text: i18n.tr('Cancel')

        onClicked: PopupUtils.close(customDicePopup)
    }
}
