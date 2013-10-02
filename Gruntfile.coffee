requireTemplate = require 'grunt-template-jasmine-requirejs'

module.exports = (grunt) ->

  requireConfig =
    baseUrl: 'build/src-cov'
    paths:
      jquery: '../../../components/jquery/jquery'
      chaplin: '../../../components/chaplin/chaplin'
      backbone: '../../../components/backbone/backbone'
      underscore: '../../../components/underscore/underscore'
      'build/test': '../../../build/test'
    shim:
      jquery:
        exports: 'jQuery'
      underscore:
        exports: '_'
      chaplin:
        deps: ['backbone']
      backbone:
        exports: 'Backbone'
        deps: ['underscore', 'jquery']
    deps: [
      '../assets/jscoverage/jscoverage.js'
    ]

  grunt.initConfig

    pkg: require './package.json'

    clean:
      docs: ['docs']
      deps: ['components']
      build: ['build']

    coffeelint:
      source: 'src/**/*.coffee'
      grunt: 'Gruntfile.coffee'
      options:
        no_backticks: level: 'warn'
        arrow_spacing: level: 'warn'
        max_line_length: level: 'warn'
        no_stand_alone_at: level: 'warn'
        cyclomatic_complexity: level: 'warn'

    coffee:
      src:
        ext: '.js'
        cwd: 'src/'
        expand: true
        flatten: false
        src: '**/*.coffee'
        dest: 'build/src'

      spec:
        cwd: 'test/'
        expand: true
        flatten: false
        ext: '.spec.js'
        src: '**/*.spec.coffee'
        dest: 'build/test'

      helper:
        cwd: 'test/'
        expand: true
        flatten: false
        ext: '.helper.js'
        src: '**/*.helper.coffee'
        dest: 'build/test'

    jshint:
      all: ['build/src/**/*.js']
      options:
        boss: true
        expr: true
        eqnull: true
        shadow: true
        supernew: true

    requirejs:
      test:
        options:
          dir: 'build/src-amd'
          shim: requireConfig.shim
          paths: requireConfig.paths
          appDir: 'build/src'
          optimize: 'none'
          useStrict: true
          cjsTranslate: true

    blanket:
      instrument:
        files:
          'build/src-cov': ['build/src-amd']

    bower:
      install:
        options:
          copy: false

    connect:
      server:
        options: port: 9001

    jasmine:
      normal:
        src: ['build/src-cov/**/*.js']
        options:
          specs: ['build/test/**/*.js']
          helpers: [
            'components/sinon/lib/sinon.js'
            'components/sinon/lib/sinon/spy.js'
            'components/sinon/lib/sinon/**/*.js'
            'components/jasmine-sinon/lib/jasmine-sinon.js'
            'build/helper/**/*.js'
          ]
          template: requireTemplate
          templateOptions:
            requireConfig: requireConfig

      live:
        src: ['build/src-cov/**/*.js']
        options:
          host: 'http://localhost:9001'
          specs: ['build/test/**/*.js']
          styles: ['assets/jscoverage/jscoverage.css']
          helpers: [
            'components/sinon/lib/sinon.js'
            'components/sinon/lib/sinon/spy.js'
            'components/sinon/lib/sinon/**/*.js'
            'components/jasmine-sinon/lib/jasmine-sinon.js'
            'build/helper/**/*.js'
          ]
          outfile: 'specs.html'
          template: requireTemplate
          keepRunner: true
          templateOptions:
            requireConfig: requireConfig

    # docco:
    #   options: output: 'docs/'
    #   all: files: src: ['src/**/*.coffee']

    watch:
      # docs:
      #   files: ['*.md']
      #   tasks: ['docco']

      coffee:
        files: [
          'src/**/*.coffee'
          'test/**.*.coffee'
        ]
        tasks: [
          'coffeelint'
          'coffee'
          # 'docco:coffee'
        ]

      scripts:
        files: [
          'build/src/**/*.js'
          'build/test/**/*.js'
        ]
        tasks: [
          'jshint'
          'requirejs'
          'blanket'
          'jasmine:live'
          # 'docco'
        ]
        options: livereload: true

  grunt.loadNpmTasks 'grunt-blanket'
  grunt.loadNpmTasks 'grunt-markdown'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-bower-task'
  # grunt.loadNpmTasks 'grunt-docco-multi'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'

  grunt.registerTask 'default', [
    'clean'
    'coffeelint'
    'coffee'
    'jshint'
    'requirejs'
    'blanket'
    'bower'
    'jasmine:normal'
    # 'docco'
  ]

  grunt.registerTask 'live', [
    'clean:build'
    'coffeelint'
    'coffee'
    'jshint'
    'requirejs'
    'blanket'
    # 'bower'
    'connect'
    'jasmine:live'
    # 'docco'
    'watch'
  ]
