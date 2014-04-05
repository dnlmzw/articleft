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
        watch:
            coffee:
                files: ['<%= config.lib %>/scripts/*.coffee']
                tasks: ['coffee']
    
    grunt.registerTask 'default', [
        'coffee'
    ]

    #grunt.loadNpmTasks name