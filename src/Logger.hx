package src;

class Logger {
    var mode:String = "console";
    public function new() {
        trace(this.mode);
        trace("amazing");
    }
    static public function log(text:String) {
        trace("logging", text);
    }
}