z = require 'zorium'
Button = require 'zorium-paper/button'
Input = require 'zorium-paper/input'
paperColors = require 'zorium-paper/colors.json'
_ = require 'lodash'

if window?
  require './index.styl'

hikes = require '../../models/hikes'
List = require '../list'
Map = require '../map'


module.exports = class Home
  constructor: ->
    @$button = new Button()
    @$input = new Input()
    @$list = new List()
    @$map = new Map()

    @state = z.state
      tab: 'list'

  render: =>
    {tab} = @state.getValue()

    z '.z-home', # <div class='z-home'>
      z '.content', # <div class='content'>
        '5 Beautiful Bay Area Hikes'
      z '.nav-bar',
        z 'a.tab', {
          className: z.classKebab {isActive: tab is 'list'}
          href: '#'
          onclick: =>
            @state.set tab: 'list'
        },
          'List'
        z 'a.tab', {
          className: z.classKebab {isActive: tab is 'map'}
          href: '#'
          onclick: =>
            @state.set tab: 'map'
        },
          'Map'
      if tab is 'list'
        z @$list
      else if tab is 'map'
        z @$map
