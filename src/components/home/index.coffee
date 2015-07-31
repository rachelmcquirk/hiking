z = require 'zorium'
Button = require 'zorium-paper/button'
Input = require 'zorium-paper/input'
paperColors = require 'zorium-paper/colors.json'
_ = require 'lodash'

if window?
  require './index.styl'

hikes = require '../../models/hikes'

module.exports = class Home
  constructor: ->
    @$button = new Button()
    @$input = new Input()

  render: =>
    z '.z-home', # <div class='z-home'>
      z '.content', # <div class='content'>
        '5 Beautiful Bay Area Hikes'
      z '.nav-bar',
        z.router.link z 'a.tab.active', {
          href: '/'
        },
          'List'
        z.router.link z 'a.tab', {
          href: '/map'
        },
          'Map'
      z '.list',
        _.map hikes, (hike) ->
          z.router.link z 'a.hike', {
            href: hike.path
          },
            z 'img.picture',
              src: hike.picture
            z '.hike-info',
              z '.hike-info-left',
                z '.hike-name',
                  hike.name
                z '.hike-area',
                  hike.area
              z '.hike-length',
                z 'img.length',
                  src: '/pictures/hike.png'
                hike.length
