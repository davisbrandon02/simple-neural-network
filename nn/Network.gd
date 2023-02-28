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

func _init(_layers: Array[Layer] = [], _outputLayer: Layer = Layer.new([Neuron.new()])):
	layers = _layers
	outputLayer = _outputLayer

func mutate(rate: float = 0.01):
	for layer in layers:
		for neuron in layer.neurons:
			neuron.mutate(rate)
	for neuron in outputLayer.neurons:
		neuron.mutate(rate)

func copy():
	var newNetwork = Network.new()
	
	for layer in layers:
		var newLayer = Layer.new([])
		for neuron in layer.neurons:
			var weights = neuron.weights
			var bias = neuron.bias
			newLayer.neurons.append(Neuron.new(weights, bias))
		newNetwork.layers.append(newLayer)
	
	var newOutputLayer = Layer.new([])
	for neuron in outputLayer.neurons:
		var weights = neuron.weights
		var bias = neuron.bias
		newOutputLayer.neurons.append(Neuron.new(weights, bias))
	newNetwork.outputLayer = newOutputLayer
	
	return newNetwork
