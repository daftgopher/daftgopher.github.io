(function() {
  var inputTextArea, isEventSupported, outputTextArea, processCase, supportedEvent,
    indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  inputTextArea = document.querySelectorAll('#converterInput')[0];

  outputTextArea = document.querySelectorAll('#converterOutput')[0];

  isEventSupported = function(eventName) {
    var el, isSupported;
    el = document.createElement('div');
    eventName = 'on' + eventName;
    isSupported = indexOf.call(el, eventName) >= 0;
    if (!isSupported) {
      el.setAttribute(eventName, 'return;');
      isSupported = typeof el[eventName] === 'function';
    }
    el = null;
    return isSupported;
  };

  supportedEvent = isEventSupported('paste') ? 'paste' : 'blur';

  processCase = function() {
    var contents, lineGroup, lines, lowerCaseLine;
    contents = inputTextArea.value;
    lowerCaseLine = function(line) {
      var newLine;
      newLine = [];
      line = line.split('. ');
      line.forEach(function(sentence) {
        sentence = sentence.charAt(0).toUpperCase() + sentence.substr(1).toLowerCase();
        sentence = sentence.replace(/\si(['|\s])/g, ' I$1');
        return newLine.push(sentence);
      });
      return newLine.join('. ');
    };
    lines = contents.split('\n');
    lineGroup = [];
    lines.forEach(function(line) {
      return lineGroup.push(lowerCaseLine(line));
    });
    return outputTextArea.value = lineGroup.join('\n');
  };

  inputTextArea.addEventListener('input', processCase, false);

  outputTextArea.addEventListener('focus', function() {
    this.select();
    return window.setTimeout((function(_this) {
      return function() {
        return _this.select();
      };
    })(this), 10);
  });

}).call(this);
