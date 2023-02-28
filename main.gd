extends Node

var hLayer = Layer.new([Neuron.new(), Neuron.new(), Neuron.new(), Neuron.new()])
var hLayer2 = Layer.new([Neuron.new(), Neuron.new(), Neuron.new(), Neuron.new()])
var bestNetwork = Network.new([hLayer, hLayer2])

var batchSize: int = 50
var mutationRate: float = 0.1

var data

var auto: bool = false

func _ready():
	$BatchLabel/HSlider.value = batchSize
	$BatchLabel.text = 'Batch size: %s' % batchSize
	$MutationLabel.text = 'Mutations: %s' % mutationRate
	$MutationLabel/MutationSlider.value = mutationRate
	
	data = CsvLoader.loadCSV("res://data/gender.csv")
	var weights: Array = []
	var heights: Array = []
	for dataPoint in data:
		if dataPoint.has('Weight') and dataPoint.has('Height'):
			weights.append(int(dataPoint['Weight']))
			heights.append(int(dataPoint['Height']))
	Utils.meanWeight = Utils.mean(weights)
	Utils.meanHeight = Utils.mean(heights)
	
	if Utils.savedNetwork:
		bestNetwork = Utils.savedNetwork

func _on_h_slider_value_changed(value):
	batchSize = value
	$BatchLabel.text = 'Batch size: %s' % value

func _on_mutation_slider_value_changed(value):
	mutationRate = value
	$MutationLabel.text = 'Mutations: %s' % value

var networks: Array[Network]
var currentlyRunning: bool = false
func runGeneration():
	currentlyRunning = true
	networks.clear()
	
	var lowestLossNetwork = bestNetwork
	var lowestLoss: float = 1.0
	
	for i in batchSize:
		var batchNetwork = bestNetwork.copy()
		batchNetwork.mutate()
		networks.append(batchNetwork)
	
	var expectedOutputs: Array
	for dataPoint in data:
		if dataPoint.has('Gender') and dataPoint['Gender'] == 'male':
			expectedOutputs.append(1)
		elif dataPoint.has('Gender') and dataPoint['Gender'] == 'female':
			expectedOutputs.append(0)
	
	for _network in networks:
		var outputs: Array
		var losses: Array
		for dataPoint in data:
			if dataPoint.has('Weight') and dataPoint.has('Height'):
				var weight = int(dataPoint['Weight']) - Utils.meanWeight
				var height = int(dataPoint['Height']) - Utils.meanHeight
				var output = _network.feedForward([height, weight])
				outputs.append(output)
		var loss = Utils.calculateLoss(outputs, expectedOutputs)
		if loss < lowestLoss:
			lowestLossNetwork = _network
			lowestLoss = loss
			$LossLabel.text = 'Loss: %s' % loss
	
	bestNetwork = lowestLossNetwork
	currentlyRunning = false


func _on_auto_speed_timeout():
	if auto and not currentlyRunning:
		runGeneration()

func _on_auto_toggled(button_pressed):
	auto = button_pressed

func _on_speed_slider_value_changed(value):
	$AutoSpeed.wait_time = 1.0 / value

func _on_test_network_pressed():
	Utils.savedNetwork = bestNetwork
	get_tree().change_scene_to_file("res://trained_network_test.tscn")
