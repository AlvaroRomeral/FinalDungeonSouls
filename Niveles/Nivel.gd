extends Node2D

var puntuacion = 0
var ronda = 0

func _ready():
	Global.emit_signal("ronda_iniciada",ronda)
