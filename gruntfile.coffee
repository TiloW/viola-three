module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.initConfig
          
    connect:
        server:
          options:
            port: 8080
            base: 'public'
    coffee:
      options:
        sourceMap: true
      compile:
        files:
          'public/build/main.js': 'public/src/**/*.coffee'
          
    watch:
      scripts:
        files: 'public/src/**/*.coffee'
        tasks: ['coffee']
        options: 
          spawn: false

  grunt.registerTask 'default', 'launch the server for preview', ['coffee', 'connect', 'watch']
