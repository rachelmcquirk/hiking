rewire = require 'rewire'
should = require('chai').should()
query = require 'vtree-query'

Home = rewire './index'

describe 'z-map', ->
  it 'goes to red page', (done) ->
    Home.__with__({
      'z.router.go': (path) ->
        path.should.eql '/red'
        done()
    }) ->
      $hello = new Map()

      $hello.goToRed()

  it 'says Hello World', ->
    $hello = new Map()

    $ = query($hello.render())
    $('.content').contents.should.eql 'Hello World'
