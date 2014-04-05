# ###
# Script to include
# var js = document.createElement("script"); js.type = "text/javascript"; js.src = 'http://localhost/scripts/main.js'; document.body.appendChild(js);

# Articleft object
articleft =

  # Amount of words an average reader can read
  readingAverage: 
    low: 250
    high: 300

  # Message to prompt the reader with
  # once the calculation is done
  message:
    first: 'There is approximately '
    last: ' minutes left of this article.'

  # Initialize object
  init: ->

    # Load dependent scripts
    articleft.loadScripts()

    # jQuery no conflicting
    $.noConflict();

    # ###
    # On jQuery document ready
    jQuery(document).ready ($) ->

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
      scrolltop = $('body').scrollTop()

      # The number the <p> tag is located at in the
      # array containing all the <p> tags
      topParagraphNumber = 0;

      # Variable containing reference to all <p> tags
      paragraphs = $('p,blockquote,h1,h2,h3,h4,h5,h6', mainContainer)

      # Loop through all the <p> tags to determine 
      # which has the closest position to the scrolltop
      paragraphs.each (i) ->
        
        # We test to see if the position of the <p> tag
        # is bigger than the body scrolltop
        if $(this).offset().top > scrolltop
          
          # Uncomment to see if it has catched
          # the correct <p> tag
          # console.log $(this).text()

          # We set the current to be the <p> tag closest to
          # the top of the scrolltop
          topParagraphNumber = i;

          # Break the loop
          return false;
        
      # Variable which the remaining words will be added to
      wordsLeft = 0

      # Loop through the <p> tags, starting from the number
      # which was defined to be the paragraph the scrolltop
      # had reached
      for num in [topParagraphNumber..paragraphs.length-1]
        # Add number of words in the current <p> tag to
        # the amount of words left in the article
        # console.log paragraphs.eq(num).text().split(' ').length

        wordsLeft += paragraphs.eq(num).text().split(' ').length

      mins = articleft.getFormattedMinutes(wordsLeft / articleft.readingAverage.low)

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
        'z-index: 9999;' 

      spanCss =
        'color: white;' +
        'display: table-cell;' +
        'vertical-align: middle;' +
        'text-align: center;' + 
        'font-size: 60px;' +
        'font-family: Georgia;'

      displayer = $ '<div style="' + divCss + '"><span style="' + spanCss + '">' + mins + '</span></div>'
      
      # Append displayer to screen
      $('body').append displayer

      # Fade out and delete
      displayer.delay(500).fadeOut 350, ->
        displayer.remove()

      #alert articleft.message.first + articleft.getFormattedMinutes(wordsLeft / articleft.readingAverage.low) + articleft.message.last
        
  # ###
  # Returns a string where the time after the decimal is displayed as seconds
  getFormattedMinutes: (time) ->
    time = String(time).split('.')
    return time[0] + ':' + articleft.getFormattedBelowTen(Math.round(60*Number("0."+time[1])))

  # ###
  # Returns a string where everything under 10 gets a 0 added in front
  getFormattedBelowTen: (number) ->
    if number < 10
      return "0" + number
    return number

  # Dependent scripts
  loadScripts: ->
    
    # Scripts Articleft is depending on
    dependencies = [
      'https://code.jquery.com/jquery-1.11.0.min.js'
    ]

    # Add scripts to DOM
    for scriptUrl in dependencies
      js = document.createElement "script"
      js.type = "text/javascript";
      js.src = scriptUrl
      document.body.appendChild(js);

# Initiatlize articleft
articleft.init();
