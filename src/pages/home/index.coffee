z = require 'zorium'
Rx = require 'rx-lite'

Head = require '../../components/head'
Home = require '../../components/home'

module.exports = class HomePage
  constructor: ->
    @$head = new Head()
    @$hello = new Home()

  renderHead: (params) =>
    z @$head, params

  render: =>
    z '.p-home',
      @$hello
