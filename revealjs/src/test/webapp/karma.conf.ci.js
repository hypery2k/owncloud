var baseConfig = require('./karma.conf.js');

module.exports = function(config){
    // Load base config
    baseConfig(config);

    // Override base config
    config.set({
        // web server port
        port: 10080,
        singleRun: true,
        autoWatch: false
    });
};