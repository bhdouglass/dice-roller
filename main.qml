/*
 * Copyright (C) 2015 Robert Ancell <robert.ancell@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version. See http://www.gnu.org/copyleft/gpl.html the full text of the
 * license.
 */

import QtQuick 2.0
import QtSensors 5.0
import Ubuntu.Components 1.1

MainView {
    objectName: "mainView"
    applicationName: "com.ubuntu.developer.robert-ancell.dice-roller"
    useDeprecatedToolbar: false

    width: units.gu (40)
    height: units.gu (71)

    Page {
        id: main_page
        // TRANSLATORS: Title of application
        title: i18n.tr ("Dice Roller")
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
            anchors.bottom: roll_button.top
            anchors.bottomMargin: units.gu (2)
        }
        Rectangle {
            id: roll_button
            width: units.gu (10)
            height: width
            radius: width * 0.5
            anchors.right: parent.right
            anchors.rightMargin: units.gu (2)
            anchors.bottom: parent.bottom
            anchors.bottomMargin: units.gu (2)
            opacity: enabled ? 1.0 : 0.5
            Icon {
                anchors.fill: parent
                anchors.margins: units.gu (2)
                name: "reload"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: main_page.roll ()
            }
        }
        Rectangle {
            id: remove_button
            enabled: false
            width: units.gu (8)
            height: width
            radius: width * 0.5
            anchors.left: parent.left
            anchors.leftMargin: units.gu (2)
            anchors.verticalCenter: roll_button.verticalCenter
            opacity: enabled ? 1.0 : 0.5
            Icon {
                anchors.fill: parent
                anchors.margins: units.gu (2)
                name: "remove"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: main_page.remove_die ()
            }
        }
        Rectangle {
            width: units.gu (8)
            height: width
            radius: width * 0.5
            anchors.left: remove_button.right
            anchors.leftMargin: units.gu (1)
            anchors.verticalCenter: roll_button.verticalCenter
            opacity: enabled ? 1.0 : 0.5
            Icon {
                anchors.fill: parent
                anchors.margins: units.gu (2)
                name: "add"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: main_page.add_die ()
            }
        }
        SensorGesture {
            enabled: true
            gestures: [ "QtSensors.shake" ]
            onDetected: main_page.roll ()
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
            // TRANSLATORS: Label showing the total of all the dice values
            total_label.text = i18n.tr ("Total: %n").replace ("%n", t)
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
                if (best_error == undefined || (e < best_error && (c + r) <= (n_rows + n_cols))) {
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
                var col = Math.floor (i / n_rows)
                var row = i % n_rows
                dice[i].x = x_offset + col * die_step
                dice[i].y = y_offset + row * die_step
            }
        }
    }
}
