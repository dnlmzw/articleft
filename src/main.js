(function() {
  var $, articleft, getFormattedBelowTen, getFormattedMinutes, showMinuteDisplay;

  $ = null;

  articleft = {
    debugging: false,
    readingAverage: 250,
    init: function() {
      var js;
      if (window.jQuery == null) {
        js = document.createElement("script");
        js.type = "text/javascript";
        js.src = "//code.jquery.com/jquery-1.11.0.min.js";
        js.onload = function() {
          return window.jQuery(document).ready(articleft.ready);
        };
        return document.body.appendChild(js);
      } else {
        return articleft.ready();
      }
    },
    ready: function() {
      var formatedMinutes, mainContainer, max, num, scrolltop, textElements, topParagraphNumber, wordsLeft, _i, _ref;
      $ = window.jQuery;
      max = 0;
      mainContainer = null;
      $('p').parent().each(function() {
        if ($('p', this).length > max) {
          max = $('p', this).length;
          return mainContainer = $(this);
        }
      });
      scrolltop = $(document).scrollTop();
      topParagraphNumber = 0;
      textElements = $('h1,h2,h3,h4,h5,h6,li,p,blockquote', mainContainer);
      if (articleft.debugging) {
        textElements.css('border', '1px solid red');
      }
      textElements.each(function(i) {
        if ($(this).offset().top > scrolltop) {
          topParagraphNumber = i;
          return false;
        }
      });
      wordsLeft = 0;
      for (num = _i = topParagraphNumber, _ref = textElements.length - 1; topParagraphNumber <= _ref ? _i <= _ref : _i >= _ref; num = topParagraphNumber <= _ref ? ++_i : --_i) {
        wordsLeft += textElements.eq(num).text().split(' ').length;
      }
      formatedMinutes = getFormattedMinutes(wordsLeft / articleft.readingAverage);
      showMinuteDisplay(formatedMinutes);
      return $('.articleft-elem').delay(1000).fadeOut(350, function() {
        return $(this).remove();
      });
    }
  };

  showMinuteDisplay = function(formatedMinutes) {
    var divCss, minuteDisplay, spanCss;
    $('#articleftMinuteDisplay').remove();
    divCss = 'width: 150px;' + 'height: 150px;' + 'position: fixed;' + 'top: 50%;' + 'left: 50%;' + 'margin-top: -75px;' + 'margin-left: -75px;' + 'background: rgba(0,0,0,.85);' + 'display: table;' + 'border-radius: 10px;' + 'z-index: 99999999;';
    spanCss = 'color: white;' + 'display: table-cell;' + 'vertical-align: middle;' + 'text-align: center;' + 'font-size: 50px;' + 'font-family: Helvetica;';
    minuteDisplay = $('<div id="articleftMinuteDisplay" class="articleft-elem" style="' + divCss + '"><span style="' + spanCss + '">' + formatedMinutes + '</span></div>');
    return $('body').prepend(minuteDisplay);
  };


  /*showOverviewDisplay = (textElements) ->
  
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
  
     * Append overviewDisplay to DOM
    $('body').append overviewDisplay
   */


  /*insideScreen = (elem) ->
    inside = false
     *console.log 'top', $(elem).position().top + $(elem).height()
    console.log $(document).scrollTop()
  
     * if $('body').scrollTop() < $(elem).position().top + $(elem).height()
     *   inside = true
     * else if $('body').scrollTop() + $(window).height() > $(elem).position().top
     *   inside = true
  
    return inside
   */

  getFormattedMinutes = function(time) {
    time = String(time).split('.');
    return time[0] + ':' + getFormattedBelowTen(Math.round(60 * Number("0." + time[1])));
  };

  getFormattedBelowTen = function(number) {
    if (number < 10) {
      return "0" + number;
    }
    return number;
  };

  articleft.init();

}).call(this);
