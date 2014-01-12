spawn = require('child_process').spawn

module.exports = (grunt) ->
  grunt.initConfig {
    pkg: grunt.file.readJSON "package.json"
    # Watcher
    watch:
      sass:
        files: ['app/assets/style/**/*.scss']
        tasks: ['sass', 'concat:css']
        options:
          spawn: false
      handlebars:
        files: ['app/views/**/*.hbs']
        tasks: ['handlebars', 'concat:js']
        options:
          spawn: false

    # JS Concatenation
    concat:
      options:
        banner: '/* <%= pkg.name %> - v<%= pkg.version %> - ' +
          '<%= grunt.template.today("yyyy-mm-dd") %> */\n\n'
      js:
        src: [
          'vendor/**/*.js'
          'app/assets/script/helpers.js',
          'app/assets/script/templates.js'
        ]
        dest: 'public/app.js'
      css:
        src: [
          'vendor/normalize-css/normalize.css',
          'app/assets/style/style.css'
        ]
        dest: 'public/style.css'

    # Sass Compiler
    sass:
      dist:
        options:
          loadPath: 'vendor/'
        files:
          'app/assets/style/style.css': 'app/assets/style/style.scss'

    # Handlebars compiler
    handlebars:
      compile:
        options:
          namespace: "template"
          processName: (filePath) ->
            /app\/views\/([\/a-z_-]+).hbs/i.exec(filePath)[1]
        files:
          'app/assets/script/templates.js': "app/views/**/*.hbs"

    bower:
      install:
        options:
          targetDir: "vendor/"

    install:
      bourbon:
        command: 'bourbon'
        args: ['install', '--path=vendor/']

  }

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-handlebars'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-bower-task'

  grunt.registerMultiTask 'install', 'Install something', ->
    done = @async()
    s = spawn(@data.command, @data.args)
    s.on 'data', (data) ->
      grunt.log.writeln data
    s.on 'error', (err) ->
      grunt.log.error err
    s.on 'close', ->
      done()

  # Compile CSS, JavaScript, Concatenate
  grunt.registerTask 'build', ['sass', 'handlebars', 'concat']

  # Install dependencies and compile
  grunt.registerTask 'bootstrap', ['bower', 'install:bourbon', 'build']

  # Development task. Build everything and then watch for changes
  grunt.registerTask 'development', ['build', 'watch']

  # If no argument is provided, just do the development thing
  grunt.registerTask 'default', ['development']
