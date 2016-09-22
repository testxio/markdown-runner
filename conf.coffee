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
    browser.driver.manage().window().maximize()
    testx.objects.add require './objects'
    reporters
      spec: true
      html:
        showPassed: true
        showStacktrace: true
        showSkipped: true
    beforeEach -> browser.ignoreSynchronization = true
