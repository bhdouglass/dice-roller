import QtQuick 2.4
import QtSensors 5.0
import Ubuntu.Components 1.3

Item {
    id: table

    property var dice: []
    property int count: 0
    property int total: 0
    property bool rolling: false
    property var die_size: units.gu(10)
    property var die_spacing: units.gu(1)

    //Catch orientation changes
    onWidthChanged: layout();
    onHeightChanged: layout();

    SensorGesture {
        id: sensorGesture
        enabled: true
        gestures : ["QtSensors.shake"]
        onDetected: roll()
    }

    function add(num, values) {
        var die_component = Qt.createComponent('Die.qml');
        var die = die_component.createObject(table);

        if (values) {
            die.values = values;
            die.num = values.length;
        }
        else {
            die.num = num;
        }

        die.width = die_size;
        die.height = die_size;
        die.opacity = 0;

        die.onChanged.connect(update_total);
        die.onRolled.connect(update_rolling);

        dice.push(die);
        count = dice.length;

        update_total();
        layout();

        die.animation_enabled = true;
        die.opacity = 1;
        die.roll();
    }

    function add_multiple(dice) {
        for (var i = 0; i < dice.length; i++) {
            add(dice[i].num, dice[i].value);
        }
    }

    function remove() {
        if (dice.length > 0) {
            var die = dice.pop();
            die.discard()
            count = dice.length;

            update_total();
            layout();
        }
    }

    function clear() {
        while (dice.length > 0) {
            remove();
        }
    }

    function roll() {
        if (!rolling) {
            for(var i = 0; i < dice.length; i++) {
                dice[i].roll()
            }

            update_rolling();
        }
    }

    function update_total() {
        var t = 0;
        for (var i = 0; i < dice.length; i++) {
            t += parseInt(dice[i].value);
        }

        total = t;
    }

    function update_rolling() {
        var r = false;
        for (var i = 0; i < dice.length; i++) {
            if (dice[i].is_rolling()) {
                r = true
            }
        }

        rolling = r;
    }

    function layout() {
        if (dice.length > 0) {
            // Layout in grid that matches the allocated area
            var n_cols = 1;
            var n_rows = 1;
            var aspect = table.width / table.height;
            var best_error;
            for(var r = 1; r <= dice.length; r++) {
                var c = Math.ceil(dice.length / r);
                var a = c / r;
                var e = Math.abs(aspect - a);
                if (best_error == undefined ||(e < best_error &&(c + r) <=(n_rows + n_cols))) {
                    n_cols = c;
                    n_rows = r;
                    best_error = e;
                }
            }

            // Move to this location
            var grid_width = n_cols * die_size +(n_cols - 1) * die_spacing;
            var grid_height = n_rows * die_size +(n_rows - 1) * die_spacing;
            var x_offset =(table.width - grid_width) * 0.5;
            var y_offset =(table.height - grid_height) * 0.5;
            var die_step = die_size + die_spacing;
            for(var i = 0; i < dice.length; i++) {
                var col = Math.floor(i / n_rows);
                var row = i % n_rows;
                dice[i].x = x_offset + col * die_step;
                dice[i].y = y_offset + row * die_step;
            }
        }
    }
}
