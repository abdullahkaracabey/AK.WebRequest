'use strict'

module.exports = (grunt) ->

  # Load grunt tasks automatically
  require('load-grunt-tasks')(grunt);
  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    clean: ['.tmp','dist']
    uglify:
      options:
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
      dist:
        src: '.tmp/built.js'
        dest: 'dist/<%= pkg.name %>.min.js'
    coffee:
      options:
        sourceMap: true,
        sourceRoot: ''
      dist:
        files: [{
          expand: true,
          cwd: 'src',
          src: '{,*/}*.coffee',
          dest: '.tmp',
          ext: '.js'
        }]
    concat:
      dist:
        cwd: '.tmp'
        src: ['object.js', 'string.js', 'request-service.js', 'api_urls.js']
        dest:'built.js'
    #   ng-annotate tries to make the code safe for minification automatically
    #   by using the Angular long form for dependency injection.
    ngAnnotate:
      dist:
        files: [{
          expand: true,
          cwd: '.tmp',
          src: 'built.js',
          dest: '.tmp'
        }]
  # Default task(s).
  grunt.registerTask 'default', ['clean','coffee','concat','ngAnnotate','uglify']
  return