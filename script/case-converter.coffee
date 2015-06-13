---
---

inputTextArea = document.querySelectorAll('#converterInput')[0]
outputTextArea = document.querySelectorAll('#converterOutput')[0]

isEventSupported = (eventName) ->
	el = document.createElement('div')
	eventName = 'on' + eventName
	isSupported = eventName in el

	# Firefox workaround
	unless isSupported
		el.setAttribute(eventName, 'return;')
		isSupported = typeof el[eventName] == 'function'

	el = null;
	isSupported

supportedEvent = if isEventSupported('paste') then 'paste' else 'blur'

processCase = ->
	contents = inputTextArea.value

	lowerCaseLine = (line) ->
		newLine = []
		line = line.split('. ')
		line.forEach (sentence) ->
			sentence = sentence.charAt(0).toUpperCase() + sentence.substr(1).toLowerCase()
			# Replace: " i ", " i've", " i'm"  with uppercase
			sentence = sentence.replace(/\si(['|\s])/g, ' I$1')
			newLine.push(sentence)
		
		newLine = newLine.join('. ')

		# Capitalize after ?, ! punctuation marks
		capitalizeAfterPunctuation = (match) ->
			capital = match.substr(-1).toUpperCase()
			match.slice(0, -1) + capital;

		newLine.replace(/[\?|!]\s([a-z])/g, capitalizeAfterPunctuation)

	lines = contents.split('\n')
	lineGroup = []

	lines.forEach (line) ->
		lineGroup.push(lowerCaseLine(line))

	outputTextArea.value = lineGroup.join('\n')
	
inputTextArea.addEventListener('input', processCase, false)
outputTextArea.addEventListener 'focus', ->
	this.select()
	# Stop Webkit from unselecting stuff on mouseup
	window.setTimeout =>
		this.select()
	, 10