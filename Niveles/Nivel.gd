extends Node2D

var puntuacion = 0
var ronda = 0
var spawners

func _ready():
	Global.emit_signal("ronda_iniciada",ronda)
	Global.connect("puntuacion_ganada",self,"setPuntuacion")
	get_tree().get_nodes_in_group("spawn")


func setPuntuacion(puntos):
	puntuacion += puntos
	
