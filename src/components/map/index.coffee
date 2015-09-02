z = require 'zorium'
Button = require 'zorium-paper/button'
Input = require 'zorium-paper/input'
paperColors = require 'zorium-paper/colors.json'
_ = require 'lodash'

hikes = require '../../models/hikes'

if window?
  require './index.styl'

module.exports = class Map
  constructor: ->
    @$button = new Button()
    @$input = new Input()

  afterMount: =>
    mapOptions =
      center:
        lat: 37.541460
        lng: -122.361007
      zoom: 10
      disableDefaultUI: true
    map = new google.maps.Map document.getElementById('map-canvas'), mapOptions
    _.map hikes, (hike) ->
      marker = new google.maps.Marker
        position:
          lat: hike.latitude
          lng: hike.longitude
        map: map
      infowindow = new google.maps.InfoWindow
        content: "<div class='z-map_info-window'><a href='#{hike.path}/details'>" + "<div id='photo' style='background-image: url(#{hike.picture})'></div>" +
        "<div id='hike-name'>#{hike.name}</div>" + "</a></div>"
        maxWidth: 300
      marker.addListener 'click', ->
        infowindow.open map, marker

  render: =>
    z '.z-map', # <div class='z-map'>
      z '#map-canvas',
