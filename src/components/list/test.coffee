rewire = require 'rewire'
should = require('chai').should()
query = require 'vtree-query'

Home = rewire './index'

describe 'z-home', ->
  it 'goes to red page', (done) ->
    Home.__with__({
      'z.router.go': (path) ->
        path.should.eql '/red'
        done()
    }) ->
      $hello = new Home()

      $hello.goToRed()

  it 'says Hello World', ->
    $hello = new Home()

    $ = query($hello.render())
    $('.content').contents.should.eql 'Hello World'
