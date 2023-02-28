extends Node

func loadCSV(_file):
	var output: Array[Dictionary]
	
	var file = FileAccess.open(_file, FileAccess.READ)
	var text = file.get_as_text()
	var headers = []
	var isHeader = true
	for line in text.split('\n'):
		var values = line.split(',')
		if isHeader:
			for i in values.size():
				if values[i] == "\r": continue
				headers.append(values[i])
			isHeader = false
		else:
			output.append(dataPoint(headers, values))
	
	return output

func dataPoint(headers: Array, values: Array):
	var dataPoint: Dictionary = {}
	for i in values.size():
		if values[i] == "\r": continue
		dataPoint[headers[i]] = values[i]
	return dataPoint
