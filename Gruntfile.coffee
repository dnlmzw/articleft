module.exports = (grunt) ->

    # Load grunt tasks automatically
    require('load-grunt-tasks')(grunt);

    # config

    grunt.initConfig

        config:
            lib: 'lib'
            src: 'src'
            dist: 'dist'

        coffee: 
            compile:
                expand: true
                cwd: '<%= config.lib %>/scripts/'
                src: '*.coffee'
                dest: '<%= config.src %>/scripts/'
                ext: '.js'

        uglify:
            dist:
                expand: true
                cwd: '<%= config.src %>/scripts/'
                src: '*.js'
                dest: '<%= config.dist %>'

        watch:
            coffee:
                files: ['<%= config.lib %>/scripts/*.coffee']
                tasks: ['coffee']
    
    # ###
    # Development
    grunt.registerTask 'dev', [
        'coffee'
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
