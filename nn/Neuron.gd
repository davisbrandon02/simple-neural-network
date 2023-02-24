class_name Neuron
extends Node

var weights: Array = []
var bias: float = 0
var output: int = 0

func feedForward(inputs):
	var weightedInputs: Array
	for i in inputs.size():
		var weightedInput = inputs[i] * weights[i]
		weightedInputs.append(weightedInput)
	
	var weightedSum: float = 0
	for i in weightedInputs:
		weightedSum += i
	
	var weightedSumWithBias = weightedSum + bias
	
	return Utils.sigmoid(weightedSumWithBias)

func _init(_weights: Array, _bias: float):
	weights = _weights
	bias = _bias
