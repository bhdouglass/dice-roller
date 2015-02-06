import QtQuick 2.0
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.1

MainView {
    objectName: "mainView"
    applicationName: "com.ubuntu.developer.robert-ancell.dice-roller"
    useDeprecatedToolbar: false

    width: units.gu (40)
    height: units.gu (71)

    Page {
        id: main_page
        Item {
            id: table
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: total_label.top
            anchors.margins: units.gu (2)
            onWidthChanged: main_page.layout ()
            onHeightChanged: main_page.layout ()
        }
        Label {
            id: total_label
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: buttons_layout.top
            anchors.bottomMargin: units.gu (2)
        }
        RowLayout {
            id: buttons_layout
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: roll_button.top
            anchors.bottomMargin: units.gu (2)
            Button {
                id: remove_button
                text: "-"
                enabled: false
                onClicked: main_page.remove_die ()
            }
            Button {
                text: "+"
                onClicked: main_page.add_die ()
            }
        }
        Button {
            id: roll_button
            text: "Roll"
            anchors.left: parent.left
            anchors.leftMargin: units.gu (2)
            anchors.right: parent.right
            anchors.rightMargin: units.gu (2)
            anchors.bottom: parent.bottom
            anchors.bottomMargin: units.gu (2)
            onClicked: main_page.roll ()
        }
        Component.onCompleted: {
            add_die ()
        }
        property var dice: []
        property var die_size: units.gu (10)
        property var die_spacing: units.gu (1)
        function add_die () {
            var die_component = Qt.createComponent ("Die.qml")
            var die = die_component.createObject (table)
            die.width = die_size
            die.height = die_size
            die.opacity = 0
            die.onChanged.connect (update_total)
            die.onRolled.connect (update_rolling)
            dice[dice.length] = die
            update_remove_button_enabled ()
            update_total ()
            layout ()
            die.animation_enabled = true
            die.opacity = 1
        }
        function remove_die () {
            if (dice.length < 2)
                return
            dice[dice.length - 1].discard ()
            dice.length--
            update_remove_button_enabled ()
            update_total ()
            layout ()
        }
        function roll () {
            for (var i = 0; i < dice.length; i++)
                dice[i].roll ()
            update_rolling ()
        }
        function update_remove_button_enabled () {
            remove_button.enabled = dice.length > 1
        }
        function update_total () {
            if (dice.length < 2) {
                total_label.text = ""
                return
            }
            var t = 0
            for (var i = 0; i < dice.length; i++)
                t += dice[i].value
            total_label.text = "Total: " + t
        }
        function update_rolling () {
            var rolling = false
            for (var i = 0; i < dice.length; i++)
                if (dice[i].is_rolling ())
                    rolling = true
            roll_button.enabled = !rolling
        }
        function layout () {
            if (dice.length == 0)
                return

            // Layout in grid that matches the allocated area
            var n_cols
            var n_rows
            var aspect = table.width / table.height
            var best_error
            for (var r = 1; r <= dice.length; r++) {
                var c = Math.ceil (dice.length / r)
                var a = c / r
                var e = Math.abs (aspect - a)
                if (best_error == undefined || e < best_error) {
                    n_cols = c
                    n_rows = r
                    best_error = e
                }
            }

            // Move to this location
            var grid_width = n_cols * die_size + (n_cols - 1) * die_spacing
            var grid_height = n_rows * die_size + (n_rows - 1) * die_spacing
            var x_offset = (table.width - grid_width) * 0.5
            var y_offset = (table.height - grid_height) * 0.5
            var die_step = die_size + die_spacing
            for (var i = 0; i < dice.length; i++) {
                var col = i % n_cols
                var row = Math.floor (i / n_cols)
                dice[i].x = x_offset + col * die_step
                dice[i].y = y_offset + row * die_step
            }
        }
    }
}
