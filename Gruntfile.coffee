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

      client:
        files: ['app/assets/script/**/*.coffee']
        tasks: ['coffeelint:client', 'coffee', 'concat:js']

      server:
        files: ['server/**/*.coffee', 'index.coffee', 'test/**/*.coffee']
        tasks: ['coffeelint:server', 'mochacli:server']

      grunt:
        files: ['Gruntfile.coffee']
        tasks: ['coffeelint:grunt']

    # JS Concatenation
    concat:
      options:
        banner: '/* <%= pkg.name %> - v<%= pkg.version %> - ' +
          '<%= grunt.template.today("yyyy-mm-dd") %> */\n\n'
      js:
        src: [
          'vendor/**/*.js'
          'temp/js/**/*.js',
          'app/assets/script/helpers.js'
        ]
        dest: 'public/app.js'
      css:
        src: [
          'vendor/normalize-css/normalize.css',
          'temp/css/style.css'
        ]
        dest: 'public/app.css'

    # Sass Compiler
    sass:
      dist:
        options:
          loadPath: 'vendor/'
        files:
          'temp/css/style.css': 'app/assets/style/style.scss'

    # Coffee Compilation
    coffee:
      compile:
        files:
          'temp/js/app.js': ['app/assets/script/**/*.coffee']

    coffeelint:
      client: ['app/assets/script/**/*.coffee']
      server: ['index.coffee', 'server/**/*.coffee', 'test/*.coffee']
      grunt: ['Gruntfile.coffee']

    # Handlebars compiler
    handlebars:
      compile:
        options:
          namespace: "template"
          processName: (filePath) ->
            /app\/views\/([\/a-z_-]+).hbs/i.exec(filePath)[1]
        files:
          'temp/js/templates.js': "app/views/**/*.hbs"

    bower:
      install:
        options:
          targetDir: "vendor/"

    install:
      bourbon:
        command: 'bourbon'
        args: ['install', '--path=vendor/']

    mochacli:
      server:
        options:
          files: 'test/server_spec.coffee'
          reporter: 'spec'
          compilers: ['coffee:coffee-script']

  }

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-handlebars'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-mocha-cli'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-bower-task'

  grunt.registerMultiTask 'install', 'Install something', ->
    done = @async()
    s = spawn(@data.command, @data.args)
    s.stdout.on 'data', (data) ->
      grunt.log.writeln data
    s.stderr.on 'data', (err) ->
      grunt.log.error err
    s.on 'close', (code) ->
      done(code is 0)

  # Compile CSS, JavaScript, Concatenate
  grunt.registerTask 'build', ['sass', 'handlebars', 'coffee', 'concat']

  # Install dependencies and compile
  grunt.registerTask 'bootstrap', ['bower', 'install:bourbon', 'build']

  # Development task. Build everything and then watch for changes
  grunt.registerTask 'development', ['build', 'watch']

  # If no argument is provided, just do the development thing
  grunt.registerTask 'default', ['development']
