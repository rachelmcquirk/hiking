_ = require 'lodash'
z = require 'zorium'
Rx = require 'rx-lite'

Head = require '../../components/head'
Map = require '../../components/map'

module.exports = class MapPage
  constructor: ->
    @$head = new Head()
    @$map = new Map()

  renderHead: (params) =>
    z @$head, _.defaults {
      title: 'Zorium Seed - Map Page'
    }, params

  render: =>
    z '.p-map',
      @$map
