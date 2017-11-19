import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.LocalStorage 2.0
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

import "Components"
import "Dialogs"

Page {
    id: mainPage

    property var collections: []
    property var customDice: []

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

    function popupSaveCollection() {
        if (dice_table.dice.length === 0) {
            PopupUtils.open(noDiceDialogComponent, root);
        }
        else {
            PopupUtils.open(collectionNameDialogComponent, root);
        }
    }

    function getDatabase() {
        return LocalStorage.openDatabaseSync('dice-roller', '1.0', 'Dice Roller settings', 1000000);
    }

    function loadCollections() {
        var collections = [];

        var db = getDatabase();
        db.transaction(function(tx) {
            var results = tx.executeSql('SELECT * FROM collection');
            for (var i = 0; i < results.rows.length; i++) {
                try {
                    collections.push({
                        name: results.rows.item(i).name,
                        dice: JSON.parse(results.rows.item(i).dice)
                    });
                }
                catch (e) {
                    console.log('WARNING: skipping collection, probably has bad json data');
                }
            }

            mainPage.collections = collections;
        });
    }

    function loadCustomDice() {
        var customDice = [];

        var db = getDatabase();
        db.transaction(function(tx) {
            var results = tx.executeSql('SELECT * FROM custom_die');
            for (var i = 0; i < results.rows.length; i++) {
                try {
                    customDice.push({
                        name: results.rows.item(i).name,
                        values: JSON.parse(results.rows.item(i).sides)
                    });
                }
                catch (e) {
                    console.log('WARNING: skipping custom die, probably has bad json data');
                }
            }

            mainPage.customDice = customDice;
        });
    }

    Component.onCompleted: {
        var db = getDatabase();
        db.transaction(function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS collection(name TEXT, dice TEXT)'); //This is bad usage of a sql database (storing json like this), but it simplifies things
            tx.executeSql('CREATE TABLE IF NOT EXISTS custom_die(name TEXT, sides TEXT)');
        });

        loadCollections();
        loadCustomDice();
    }

    function saveCollection(name) {
        var db = getDatabase();
        db.transaction(function(tx) {
            var dice = [];
            for (var i = 0; i < dice_table.dice.length; i++) {
                var die = dice_table.dice[i];
                dice.push({
                    num: die.num,
                    values: die.values,
                });
            }

            var results = tx.executeSql('SELECT * FROM collection WHERE name = ?', [name]);
            if (results.rows.length > 0) {
                tx.executeSql('UPDATE collection SET dice=? WHERE name=?', [JSON.stringify(dice), name]);
            }
            else {
                tx.executeSql('INSERT INTO collection VALUES(?, ?)', [name, JSON.stringify(dice)]);
            }

            loadCollections();
        });
    }

    function removeCollection(name) {
        var db = getDatabase();
        db.transaction(function(tx) {
            tx.executeSql('DELETE FROM collection WHERE name=?', [name]);
        });

        loadCollections();
        PopupUtils.open(removedCollectionDialogComponent, root);
    }

    function saveCustomDie(name, values) {
        var db = getDatabase();
        db.transaction(function(tx) {
            var results = tx.executeSql('SELECT * FROM custom_die WHERE name = ?', [name]);
            if (results.rows.length > 0) {
                tx.executeSql('UPDATE custom_die SET sides=? WHERE name=?', [JSON.stringify(values), name]);
            }
            else {
                tx.executeSql('INSERT INTO custom_die VALUES(?, ?)', [name, JSON.stringify(values)]);
            }

            loadCustomDice();
        });
    }

    function removeCustomDie(name) {
        var db = getDatabase();
        db.transaction(function(tx) {
            tx.executeSql('DELETE FROM custom_die WHERE name=?', [name]);
        });

        loadCustomDice();
        PopupUtils.open(removedCustomDieDialogComponent, root);
    }

    Component {
        id: diceDialogComponent

        DiceDialog {
            id: diceDialog
            collections: mainPage.collections
            customDice: mainPage.customDice

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

    Component {
        id: noDiceDialogComponent

        SimpleDialog {
            id: noDiceDialog
            text: i18n.tr('There are no dice to save\nTry adding dice before saving to a collection')
        }
    }

    Component {
        id: removedCustomDieDialogComponent

        SimpleDialog {
            id: removedCustomDieDialog
            text: i18n.tr('You custom die has been removed')
        }
    }

    Component {
        id: removedCollectionDialogComponent

        SimpleDialog {
            id: removedCollectionDialog
            text: i18n.tr('You collection has been removed')
        }
    }

    Component {
        id: customDieDialogComponent

        CustomDieDialog {
            id: customDieDialog

            onSaved: {
                saveCustomDie(name, values);
                dice_table.add(values.length, values);
            }
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
                    onPressAndHold: dice_table.clear()
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

    BottomEdge {
        id: bottomEdge
        height: parent.height

        contentComponent: DiceBottomEdge {
            id: bottomEdgeComponent

            collections: mainPage.collections
            customDice: mainPage.customDice

            onDeleteCustomDie: {
                removeCustomDie(name);
                bottomEdge.collapse();
            }
            onEditCustomDie: {
                PopupUtils.open(customDieDialogComponent, root, {
                    name: name,
                    values: values,
                })
                bottomEdge.collapse();
            }
            onCreateCustomDie: {
                PopupUtils.open(customDieDialogComponent, root)
                bottomEdge.collapse();
            }
            onAddDie: {
                dice_table.add(num, values)
                bottomEdge.collapse();
            }
            onDeleteCollection: {
                removeCollection(name)
                bottomEdge.collapse();
            }
            onAddCollection: {
                dice_table.clear();
                dice_table.add_multiple(dice);
                bottomEdge.collapse();
            }
            onCreateCollection: {
                popupSaveCollection()
                bottomEdge.collapse();
            }
        }
    }
}
