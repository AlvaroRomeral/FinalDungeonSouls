extends Area2D

signal Interactuado

func _ready():
	pass

func interactuado():
	emit_signal("Interactuado")
