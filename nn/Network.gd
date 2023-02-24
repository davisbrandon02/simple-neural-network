class_name Network
extends Node

var layers: Array[Layer]
var outputLayer: Layer

func feedForward(_inputs):
	# feed through hidden layers
	var inputs: Array = _inputs
	for layer in layers:
		inputs = layer.feedForward(inputs)
	
	# feed these as inputs to the output layer
	return outputLayer.feedForward(inputs)

func _init(_layers: Array[Layer], _outputLayer: Layer):
	layers = _layers
	outputLayer = _outputLayer
