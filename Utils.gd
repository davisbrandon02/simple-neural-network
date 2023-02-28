extends Node

var savedNetwork: Network

var meanWeight: float
var meanHeight: float

func sigmoid(x, derivative:bool = false):
	if derivative:
		return x * (1 - x)
	
	return 1 / (1 + exp(-x))

func calculateLoss(trueValues, predictedValues):
	# Mean squared error loss
	var squaredErrors = []
	for i in trueValues.size():
		var error = trueValues[i][0] - predictedValues[i]
		var squaredError = error * error
		squaredErrors.append(squaredError)
	var sum: float = 0
	for sqError in squaredErrors:
		sum += sqError
	var mean = sum / squaredErrors.size()
	return mean

func mean(values: Array):
	var sum: float = 0
	var count: int = 0
	for i in values.size():
		sum += values[i]
		count += 1
	return sum / count
