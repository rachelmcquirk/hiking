z = require 'zorium'
Button = require 'zorium-paper/button'
Input = require 'zorium-paper/input'
Icon = require 'zorium-paper/icon'
paperColors = require 'zorium-paper/colors.json'
_ = require 'lodash'

if window?
  require './index.styl'

hikes = require '../../models/hikes'

module.exports = class Hike
  constructor: ({hike}) -> #
    @$checkIcon = new Icon()
    @$closeIcon = new Icon()
    @$backIcon = new Icon()

    @state = z.state #
      hike: hike #

  render: =>
    {hike} = @state.getValue()

    hikeObject = hikes[hike]

    z '.z-hike', # <div class='z-hike'>
      z '.content', # <div class='content'>
        z @$backIcon,
          icon: 'arrow-left'
          isTouchTarget: true
          onclick: ->
            console.log 'click'
            window.history.back()
        z 'h5', hikeObject?.name
      z '.nav-bar',
        z.router.link z 'a.tab.active', {
          href: '/'
        },
          'Details'
        z.router.link z 'a.tab', {
          href: '/photos'
        },
          'Photos'
      z '.details',
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
            z 'h5', 'ADDRESS'
            hikeObject?.address
          z '.parking',
            z 'h5', 'PARKING'
            hikeObject?.parking
          z '.highlights',
            z 'h5', 'HIKE HIGHLIGHTS'
            _.map hikeObject?.highlights, (positive) =>
              z '.positive',
                z @$checkIcon,
                  icon: 'check'
                positive
            _.map hikeObject?.negatives, (negative) =>
              z '.negative',
                z @$closeIcon,
                  icon: 'close'
                negative
