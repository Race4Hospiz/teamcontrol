# A class-based template for jQuery plugins in Coffeescript
#
#     $('.target').myPlugin({ paramA: 'not-foo' });
#     $('.target').myPlugin('myMethod', 'Hello, world');
#
# Check out Alan Hogan's original jQuery plugin template:
# https://github.com/alanhogan/Coffeescript-jQuery-Plugin-Template
#
(($, window) ->

  # Define the plugin class
  class Timer

    defaults:
      mode: 'timer'  # timer or countdown
      show_seconds: true
      interval: 1000 # 1 second update interval
      duration: 0    # required for countdown
      warning: 0     #
      error: 0

    constructor: (el, options) ->
      @$el = $(el)
      @options = $.extend(@$el.data(), @defaults, options)
      @start = if @options.current? then @options.current else Date.now()
      console.log @, Date.now()
      @update()
      @setInterval()

    setInterval: ->
      cb = @update.bind @
      setInterval cb, @options.interval

    update: ->
      switch @options.mode
        when 'timer'
          diff = ((Date.now() - @start) / 1000) | 0
        when 'countdown'
          diff = @options.duration - (((Date.now() - @start) / 1000) | 0)

      minutes = (diff / 60) | 0
      seconds = (diff % 60) | 0

      minutes = if minutes < 10 then "0" + minutes else minutes
      seconds = if seconds < 10 then "0" + seconds else seconds

      content = if @options.show_seconds then minutes + ":" + seconds else minutes
      @$el.text content

  # Define the plugin
  $.fn.extend timer: (option, args...) ->
    @each ->
      $this = $(this)
      data = $this.data('timer')

      if !data
        $this.data 'timer', (data = new Timer(this, option))
      if typeof option == 'string'
        data[option].apply(data, args)

) window.jQuery, window

$ ->
  $('.timer').timer()