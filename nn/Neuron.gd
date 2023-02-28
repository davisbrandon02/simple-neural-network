class_name Neuron
extends Node

var weights: Array = []
var bias: float = 0

func feedForward(inputs):
	if weights.size() < inputs.size():
		for i in (inputs.size() - weights.size()):
			weights.append(1)
	
	var weightedInputs: Array
	for i in inputs.size():
		var weightedInput = inputs[i] * weights[i]
		weightedInputs.append(weightedInput)
	
	var weightedSum: float = 0
	for i in weightedInputs:
		weightedSum += i
	
	var weightedSumWithBias = weightedSum + bias
	
	return Utils.sigmoid(weightedSumWithBias)

func _init(_weights: Array = [1,1], _bias: float = 0):
	weights = _weights
	bias = _bias

func mutate(rate: float = 0.01):
	randomize()
	for i in weights.size():
		weights[i] += randf_range(-rate, rate)
	bias += randf_range(-rate, rate)
