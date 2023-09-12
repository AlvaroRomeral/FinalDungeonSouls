extends Node
class_name CompVida

@export var hp:float = 1

func recibir_danno(cantidad:float):
	hp -= cantidad