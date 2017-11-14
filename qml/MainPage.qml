import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.LocalStorage 2.0
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

import "Components"
import "Dialogs"

Page {
    id: main_page

    property var collections: []

    header: PageHeader {
        id: header
        title: i18n.tr('Dice Roller')

        trailingActionBar.actions: [
            Action {
                iconName: 'info'
                text: i18n.tr('About')
                onTriggered: pageStack.push(Qt.resolvedUrl('AboutPage.qml'))
            },

            Action {
                iconName: 'save'
                text: i18n.tr('Save Collection')
                //TODO handle no dice on the table
                onTriggered: PopupUtils.open(collectionNameDialogComponent, root)
            }
        ]
    }

    function get_database() {
        return LocalStorage.openDatabaseSync('dice-roller', '1.0', 'Dice Roller settings', 1000000);
    }

    Component.onCompleted: {
        var db = get_database();
        db.transaction(function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS collection(name TEXT, dice TEXT)'); //This is bad usage of a sql database (storing json like this), but it simplifies things

            var collections = tx.executeSql('SELECT * FROM collection');
            for (var i = 0; i < collections.rows.length; i++) {
                try {
                    main_page.collections.push({
                        name: collections.rows.item(i).name,
                        dice: JSON.parse(collections.rows.item(i).dice)
                    });
                }
                catch (e) {
                    console.log('WARNING: skipping collection, probably has bad json data');
                }
            }
        });
    }

    function saveCollection(name) {
        var db = get_database();
        db.transaction(function(tx) {
            var dice = [];
            for (var i = 0; i < dice_table.dice.length; i++) {
                var die = dice_table.dice[i];
                dice.push({
                    num: die.num,
                    values: die.values,
                });
            }

            tx.executeSql('INSERT INTO collection VALUES(?, ?)', [name, JSON.stringify(dice)])

            //TODO popup a success message
            console.log('SAVED!');
        });
    }

    Component {
        id: diceDialogComponent

        DiceDialog {
            id: diceDialog
            collections: main_page.collections

            onDiePicked: dice_table.add(num, values)
            onCollectionPicked: {
                dice_table.clear();
                dice_table.add_multiple(dice);
            }
        }
    }

    Component {
        id: collectionNameDialogComponent

        CollectionNameDialog {
            id: collectionNameDialog

            onSaved: saveCollection(name)
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

        DiceTable {
            id: dice_table
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Label {
            Layout.fillWidth: true

            visible: dice_table.count > 1
            text: i18n.tr("Total: %n").replace("%n", dice_table.total)
            horizontalAlignment: Label.AlignHCenter
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: units.gu(4)

            Icon {
                name: 'remove'
                Layout.preferredHeight: units.gu(5)
                opacity: dice_table.count > 0 ? 1 : 0.5

                MouseArea {
                    anchors.fill: parent
                    onClicked: dice_table.remove()
                }
            }

            Icon {
                name: 'add'
                Layout.preferredHeight: units.gu(5)

                MouseArea {
                    anchors.fill: parent
                    onClicked: PopupUtils.open(diceDialogComponent, root)
                }
            }

            Item {
                //spacer
                Layout.fillWidth: true
            }

            Icon {
                name: 'reload'
                Layout.preferredHeight: units.gu(5)
                opacity: dice_table.rolling ? 0.5 : 1

                MouseArea {
                    anchors.fill: parent
                    onClicked: dice_table.roll()
                }
            }
        }
    }
}
