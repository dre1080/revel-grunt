###
Example Gruntfile

More information on using Grunt to work with static assets:
http://gruntjs.com/configuring-tasks
###
module.exports = (grunt) ->
  
  ###
  CSS files to inject in order
  (uses Grunt-style wildcard/glob/splat expressions)
  ###
  cssFilesToInject = ["assets/**/*.css"]
  
  ###
  Javascript files to inject in order
  (uses Grunt-style wildcard/glob/splat expressions)
  ###
  jsFilesToInject = [
    # *->    put other dependencies here   <-*
    
    # All of the rest of your app scripts imported here
    "assets/**/*.js"
  ]
  
  ###
  Client-side HTML templates are injected using the sources below
  The ordering of these templates shouldn't matter.
  (uses Grunt-style wildcard/glob/splat expressions)
  
  By default, uses JST templates and precompiles them into
  functions for you. If you want to use jade, handlebars, dust, etc.,
  edit the relevant sections below.
  ###
  templateFilesToInject = ["assets/templates/**/*.html"]
  
  # Modify css file injection paths to use 
  cssFilesToInject = cssFilesToInject.map((path) ->
    "public/" + path
  )
  
  # Modify js file injection paths to use 
  jsFilesToInject = jsFilesToInject.map((path) ->
    "public/" + path
  )

  templateFilesToInject = templateFilesToInject.map((path) ->
    "public/" + path
  )
  
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-jst"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-cssmin"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-stylus"
  
  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    copy:
      dev:
        files: [
          expand: true
          cwd: "./app/assets"
          src: [
            "**/*.!(coffee)"
            "!**/test/**"
            "!**/tests/**"
          ]
          dest: "public/assets"
        ]

    clean:
      dev: [
        "public/assets"
        "!public"
      ]
      dist: [
        "dist/*.js"
        "dist/*.css"
        "!dist/js"
        "!dist/css"
      ]
      build: [
        "conf/assets.json"
        "dist"
      ]

    jst:
      dev:
        # To use other sorts of templates, specify the regexp below:
        # options: {
        #   templateSettings: {
        #     interpolate: /\{\{(.+?)\}\}/g
        #   }
        # },
        files:
          "public/assets/javascripts/jst.js": templateFilesToInject

    stylus:
      dev:
        files: [
          {
            expand: true
            cwd: "app/assets/stylesheets/"
            src: ["*.styl"]
            dest: "public/assets/stylesheets/"
            ext: ".css"
          }
        ]

    coffee:
      dev:
        options:
          bare: true
        files: [
          {
            expand: true
            cwd: "app/assets/javascripts/"
            src: ["**/*.coffee"]
            dest: "public/assets/javascripts/"
            ext: ".js"
          }
        ]

    concat:
      js:
        src: jsFilesToInject
        dest: "dist/bundle.js"

      css:
        src: cssFilesToInject
        dest: "dist/bundle.css"

    uglify:
      dist:
        src: [
          "dist/bundle.js"
        ]
        dest: "dist/bundle.min.js"

    cssmin:
      dist:
        src: [
          "dist/bundle.css"
        ]
        dest: "dist/bundle.min.css"

    watch:
      assets:
        # Assets to watch:
        files: [
          "app/assets/**/*"
        ]
        
        # When assets are changed:
        tasks: [
          "compileAssets"
        ]

  grunt.registerTask "default", [
    "compileAssets"
    "watch"
  ]

  grunt.registerTask "compileAssets", [
    "clean:dev"
    "stylus:dev"
    "coffee:dev"
    "copy:dev"
  ]

  # Run this when building for production
  grunt.registerTask "build", [
    "clean:build"
    "stylus:dev"
    "copy:dev"
    "coffee:dev"
    "concat"
    "uglify"
    "cssmin"
    "clean:dist"
  ]
