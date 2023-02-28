class_name Layer
extends Node

@export var neurons: Array[Neuron] = []

func feedForward(_inputs):
	var outputs: Array = []
	for n in neurons.size():
		outputs.append(neurons[n].feedForward(_inputs))
	return outputs

func _init(_neurons: Array[Neuron] = [Neuron.new()]):
	neurons = _neurons
