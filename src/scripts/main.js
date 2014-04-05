(function() {
  var articleft;

  articleft = {
    readingAverage: {
      low: 250,
      high: 300
    },
    message: {
      first: 'There is approximately ',
      last: ' minutes left of this article.'
    },
    init: function() {
      articleft.loadScripts();
      $.noConflict();
      return jQuery(document).ready(function($) {
        var displayer, divCss, mainContainer, max, mins, num, paragraphs, scrolltop, spanCss, topParagraphNumber, wordsLeft, _i, _ref;
        max = 0;
        mainContainer = null;
        $('p').parent().each(function() {
          if ($('p', this).length > max) {
            max = $('p', this).length;
            return mainContainer = $(this);
          }
        });
        scrolltop = $('body').scrollTop();
        topParagraphNumber = 0;
        paragraphs = $('p,blockquote,h1,h2,h3,h4,h5,h6', mainContainer);
        paragraphs.each(function(i) {
          if ($(this).offset().top > scrolltop) {
            topParagraphNumber = i;
            return false;
          }
        });
        wordsLeft = 0;
        for (num = _i = topParagraphNumber, _ref = paragraphs.length - 1; topParagraphNumber <= _ref ? _i <= _ref : _i >= _ref; num = topParagraphNumber <= _ref ? ++_i : --_i) {
          wordsLeft += paragraphs.eq(num).text().split(' ').length;
        }
        mins = articleft.getFormattedMinutes(wordsLeft / articleft.readingAverage.low);
        divCss = 'width: 150px;' + 'height: 150px;' + 'position: fixed;' + 'top: 50%;' + 'left: 50%;' + 'margin-top: -75px;' + 'margin-left: -75px;' + 'background: rgba(0,0,0,.85);' + 'display: table;' + 'border-radius: 10px;' + 'z-index: 9999;';
        spanCss = 'color: white;' + 'display: table-cell;' + 'vertical-align: middle;' + 'text-align: center;' + 'font-size: 60px;' + 'font-family: Georgia;';
        displayer = $('<div style="' + divCss + '"><span style="' + spanCss + '">' + mins + '</span></div>');
        $('body').append(displayer);
        return displayer.delay(500).fadeOut(350, function() {
          return displayer.remove();
        });
      });
    },
    getFormattedMinutes: function(time) {
      time = String(time).split('.');
      return time[0] + ':' + articleft.getFormattedBelowTen(Math.round(60 * Number("0." + time[1])));
    },
    getFormattedBelowTen: function(number) {
      if (number < 10) {
        return "0" + number;
      }
      return number;
    },
    loadScripts: function() {
      var dependencies, js, scriptUrl, _i, _len, _results;
      dependencies = ['https://code.jquery.com/jquery-1.11.0.min.js'];
      _results = [];
      for (_i = 0, _len = dependencies.length; _i < _len; _i++) {
        scriptUrl = dependencies[_i];
        js = document.createElement("script");
        js.type = "text/javascript";
        js.src = scriptUrl;
        _results.push(document.body.appendChild(js));
      }
      return _results;
    }
  };

  articleft.init();

}).call(this);
