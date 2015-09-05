z = require 'zorium'
Button = require 'zorium-paper/button'
Input = require 'zorium-paper/input'
Icon = require 'zorium-paper/icon'
paperColors = require 'zorium-paper/colors.json'
_ = require 'lodash'

hikes = require '../../models/hikes'

if window?
  require './index.styl'

module.exports = class PhotoModal
  constructor: ({hike}) -> # same as hike = options.hike; tab = options.tab
    @$chevronRightIcon = new Icon()
    @$chevronLeftIcon = new Icon()
    @state = z.state #
      hike: hike #

  render: ({currentPhoto, currentPhotoIndex, onClose, onNext, onPrevious}) =>

    {hike} = @state.getValue()

    hikeObject = hikes[hike]

    z '.z-photo-modal',
      z '.overlay',
        onclick: =>
          onClose()
      z '.border',
        z '.previous',
          z @$chevronLeftIcon,
            icon: 'chevron-left'
            onclick: =>
              onPrevious()
        z 'img.current-photo',
          src: "/pictures#{currentPhoto}"
        z '.next',
          z @$chevronRightIcon,
            icon: 'chevron-right'
            onclick: =>
              onNext()
