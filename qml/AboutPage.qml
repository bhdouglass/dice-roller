import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3

Page {
    header: PageHeader {
        id: header
        title: i18n.tr('About')
    }

    Flickable {
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        contentHeight: contentColumn.height + units.gu(4)

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

                text: i18n.tr('Dice Roller')
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }

            Label {
                Layout.fillWidth: true

                text: i18n.tr('A fork of the original Dice Roller app by Robert Ancell');
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }

            Label {
                Layout.fillWidth: true

                text: i18n.tr('Awesome icons by Joan CiberSheep (based on icons from the noun project)');
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }

            Label {
                Layout.fillWidth: true

                text: i18n.tr('Fork by Brian Douglass');
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }

            Label {
                Layout.fillWidth: true

                text: i18n.tr('This app is open source software under the GPL v3.');
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }

            Button {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

                text: i18n.tr('Website')
                color: UbuntuColors.orange
                onClicked: Qt.openUrlExternally('http://bhdouglass.com/')
            }
        }
    }
}
