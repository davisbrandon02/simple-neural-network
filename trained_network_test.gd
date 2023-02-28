extends Node

var network: Network = Utils.savedNetwork

var weight: int = 50
var height: int = 100

func _on_return_pressed():
	get_tree().change_scene_to_file("res://main.tscn")

func _on_weight_slider_value_changed(value):
	weight = value - Utils.meanWeight
	var output = network.feedForward([height, weight])[0]
	$OutputLabel.text = 'Output: %s' % output
	$Label/Label.text = '%s' % value

func _on_height_slider_value_changed(value):
	height = value - Utils.meanHeight
	var output = network.feedForward([height, weight])[0]
	$OutputLabel.text = 'Output: %s' % output
	$Label2/Label2.text = '%s' % value

func _on_button_pressed():
	var output = network.feedForward([height, weight])[0]
	print(output)
	$OutputLabel.text = 'Output: %s' % output
