testx = require 'testx'
reporters = require 'testx-jasmine-reporters'

exports.config =
  directConnect: true
  specs: ['spec.coffee']

  capabilities:
    browserName: 'chrome'
    shardTestFiles: false
    maxInstances: 2


  framework: 'jasmine'
  jasmineNodeOpts:
    silent: true
    showColors: true
    defaultTimeoutInterval: 300000
    includeStackTrace: true

  baseUrl: 'http://localhost:3000'

  params:
    testx:
      logScript: false
      actionTimeout: 5000

  onPrepare: ->
    reporters
      spec: true
      html: false
      junit: false
    beforeEach -> browser.ignoreSynchronization = true
