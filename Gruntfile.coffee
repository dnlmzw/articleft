module.exports = (grunt) ->
    
    # ###
    # Load package file
    pkg = require './package.json'

    # ###
    # Load grunt tasks automatically
    require('load-grunt-tasks')(grunt);    

    grunt.initConfig

        # ###
        # Package.json
        pkg: pkg

        # ###
        # Folder configuration
        config:
            lib: 'lib'
            src: 'src'
            dist: 'dist'

        # ###
        # Replace
        replace:
            manifest:
                src: '<%= config.lib %>/manifest.json'
                dest: '<%= config.src %>/manifest.json'
                replacements: [
                  { from: '[[name]]', to: pkg.name }
                  { from: '[[version]]', to: pkg.version }
                  { from: '[[description]]', to: pkg.description }
                ]

        # ###
        # Copy
        copy:
            dev:
                expand: true
                cwd: '<%= config.lib %>/'
                src: ['**/*', '!**/assets/**']
                dest: '<%= config.src %>/'
            dist:
                {}

        # ###
        # Coffeescript
        coffee: 
            compile:
                expand: true
                cwd: '<%= config.lib %>/scripts/'
                src: '*.coffee'
                dest: '<%= config.src %>/'
                ext: '.js'

        # ###
        # Uglify
        uglify:
            dist:
                expand: true
                cwd: '<%= config.src %>'
                src: '*.js'
                dest: '<%= config.dist %>'

        # ###
        # Watch
        watch:
            manifest:
                files: ['<%= config.lib %>/manifest.json']
                tasks: ['replace:manifest']
            coffee:
                files: ['<%= config.lib %>/scripts/*.coffee']
                tasks: ['coffee']
    
    # ###
    # Development
    grunt.registerTask 'dev', [
        'copy'
        'coffee'
        'replace'
        'watch'
    ]

    # ###
    # Distribution
    grunt.registerTask 'dist', [
        'coffee'
        'uglify'
    ]

    # ###
    # Default
    grunt.registerTask 'default', [
        'dev'
    ]
