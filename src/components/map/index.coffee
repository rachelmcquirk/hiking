z = require 'zorium'
Button = require 'zorium-paper/button'
Input = require 'zorium-paper/input'
paperColors = require 'zorium-paper/colors.json'
_ = require 'lodash'

if window?
  require './index.styl'

hikes =
  purismaCreek:
    name: 'Purisima Creek'
    picture: '/pictures/purisima.jpg'
  moriPoint:
    name: 'Mori Point'
    picture: '/pictures/moripoint.jpg'
  sanPedroValley:
    name: 'San Pedro Valley'
    picture: '/pictures/sanpedro.jpg'


module.exports = class Map
  constructor: ->
    @$button = new Button()
    @$input = new Input()

  goToRed: ->
    z.router.go '/red'

  render: =>
    z '.z-map', # <div class='z-map'>
      z '.content', # <div class='content'>
        '5 Beautiful Bay Area Hikes'
      z '.nav-bar',
        z.router.link z 'a.tab', {
          href: '/'
        },
          'List'
        z.router.link z 'a.tab.active', {
          href: '/map'
        },
          'Map'
      z '.list',
        _.map hikes, (hike) ->
          z '.hike',
            z '.hike-name', hike.name
            z 'img.picture',
              src: hike.picture
