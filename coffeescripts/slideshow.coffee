exports = this
exports.AutoPlay = null

jQuery(document).ready ($) ->

  Slideshow =
    inited: false

    settings:
      transitionSpeed: 300,
      delay: 5000,
      list: '#slideshow ul',
      handlers: '#handlers span.handler',
      activeCSS: 'active',
      playButton: '#slideshow_play'

    init: (options) ->
      $.extend(this.settings, options || {})
  
      $ul = $(this.settings.list)
      $contentWidth = $ul.width()
      totalWidth = $contentWidth * $ul.children('li').length
  
      $ul.width(totalWidth.toString() + 'px')
  
      clickHandler = ->
        clearTimeout(exports.AutoPlay)
    
        $(Slideshow.settings.handlers).removeClass(Slideshow.settings.activeCSS)
        $(this).parent().addClass(Slideshow.settings.activeCSS)
    
        margin = $contentWidth * ($(this).html() - 1)
        $ul.stop().animate({ marginLeft: -margin }, Slideshow.settings.transitionSpeed)
    
        $(Slideshow.settings.playButton).show()
    
        false
  
      $(this.settings.handlers).find('a').click(clickHandler)
      $(this.settings.playButton).find('a').click ->
        Slideshow.playButton($(this).parent())
        false
  
      this.inited = true

    playButton: (button) ->
      this.rotate()
      $(button).hide()
      this.inited = true
      this.play()

    rotate: ->
      next = $('#handlers span.' + this.settings.activeCSS).next(this.settings.handlers).find('a')
      first = $(this.settings.handlers + ':first').find('a')
      if next.length != 0 then next.trigger('click') else first.trigger('click')

    play: (options) ->
      if !this.inited then this.init(options)
  
      shift = ->
        Slideshow.rotate()
        $(Slideshow.settings.playButton).hide()
        exports.AutoPlay = setTimeout(shift, Slideshow.settings.delay)
  
      exports.AutoPlay = setTimeout(shift, this.settings.delay)