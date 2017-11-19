import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3

Page {
    id: bottomEdgeComponent

    property var collections: []
    property var customDice: []

    signal deleteCustomDie(string name)
    signal editCustomDie(string name, var values)
    signal createCustomDie()
    signal addDie(int num, var values)
    signal deleteCollection(string name)
    signal addCollection(var dice)
    signal createCollection()

    header: PageHeader {
        id: header
        title: i18n.tr('Collections & Custom Dice')
    }

    width: bottomEdge.width
    height: bottomEdge.height

    Flickable {
        clip: true
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        contentHeight: contentColumn.height + units.gu(4)

        Column {
            id: contentColumn
            anchors {
                left: parent.left;
                top: parent.top;
                right: parent.right;
            }

            Header {
                text: i18n.tr('Custom Dice')
            }

            Repeater {
                model: customDice

                delegate: ListItem {
                    Die {
                        id: die

                        anchors {
                            top: parent.top
                            left: parent.left
                            bottom: parent.bottom
                            topMargin: units.gu(1)
                            leftMargin: units.gu(2)
                            bottomMargin: units.gu(1)
                            rightMargin: units.gu(1)
                        }

                        width: height

                        num: modelData.values.length
                        value: modelData.values[0]
                        values: modelData.values
                    }

                    Label {
                        anchors {
                            left: die.right
                            leftMargin: units.gu(1)
                            verticalCenter: parent.verticalCenter
                        }

                        text: modelData.name
                    }

                    onClicked: bottomEdgeComponent.addDie(modelData.values.length, modelData.values)

                    leadingActions: ListItemActions {
                        actions: [
                            Action {
                                id: screenDelegateDeleteAction
                                iconName: 'delete'
                                text: i18n.tr('Delete')
                                onTriggered: bottomEdgeComponent.deleteCustomDie(modelData.name)
                            }
                        ]
                    }

                    trailingActions: ListItemActions {
                        actions: [
                            Action {
                                iconName: 'edit'
                                text: i18n.tr('Edit')
                                onTriggered: bottomEdgeComponent.editCustomDie(modelData.name, modelData.values)
                            },
                            Action {
                                iconName: 'add'
                                text: i18n.tr('Add')
                                onTriggered: bottomEdgeComponent.addDie(modelData.values.length, modelData.values)
                            }
                        ]
                    }
                }
            }

            ListItem {
                Icon {
                    id: customDieAddIcon
                    anchors {
                        top: parent.top
                        left: parent.left
                        bottom: parent.bottom
                        topMargin: units.gu(1)
                        leftMargin: units.gu(2)
                        bottomMargin: units.gu(1)
                        rightMargin: units.gu(1)
                    }
                    width: height

                    name: 'add'
                }

                Label {
                    anchors {
                        left: customDieAddIcon.right
                        leftMargin: units.gu(1)
                        verticalCenter: parent.verticalCenter
                    }

                    text: i18n.tr('Create a custom die')
                }

                onClicked: bottomEdgeComponent.createCustomDie()
            }

            Header {
                text: i18n.tr('Dice Collections')
            }

            Repeater {
                model: collections

                delegate: ListItem {
                    Label {
                        anchors {
                            left: parent.left
                            leftMargin: units.gu(2)
                            verticalCenter: parent.verticalCenter
                        }

                        text: modelData.name
                    }

                    onClicked: bottomEdgeComponent.addCollection(modelData.dice)

                    leadingActions: ListItemActions {
                        actions: [
                            Action {
                                id: screenDelegateDeleteAction
                                iconName: 'delete'
                                text: i18n.tr('Delete')
                                onTriggered: bottomEdgeComponent.deleteCollection(modelData.name)
                            }
                        ]
                    }

                    trailingActions: ListItemActions {
                        actions: [
                            Action {
                                iconName: 'add'
                                text: i18n.tr('Add')
                                onTriggered: bottomEdgeComponent.addCollection(modelData.dice)
                            }
                        ]
                    }
                }
            }

            ListItem {
                Icon {
                    id: collectionAddIcon
                    anchors {
                        top: parent.top
                        left: parent.left
                        bottom: parent.bottom
                        topMargin: units.gu(1)
                        leftMargin: units.gu(2)
                        bottomMargin: units.gu(1)
                        rightMargin: units.gu(1)
                    }
                    width: height

                    name: 'add'
                }

                Label {
                    anchors {
                        left: collectionAddIcon.right
                        leftMargin: units.gu(1)
                        verticalCenter: parent.verticalCenter
                    }

                    text: i18n.tr('Create a collection')
                }

                onClicked: bottomEdgeComponent.createCollection()
            }
        }
    }
}
