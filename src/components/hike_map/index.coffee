z = require 'zorium'
Button = require 'zorium-paper/button'
Input = require 'zorium-paper/input'
Icon = require 'zorium-paper/icon'
paperColors = require 'zorium-paper/colors.json'
_ = require 'lodash'

hikes = require '../../models/hikes'

if window?
  require './index.styl'

# state:
#   - use when you might need to change the variable you're passing in, or
#     if you need to access the variable from something other than render
#     - eg. passing in hike to a component, so the afterMount can use it
#     - eg. passing in a color to a component, that might be changed
#       programatically by the user
#   - pass it in like: `@$componentName = new Component({valueHere})`
#   - access it from constructor: `constructor: ({valueHere})`
#   - set it in state with `@state = z.state {valueHere}`
#   - access it in other methods with `{valueHere} = @state.getValue()`
# props:
#   - use if it's a value that won't change and will only be used by render
#   - eg. passing in a color that doesn't change to the icon component
#   - pass it in from the inital inclusion of the component in the parent method
#     - eg. render: -> ... z @$compnentName, {valueHere}
#   - access it from render method: `render: ({valueHere})`


module.exports = class HikeMap
  constructor: ({hike}) ->
    @state = z.state
      hike: hike

  type: 'Widget'

  afterMount: =>
    {hike} = @state.getValue()

    hikeObject = hikes[hike]

    mapOptions =
      center:
        lat: hikeObject.latitude
        lng: hikeObject.longitude
      zoom: 15
    map = new (google.maps.Map)(document.getElementById('map-canvas'), mapOptions)

  render: =>
    z '.z-hike-map',
      z '#map-canvas'
