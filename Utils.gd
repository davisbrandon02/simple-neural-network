extends Node

func sigmoid(x, derivative:bool = false):
	if derivative:
		return x * (1 - x)
	
	return 1 / (1 + exp(-x))
