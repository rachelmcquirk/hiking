z = require 'zorium'
Rx = require 'rx-lite'

Head = require '../../components/head'
Hike = require '../../components/hike'

module.exports = class HikePage
  constructor: ({requests}) -> #
    hike = requests.map ({route}) -> #
      return route.params.hike #
    tab = requests.map ({route}) -> #
      return route.params.tab #
    @$head = new Head()
    @$hike = new Hike({hike, tab}) #

  renderHead: (params) =>
    z @$head, params

  render: =>
    z '.p-hike',
      @$hike
