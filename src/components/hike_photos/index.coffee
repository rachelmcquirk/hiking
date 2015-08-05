z = require 'zorium'
Button = require 'zorium-paper/button'
Input = require 'zorium-paper/input'
Icon = require 'zorium-paper/icon'
paperColors = require 'zorium-paper/colors.json'
_ = require 'lodash'

hikes = require '../../models/hikes'

if window?
  require './index.styl'

module.exports = class HikePhotos
  constructor: ({hike}) -> # same as hike = options.hike; tab = options.tab

    @state = z.state #
      hike: hike #

  render: =>
    {hike} = @state.getValue()

    hikeObject = hikes[hike]

    z '.z-hike-photos', # <div class='z-hike'>
      'Photos'
