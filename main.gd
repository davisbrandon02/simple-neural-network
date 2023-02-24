extends Node2D

var layer: Layer = Layer.new([Neuron.new([0,1], 0), Neuron.new([0,1], 0)])

func _ready():
	var network = Network.new([layer], Layer.new([Neuron.new([0,1], 0)]))
	print(network.feedForward([2,3]))
