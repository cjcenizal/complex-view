module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-angular-templates'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-gh-pages'

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    coffee:
      dev:
        dest: 'tmp/app.js'
        src: [
          'src/app/app.coffee'
          'src/app/**/*.coffee'
        ]

    jade:
      dev:
        files: [
          dest: 'dist/index.html'
          src: 'src/app/index.jade'
        ,
          expand: true
          cwd: 'src'
          dest: 'tmp'
          ext: '.html'
          src: [
            '**/*.jade'

            # exclude index from tmp and angular template cache
            '!app/index.jade'
          ]
        ]
        options:
          pretty: true
      prod:
        files: '<%= jade.dev.files %>'

    ngtemplates:
      app:
        dest: 'tmp/template.js'
        options:
          url: (url) ->
            url.replace('tmp/app/', '')
          module: 'FS'
        src: 'tmp/**/*.html'

    stylus:
      dev:
        files: [
          dest: 'dist/style/app.css'
          src: [
            # include base styles
            'src/style/app.styl'

            # include feature styles
            'src/app/**/index.styl'
          ]
        ]
        options:
          compress: false
          import: [
            'nib'

            # feature variable access
            'variable'
          ]
          paths: [
            'src/style'
          ]
          urlfunc: 'url'
      prod:
        files: '<%= stylus.dev.files %>'
        options:
          import: '<%= stylus.dev.options.import %>'
          paths: '<%= stylus.dev.options.paths %>'
          urlfunc: '<%= stylus.dev.options.urlfunc %>'

    clean:
      dev: [
        'dist'
        'tmp'
      ]

    concat:
      dev:
        files: [
          dest: 'dist/style/vendor.css'
          src: [
            'vendor/bower/foundation/css/foundation.css'
            'vendor/bower/font-awesome/css/font-awesome.css'
          ]
        ,
          dest: 'dist/script/vendor.js',
          src: [
            'vendor/bower/jQuery/jquery.js'
            'vendor/bower/angular/angular.js'
            'vendor/bower/angular-animate/angular-animate.js'
            'vendor/bower/angular-route/angular-route.js'
            'vendor/bower/foundation/js/foundation.js'
            'vendor/bower/underscore/underscore.js'
            'vendor/scripts/angular-table.js'
          ]
        ]

      prod:
        files: [
          dest: 'dist/style/vendor.css'
          src: [
            'vendor/bower/foundation/css/foundation.min.css'
            'vendor/bower/font-awesome/css/font-awesome.min.css'
          ]
        ,
          dest: 'dist/script/vendor.js',
          src: [
            'vendor/bower/jQuery/jquery.min.js'
            'vendor/bower/angular/angular.min.js'
            'vendor/bower/angular-animate/angular-animate.min.js'
            'vendor/bower/angular-route/angular-route.min.js'
            'vendor/bower/foundation/js/foundation.min.js'
            'vendor/bower/underscore/underscore-min.js'
            'vendor/scripts/angular-table.min.js'
          ]
        ]

      scripts:
        files: [
          dest: 'dist/script/app.js'
          src: [
            '<%= coffee.dev.dest %>'
            '<%= ngtemplates.app.dest %>'
          ]
        ]

    connect:
      server:
        options:
          base: 'dist'
          port: 8787

    copy:
      dev:
        files: [
          cwd: 'src'
          dest: 'dist/asset/'
          expand: true
          flatten: true
          src: 'asset/**/*'
        ,
          cwd: 'src'
          dest: 'dist/fonts/'
          expand: true
          flatten: true
          src: 'font/**/*'
        ,
          cwd: 'src'
          dest: 'dist/img/'
          expand: true
          flatten: true
          src: 'img/**/*'
        ,
          cwd: 'vendor/bower'
          dest: 'dist/fonts/'
          expand: true
          flatten: true
          src: 'font-awesome/fonts/**/*'
        ,
          cwd: 'vendor/bower'
          dest: 'dist/script/'
          expand: true
          flatten: true
          src: 'modernizr/modernizr.js'
        ]

    'gh-pages':
      docs:
        options:
          base: 'dist'
        src: [
          '**'
        ]

    uglify:
      prod:
        files: [
          dest: 'dist/script/app.js'
          src: 'dist/script/app.js'
        ,
          dest: 'dist/script/modernizr.js'
          src: 'dist/script/modernizr.js'
        ,
          dest: 'dist/script/vendor.js'
          src: 'dist/script/vendor.js'
        ]

    watch:
      coffee:
        files: 'src/**/*.coffee'
        options:
          interrupt: true
        tasks: [
          'coffee:dev'
          'concat:scripts'
        ]

      grunt:
        files: 'Gruntfile.coffee'

      jade:
        files: 'src/**/*.jade'
        options:
          interrupt: true
        tasks: [
          'jade:dev'
          'ngtemplates:app'
          'concat:scripts'
        ]

      stylus:
        files: 'src/**/*.styl'
        options:
          interrupt: true
        tasks: 'stylus:dev'

  grunt.registerTask 'default', 'Running development environment...', [
    'build:dev'
    'connect'
    'watch'
  ]

  grunt.registerTask 'build:dev', 'Running development tasks...', [
    'clean:dev'
    'coffee:dev'
    'jade:dev'
    'ngtemplates:app'
    'stylus:dev'
    'concat:dev'
    'concat:scripts'
    'copy:dev'
  ]

  grunt.registerTask 'build:prod', 'Running production tasks...', [
    'clean:dev'
    'coffee:dev'
    'jade:prod'
    'ngtemplates:app'
    'stylus:prod'
    'concat:prod'
    'concat:scripts'
    'copy:dev'
    'uglify:prod'
  ]

  grunt.registerTask 'pages', 'Running pages tasks...', [
    'build:prod'
    'gh-pages'
  ]
