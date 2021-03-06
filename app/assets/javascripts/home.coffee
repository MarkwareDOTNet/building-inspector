class Home

  constructor: () ->
    h = @

    $(window).on('resize', () ->
      h.resizeSVG()
    )

    $(".learn-more").click( ()->
      h.getStarted()
    )

    @resizeSVG()
    @setWaypoints()
    @activateSlideshow()

  setWaypoints: () ->
    h = @
    $("#link-learn-more").waypoint( (direction)->
      $("#link-learn-more").waypoint('destroy')
      $.get('/general/home_explained', (data) ->
        d = $(data)
        $("#waypoint").append(d)
        .hide()
        .fadeIn(1000)
        $("#waypoint .learn-more").click( ()->
          h.getStarted()
        )
      )
    )

  getStarted: () ->
    $.scrollTo("#intro",
      easing:   "swing"
      duration: 400
    )

  resizeSVG: () =>
    maxWidth = 960
    maxHeight = 300
    w = $("#home-slideshow").width()
    # console.log "size:", w
    return if !(w > 0 && w < maxWidth)
    offset = (maxWidth - w) / 2
    svgs = document.getElementsByClassName("intro-path");
    for svg in svgs
      svg.setAttribute("viewBox", "#{offset} 0 #{w} #{maxHeight}");

  activateSlideshow: () ->
    $("#home-slideshow").swipeshow(
      autostart: true
      mouse: false
      initial: 0
      speed: 700
      interval: 5000
      onactivate: (slide, index) ->
        # console.log "activate", slide, index
        $("#slide-buttons a").removeClass("active")
        $("#link-geometry").addClass("active") if index==0
        $("#link-polygonfix").addClass("active") if index==1
        $("#link-address").addClass("active") if index==2
        $("#link-color").addClass("active") if index==3
    )
    $("#link-geometry").on("mouseover", ()->
      $("#home-slideshow").swipeshow().goTo(0)
    )
    $("#link-polygonfix").on("mouseover", ()->
      $("#home-slideshow").swipeshow().goTo(1)
    )
    $("#link-address").on("mouseover", ()->
      $("#home-slideshow").swipeshow().goTo(2)
    )
    $("#link-color").on("mouseover", ()->
      $("#home-slideshow").swipeshow().goTo(3)
    )
    # $("#link-address").addClass("active")
    # $("#link-polygonfix").addClass("active")

$ ->
  new Home()
