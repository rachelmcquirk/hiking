z = require 'zorium'
Button = require 'zorium-paper/button'
Input = require 'zorium-paper/input'
paperColors = require 'zorium-paper/colors.json'
_ = require 'lodash'

if window?
  require './index.styl'

hikes = require '../../models/hikes'

module.exports = class List
  constructor: ->
    @$button = new Button()
    @$input = new Input()

  render: =>
    z '.z-list',
      _.map hikes, (hike) ->
        z.router.link z 'a.hike', {
          href: "#{hike.path}/details"
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
