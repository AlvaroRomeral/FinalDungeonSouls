extends CharacterBody2D
class_name Enemigo

@export var control_estado:ControlEstado

func _ready():
	control_estado.muerto.connect(morir)


func morir():
	queue_free()
