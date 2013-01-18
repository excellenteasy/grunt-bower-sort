#
# grunt-bower-sort
# https://github.com/excellenteasy/grunt-bower-sort
#
# Copyright (c) 2013 excellenteasy, David Pfahler and Stephan Bönnemann
# Licensed under the MIT license.
#

'use strict'

module.exports = (grunt) ->

  bower = require 'bower'
  _ = grunt.util._

  grunt.registerTask 'bower-sort', 'sort bower components by dependencies', ->

    done = @async()

    # get dependencies tree
    bower.commands.list().on 'data', (tree) ->

      sortedComponents = []

      sort = (name, component) ->

        if component.dependencies
          sort nextName, nextComponent for nextName, nextComponent of component.dependencies

        if sortedComponents.indexOf(name) is -1
          sortedComponents.push name

      sort(name, component) for name, component of tree

      grunt.log.writeln JSON.stringify sortedComponents

      done()