define(function(require, exports, module) {
    
module.exports = function(session, options) {
    session.introduction = require("text!./intro.html");
    session.preInstallScript = require("text!./check-deps.sh");
    
    session.install({
        "name": "Pty.js",
        "description": "Pseudo Terminal support. Used by the Cloud9 Terminal",
        "cwd": "~/.c9"
    }, {
        "npm": ["node-gyp", "https://github.com/ddm/pty.js.git"]
    });
    
    session.install({
        "name": "tmux", 
        "description": "Tmux - the terminal multiplexer",
        "cwd": "~/.c9"
    }, {
        "bash": require("text!./tmux.sh")
    });

    // Show the installation screen
    session.start();
};

});
