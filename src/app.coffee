z = require 'zorium'
paperColors = require 'zorium-paper/colors.json'
Rx = require 'rx-lite'
Routes = require 'routes'
Qs = require 'qs'

config = require './config'
gulpConfig = require '../gulp_config'
HomePage = require './pages/home'
HikePage = require './pages/hike'
FourOhFourPage = require './pages/404'

ANIMATION_TIME_MS = 500

styles = if not window? and config.ENV is config.ENVS.PROD
  # Avoid webpack include
  _fs = 'fs'
  fs = require _fs
  fs.readFileSync gulpConfig.paths.dist + '/bundle.css', 'utf-8'
else
  null

bundlePath = if not window? and config.ENV is config.ENVS.PROD
  # Avoid webpack include
  _fs = 'fs'
  fs = require _fs
  stats = JSON.parse \
    fs.readFileSync gulpConfig.paths.dist + '/stats.json', 'utf-8'

  "/#{stats.hash}.bundle.js"
else
  null

module.exports = class App
  constructor: ({requests}) ->
    router = new Routes()

    requests = requests.map ({req, res}) ->
      route = router.match req.path
      $page = route.fn()

      return {req, res, route, $page}

    $homePage = new HomePage({
      requests: requests.filter ({$page}) -> $page instanceof HomePage
    })
    $hikePage = new HikePage({
      requests: requests.filter ({$page}) -> $page instanceof HikePage
    })
    $fourOhFourPage = new FourOhFourPage({
      requests: requests.filter ({$page}) -> $page instanceof FourOhFourPage
    })

    router.addRoute '/', -> $homePage
    router.addRoute '/hikes/san-francisco-bay/:hike', -> $hikePage
    router.addRoute '/hikes/san-francisco-bay/:hike/:tab', -> $hikePage
    router.addRoute '*', -> $fourOhFourPage

    handleRequest = requests.doOnNext ({req, res, route, $page}) =>
      {$currentPage} = @state.getValue()

      if $page instanceof FourOhFourPage
        res.status? 404

      isEntering = Boolean $currentPage

      if isEntering and window?
        @state.set {
          isEntering
          $nextPage: $page
        }

        window.requestAnimationFrame =>
          setTimeout =>
            @state.set
              isActive: true

        setTimeout =>
          @state.set
            $currentPage: $page
            $nextPage: null
            isEntering: false
            isActive: false
        , ANIMATION_TIME_MS
      else
        @state.set
          $currentPage: $page

    @state = z.state {
      handleRequest: handleRequest
      $currentPage: null
      $nextPage: null
      isEntering: false
      isActive: false
    }

  render: =>
    {$nextPage, $currentPage, isEntering, isActive} = @state.getValue()

    z 'html',
      $currentPage?.renderHead {styles, bundlePath}
      z 'body',
        z '#zorium-root',
          z '.z-root',
            className: z.classKebab {isEntering, isActive}
            z '.current',
              $currentPage
            # z '.next',
            #   $nextPage
