z = require 'zorium'
Button = require 'zorium-paper/button'
Input = require 'zorium-paper/input'
Icon = require 'zorium-paper/icon'
paperColors = require 'zorium-paper/colors.json'
_ = require 'lodash'

hikes = require '../../models/hikes'
PhotoModal = require '../photo_modal'

if window?
  require './index.styl'

module.exports = class HikePhotos
  constructor: ({hike}) -> # same as hike = options.hike; tab = options.tab
    @$photoModal = new PhotoModal {hike}

    @state = z.state #
      hike: hike #
      isPhotoModalVisible: false
      currentPhoto: null
      currentPhotoIndex: null

  render: =>
    {hike, isPhotoModalVisible, currentPhotoIndex} = @state.getValue()

    hikeObject = hikes[hike]

    z '.z-hike-photos', # <div class='z-hike'>
      z '.photos'
      _.map hikeObject?.photos, (photo, i) =>
        z '.photo',
          onclick: =>
            @state.set {isPhotoModalVisible: true, currentPhotoIndex: i}
            console.log (i)
          style:
            backgroundImage: "url(/pictures#{photo})"

      if isPhotoModalVisible is true
        z @$photoModal, {
          currentPhoto: hikeObject?.photos[currentPhotoIndex]
          onClose: =>
            @state.set isPhotoModalVisible: false
          onNext: =>
            if currentPhotoIndex is hikeObject.photos.length - 1
              @state.set {currentPhotoIndex: 0}
            else
              @state.set {currentPhotoIndex: currentPhotoIndex + 1}
          onPrevious: =>
            if currentPhotoIndex is 0
              @state.set {currentPhotoIndex: hikeObject?.photos.length - 1}
            else
              @state.set {currentPhotoIndex: currentPhotoIndex - 1}
        }
