import QtQuick 2.4
import Ubuntu.Components 1.3

MainView {
    objectName: 'mainView'
    applicationName: 'dice-roller.bhdouglass'
    id: root

    width: units.gu(40)
    height: units.gu(70)

    PageStack {
        id: pageStack

        Component.onCompleted: push(Qt.resolvedUrl('MainPage.qml'))
    }
}
