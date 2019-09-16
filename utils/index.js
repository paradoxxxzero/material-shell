const { GLib } = imports.gi;

/* exported range */
var range = to =>
    // Returns a list containing all integers from 0 to `to`
    Array(to)
        .fill()
        .map((_, i) => i);

let doLogTick = false;
/* exported startLogTick */
var startLogTick = function() {
    doLogTick = true;
    logTick();
};

function logTick() {
    GLib.idle_add(GLib.PRIORITY_DEFAULT, () => {
        log('tick');
        if (doLogTick) {
            logTick();
        }
    });
}
/* exported stopLogTick */
var stopLogTick = function() {
    doLogTick = false;
};
