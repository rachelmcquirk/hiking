z = require 'zorium'
Button = require 'zorium-paper/button'
Input = require 'zorium-paper/input'
Icon = require 'zorium-paper/icon'
paperColors = require 'zorium-paper/colors.json'
_ = require 'lodash'

hikes = require '../../models/hikes'
HikeMap = require '../hike_map'
HikePhotos = require '../hike_photos'
HikeDetails = require '../hike_details'

if window?
  require './index.styl'

module.exports = class Hike
  constructor: ({hike, tab}) -> # same as hike = options.hike; tab = options.tab
    @$backIcon = new Icon()
    @$hikeMap = new HikeMap {hike} #passing through hike so that it knows which hike
    @$hikePhotos = new HikePhotos {hike}
    @$hikeDetails = new HikeDetails {hike}

    @state = z.state #
      hike: hike #
      tab: tab

  render: =>
    {hike, tab} = @state.getValue()

    hikeObject = hikes[hike]

    z '.z-hike', # <div class='z-hike'>
      z '.content', # <div class='content'>
        z 'h5',
          z @$backIcon,
            icon: 'arrow-left'
            isTouchTarget: true
            onclick: ->
              console.log 'click'
              window.history.back()
          hikeObject?.name
      z '.nav-bar',
        z.router.link z 'a.tab.active', {
          href: hikeObject?.path + '/details'
        },
          'Details'
        z.router.link z 'a.tab', {
          href: "#{hikeObject?.path}/photos"
        },
          'Photos'
      if tab is 'photos'
        z @$hikePhotos
      else if tab is 'details'
        z @$hikeDetails
