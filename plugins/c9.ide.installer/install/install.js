define(function(require, exports, module) {
    
module.exports = function(session, options) {
    session.introduction = require("text!./intro.html");
    session.preInstallScript = require("text!./check-deps.sh");
    session.install({
        "name": "tmux", 
        "description": "Tmux - the terminal multiplexer",
        "cwd": "~/.c9"
    }, {
        "bash": require("text!./tmux.sh")
    });
    session.start();
};


});
