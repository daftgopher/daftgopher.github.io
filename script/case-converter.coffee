---
---

inputTextArea = document.querySelectorAll('#converterInput')[0]
outputTextArea = document.querySelectorAll('#converterOutput')[0]

processCase = ->
	contents = inputTextArea.value.toLowerCase()

	# 1. Uppercase first letter of each line.
	outputTextArea.value = contents.replace(/(^[a-z])/gm, (letter) -> letter.toUpperCase())

    # 2. Replace: " i ", " i've", " i'm"  with uppercase
    .replace(/\si('|\s)/gm, ' I$1')

    # 3. Uppercase first letter after ". ? !" characters
    .replace(/(\.|\?|!)\s+[a-z]/gm, (match) -> match.slice(0, -1) + match.substr(-1).toUpperCase())
	
inputTextArea.addEventListener('input', processCase, false)
outputTextArea.addEventListener 'focus', ->
	this.select()
	# Stop Webkit from unselecting stuff on mouseup
	window.setTimeout =>
		this.select()
	, 10