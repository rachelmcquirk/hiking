z = require 'zorium'
Rx = require 'rx-lite'

Head = require '../../components/head'
Hike = require '../../components/hike'

module.exports = class HikePage
  constructor: ({requests}) -> #
    hike = requests.map ({route}) -> #
      return route.params.hike #
    @$head = new Head()
    @$hike = new Hike({hike}) #

  renderHead: (params) =>
    z @$head, params

  render: =>
    z '.p-hike',
      @$hike
