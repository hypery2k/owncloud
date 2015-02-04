'use strict';

module.exports = function (grunt) {
  require('load-grunt-tasks')(grunt);
  require('time-grunt')(grunt);
  grunt.loadNpmTasks('grunt-bower-task');

  grunt.initConfig({
	bower: {
	    install: {
	       //just run 'grunt bower:install' and you'll see files from your Bower packages in lib directory

	        options: {
	        	copy: false,
	        }
	    }
	  },
    yeoman: {
      // configurable paths
      app: require('./bower.json').appPath || 'src/main/webapp',
      dist: 'target'
    },
    autoprefixer: {
      options: ['last 1 version'],
      dist: {
        files: [{
          expand: true,
          cwd: '.tmp/styles/',
          src: '{,*/}*.css',
          dest: '.tmp/styles/'
        }]
      }
    },
    connect: {
      options: {
        port: 9000,
        // Change this to '0.0.0.0' to access the server from outside.
        hostname: 'localhost',
        livereload: 35729
      },
      livereload: {
        options: {
          open: true,
          base: [
            '.tmp',
            '<%= yeoman.app %>',
            '.'
          ]
        }
      },
      test: {
        options: {
          port: 9001,
          base: [
            '.tmp',
            'test',
            '<%= yeoman.app %>',
            'bower_components'
          ]
        }
      },
      dist: {
        options: {
          base: '<%= yeoman.dist %>'
        }
      }
    },
    clean: {
      dist: {
        files: [{
          dot: true,
          src: [
            '.tmp',
            '<%= yeoman.dist %>/*',
            '!<%= yeoman.dist %>/.git*'
          ]
        }]
      },
      server: '.tmp'
    },
    jshint: {
      options: {
        jshintrc: '.jshintrc'
      },
      all: [
        'Gruntfile.js',
        '<%= yeoman.app %>/scripts/{,*/}*.js'
      ]
    },
    karma: {
      unit: {
        configFile: 'src/test/webapp/karma.conf.js',
        singleRun: true
      }
    },
  });

  grunt.registerTask('test', [
    'clean',
    'autoprefixer',
    'connect:test',
    'karma'
  ]);

  grunt.registerTask('default', [
    'test'
  ]);
};
