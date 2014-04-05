# ###
# For testing purposes: Make a bookmark that includes this script
# javascript:if(window.articleft == null){var js = document.createElement("script"); js.type = "text/javascript"; js.src = 'http://localhost/main.js'; document.body.appendChild(js)}else{articleft.init();};

# Articleft object
articleft =

  # Debugging
  debugging: false

  # Amount of words an average reader can read
  readingAverage: 250

  # Initialize articleft
  init: ->

    # Check if jQuery exists
    if !window.jQuery?
      js = document.createElement "script"
      js.type = "text/javascript";
      js.src = "//code.jquery.com/jquery-1.11.0.min.js"
      js.onload = ->
        # Document ready
        window.jQuery(document).ready ->
          articleft.ready window.jQuery

      # Load jQuery
      document.body.appendChild(js);
    else
      articleft.ready window.jQuery


    #$ = jQuery.noConflict()

  # ###
  # On jQuery document ready
  ready: ($) ->

    console.log 'jQuery', $

    # Define max
    # ~ highest number of <p> tags in a container
    max = 0

    # Element that containing the most <p> tags
    mainContainer = null

    # Loop through the parent of all <p> nodes
    # to determine which container has the most <p> tags
    $('p').parent().each ->

      # Is the number of <p> tags in this element higher than the previous?
      if($('p',this).length > max)
        # Set max amount of <p> tags in the current container
        max = $('p',this).length
        # Define mainContainer
        mainContainer = $ this

    # Positon of the top of the <body> scrollbar
    scrolltop = $(document).scrollTop()

    # The number the <p> tag is located at in the
    # array containing all the <p> tags
    topParagraphNumber = 0;

    # Variable containing reference to all <p> tags
    textElements = $('h1,h2,h3,h4,h5,h6,li,p,blockquote', mainContainer)

    # Debugging
    if articleft.debugging
      textElements.css('border','1px solid red')

    # Loop through all the <p> tags to determine 
    # which has the closest position to the scrolltop
    textElements.each (i) ->
      
      # We test to see if the position of the <p> tag
      # is bigger than the body scrolltop
      if $(this).offset().top > scrolltop
        
        # Uncomment to see if it has catched
        # the correct <p> tag
        # console.log $(this).text()

        # We set the current to be the <p> tag closest to
        # the top of the scrolltop
        topParagraphNumber = i;

        # Tint background on current textElement with yellow and fade it out
        # textElements.eq(topParagraphNumber).css('background-color', 'rgba(255,255,0,.35)');

        # Break the loop
        return false;
      
    # Variable which the remaining words will be added to
    wordsLeft = 0

    # Loop through the <p> tags, starting from the number
    # which was defined to be the paragraph the scrolltop
    # had reached
    for num in [topParagraphNumber..textElements.length-1]
      # Add number of words in the current <p> tag to
      # the amount of words left in the article
      # console.log textElements.eq(num).text().split(' ').length

      wordsLeft += textElements.eq(num).text().split(' ').length

    # Minutes left formatted 00:00
    formatedMinutes = getFormattedMinutes(wordsLeft / articleft.readingAverage)

    # Display minutes left
    showMinuteDisplay formatedMinutes

    # Display page overview
    # showOverviewDisplay textElements

    # Fade out and remove
    $('.articleft-elem').delay(1000).fadeOut 350, ->
      $(this).remove()

showMinuteDisplay = (formatedMinutes) ->
  
  # Remove minute display if it already exists
  $('#articleftMinuteDisplay').remove()

  divCss =
    'width: 150px;' +
    'height: 150px;' +
    'position: fixed;' +
    'top: 50%;' +
    'left: 50%;' +
    'margin-top: -75px;' +
    'margin-left: -75px;' +
    'background: rgba(0,0,0,.85);' +
    'display: table;' +
    'border-radius: 10px;' +
    'z-index: 99999999;'


  spanCss =
    'color: white;' +
    'display: table-cell;' +
    'vertical-align: middle;' +
    'text-align: center;' + 
    'font-size: 50px;' +
    'font-family: Helvetica;'

  # Create element showing the minutes left
  minuteDisplay = $ '<div id="articleftMinuteDisplay" class="articleft-elem" style="' + divCss + '"><span style="' + spanCss + '">' + formatedMinutes + '</span></div>'
  
  # Append minuteDisplay to DOM
  $('body').prepend minuteDisplay

###showOverviewDisplay = (textElements) ->

  overviewCss =
    'width: 100px;' +
    'position: fixed;' +
    'top: 10px;' +
    'right: 10px;' +
    'background: rgba(0,0,0,.85);' +
    'padding: 10px;' +
    'border-radius: 10px;' +
    'z-index: 9999;'

  overviewDisplay = $ '<div id="articleftOverviewDisplay" class="articleft-elem" style="' + overviewCss + '"></div>'

  textElements.each ->
    
    textElementCss =
      'height:'+($(this).height()/10)+'px;' +
      'margin-bottom: 2px;' +
      'width: 100%;' +
      'background-color: rgba(255,255,255,' + ( if insideScreen(this) then '.85' else '.35' ) + ');'

    textElement = $ '<div style="' + textElementCss + '"></div>'

    overviewDisplay.append textElement

  # Append overviewDisplay to DOM
  $('body').append overviewDisplay###

###insideScreen = (elem) ->
  inside = false
  #console.log 'top', $(elem).position().top + $(elem).height()
  console.log $(document).scrollTop()

  # if $('body').scrollTop() < $(elem).position().top + $(elem).height()
  #   inside = true
  # else if $('body').scrollTop() + $(window).height() > $(elem).position().top
  #   inside = true

  return inside###

# ###
# Returns a string where the time after the decimal is displayed as seconds
getFormattedMinutes = (time) ->
  time = String(time).split('.')
  return time[0] + ':' + getFormattedBelowTen(Math.round(60*Number("0."+time[1])))

# ###
# Returns a string where everything under 10 gets a 0 added in front
getFormattedBelowTen = (number) ->
  if number < 10
    return "0" + number
  return number

articleft.init()