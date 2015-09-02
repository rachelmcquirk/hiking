z = require 'zorium'
Button = require 'zorium-paper/button'
Input = require 'zorium-paper/input'
Icon = require 'zorium-paper/icon'
paperColors = require 'zorium-paper/colors.json'
_ = require 'lodash'

hikes = require '../../models/hikes'
HikeMap = require '../hike_map'

if window?
  require './index.styl'

module.exports = class HikeDetails
  constructor: ({hike}) -> # same as hike = options.hike;
    @$checkIcon = new Icon()
    @$closeIcon = new Icon()
    @$hikeMap = new HikeMap {hike} #passing through hike so that it knows which hike


    @state = z.state #
      hike: hike #

  render: =>
    {hike} = @state.getValue()

    hikeObject = hikes[hike]

    z '.z-hike-details',
      z 'img.picture',
        src: hikeObject?.picture
      z '.hike-info',
        z '.hike-length',
          z 'img.length',
            src: '/pictures/hike2.png'
          hikeObject?.length
          z '.difficulty',
            'Difficulty: ' + hikeObject?.difficulty
        z '.address',
          z 'h5', 'Location'
            z '.space', hikeObject?.location
            '*Click on the marker for directions'
            z @$hikeMap
        z '.parking',
          z 'h5', 'PARKING'
            z '.space', hikeObject?.parking
        z '.highlights',
          z 'h5', 'HIKE HIGHLIGHTS'
          _.map hikeObject?.highlights, (positive) =>
            z '.positive.space',
              z @$checkIcon,
                icon: 'check'
              positive
          _.map hikeObject?.negatives, (negative) =>
            z '.negative.space',
              z @$closeIcon,
                icon: 'close'
              negative
